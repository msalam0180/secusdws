<?php

use Drupal\Core\Field\EntityReferenceFieldItemList as EntityReferenceFieldItemListAlias;
use Drupal\layout_builder\Section;
use Drupal\layout_builder\SectionComponent;
use Drupal\node\Entity\Node;

/**
 * Implements hook_preprocess_template().
 */
function uswds_sec_preprocess_pattern_card_person(&$variables): void {
  // Fix layout builder preview.
  $form_data = Drupal::request()->get('settings');
  $request_destination = Drupal::request()->query->get('destination');
  $trigger = $_REQUEST["_triggering_element_value"];
  $person = $variables['context']->getProperty('entity');

  $path = explode('/', $request_destination);
  [, $entity_type, $nid,] = $path;

  // When adding a new block
  if ($trigger == 'Add block') {
    _contentUpdate($person, $form_data, $variables, ['nid: ' .$person->id()]);
  }

  // When updating block
  if ($entity_type == 'node' && $nid && $trigger == 'Update' && $form_data) {
    /** @var \Drupal\node\Entity\Node $node */
    $node = Drupal::entityTypeManager()
      ->getStorage($entity_type)
      ->load($nid);
    if ($node) {
      // Show other content for the blocks of person card not being updated.
      _process_block_components($node, $variables, $form_data, $trigger);
    }
  }

  // This part is assigning show photo and heading level values for twig
  // when not in layout builder page.
  $node = \Drupal::request()->attributes->get('node');
  if (empty($node)) {
    return;
  }
  _process_block_components($node, $variables);

}

/**
 * Update block preview.
 *
 * @param Node $entity
 * @param array $form_data
 *
 * @return bool
 */
function _updatePreview(Node $entity, array $form_data): bool {
  $person_card_ids = $form_data["block_form"]["field_person_card"];
  foreach ($person_card_ids as $person_card_id) {
    if (str_contains($person_card_id['target_id'], $entity->id())) {
      return TRUE;
    }
  }
  return FALSE;
}

/**
 * Update block content in Preview of Layout builder.
 *
 * @param Node $entity
 * @param array $form_data
 * @param $variables
 * @param array $tags
 *   Cache tags.
 *
 * @return void
 */
function _contentUpdate(Node $entity, array $form_data, &$variables, array $tags = []): void {
  $title = _position_title($entity);
  _updateField('title', $title, $variables, $tags);
  $hl = $form_data['block_form']['field_heading_level'];
  _updateField('heading_level', $hl, $variables, $tags);
  $sp = isset($form_data['block_form']['field_show_photo']['value']);
  _updateField('show_photo', $sp, $variables, $tags);
  $se = isset($form_data['block_form']['field_show_email']['value']);
  _updateField('show_email', $se, $variables, $tags);
  $st = isset($form_data['block_form']['field_show_phone']['value']);
  _updateField('show_phone', $st, $variables, $tags);
}

/**
 * Update the Variables for specific field data.
 *
 * @param $variable_field
 * @param $value
 * @param $variables
 * @param array $tags
 *
 * @return void
 */
function _updateField($variable_field, $value, &$variables, array $tags = []): void {
  if (empty($value)) {
    // This is when Layout builder does not return the form values when value
    // is 0, meaning the user selected show photo to OFF.
    // We need to establish back the variable and set this to 0 or default state.
    if ($variable_field == 'heading_level') {
      $value = 2; // Set default.
    }
    elseif ($variable_field == 'title') {
      $value = null; // Title is allowed to have null value.
    }
    else {
      $value = 0; // For boolean types i.e. show photo, show email, show phone.
    }
  }
  $variables[$variable_field] = [
    '#markup' => $value,
    '#cache' => [
      'contexts' => ['url.path', 'url.query_args', 'user.roles'],
      'max-age' => 0,
      'tags' => $tags,
    ],
  ];
}

/**
 * Process person_card block components to pass custom data.
 *
 * @param $node
 * @param $variables
 * @param $form_data
 *   This is the data submitted when updating the block content.
 *
 * @return void
 */
function _process_block_components($node, &$variables, $form_data = '', $op = ''): void {
  // Process position
  $bundle = $node->bundle();
  if ($bundle !== 'landing_page') {
    return;
  }
  $flush_cache = FALSE;
  $section_list = $node->layout_builder__layout->getValue();
// Preview of landing page is new update state.
  $person = $variables['context']->getProperty('entity');
  if (count($section_list) == 0 && $op == 'Update' && $person->getType() == 'secperson' && $form_data) {
    _contentUpdate($person, $form_data, $variables, ['nid: ' .$person->id()]);
  }
// end.
  else {
    foreach ($section_list as $section) {
      /** @var Section $components */
      $components = $section['section']->getComponents();
      /** @var SectionComponent $component */
      foreach ($components as $component) {
        /** @var Section $configuration */
        $configurations = $component->toArray();
        $id = $configurations['configuration']['id'];

        // Person card block.
        if ($id === 'inline_block:person_card') {
          $flush_cache = TRUE;
          // Get block id.
          $bid = $configurations['configuration']['block_revision_id'];
          $block_entity = Drupal::service('entity_type.manager')
            ->getStorage('block_content')
            ->loadRevision($bid);
          $entity_blkid = $block_entity->get('field_person_card');

          // Filter the entity ids if they belong to the group.
          /** @var EntityReferenceFieldItemListAlias $entity_blkid */
          foreach ($entity_blkid->referencedEntities() as $entity) {
            $update_entity_id = $variables['context']->getProperty('entity_id');
            // Refresh the field that is requested within the block.
            if ($update_entity_id == $entity->nid->value) {
              $tags = ['nid:' . $entity->id(), 'block_content:' . $bid];
              if (!empty($form_data) && _updatePreview($entity, $form_data)) {
                $component_label = $component->get('configuration')['label'];
                $form_label = $form_data['label'];
                // Check if correct content block is being updated.
                if ($component_label == $form_label) {
                  _contentUpdate($entity, $form_data, $variables, $tags);
                }
              }
              else {
                _updateField('show_email', $block_entity->get('field_show_email')->value, $variables, $tags);
                _updateField('show_phone', $block_entity->get('field_show_phone')->value, $variables, $tags);
                _updateField('show_photo', $block_entity->get('field_show_photo')->value, $variables, $tags);
                _updateField('heading_level', $block_entity->get('field_heading_level')->value, $variables, $tags);
                _updateField('title', _position_title($entity), $variables, $tags);
              }
            }
          }
        }
      }
    }
  }
  if ($flush_cache) {
    $variables['#cache'] = ['max-age' => 0];
  }
}

/**
 * Process logic for displaying title.
 *
 * @param $entity
 *
 * @return mixed|string
 */
function _position_title($entity) {
  // This part is to process logic in displaying Position title.
  $paragraphs = $entity->field_position_history_paragraph->referencedEntities();
  $use_from_date = new Drupal\Core\Datetime\DrupalDateTime('1980-1-1');
  $use_from_date = $use_from_date->getTimestamp();
  $checked_current_position = '';
  $unchecked_current_position = '';

  foreach ($paragraphs as $paragraph) {
    $current_position = $paragraph->get('field_current_position')->value;
    // Select this checked position.
    if ($current_position) {
      $checked_current_position = $paragraph->field_position_title->value;
    }
    // Process unchecked current position.
    if (empty($current_position) && empty($checked_current_position)) {
      $from = $paragraph->get('field_from')->date->getTimestamp();
      if ($from >= $use_from_date) {
        // set the most recent position
        $use_from_date = $from;
        $unchecked_current_position = $paragraph->field_position_title->value;
      }
    }
  }
  // First rule is if current position field is checked, then return it's
  // respective position title field.
  if ($checked_current_position) {
    return $checked_current_position;
  }
  // else if none of current position field is checked, return the field having
  // the most recent field from date.
  else {
    return $unchecked_current_position;
  }
}

