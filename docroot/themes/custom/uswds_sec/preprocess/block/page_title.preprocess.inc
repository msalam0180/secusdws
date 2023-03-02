<?php

/**
 * @file
 * Preprocess function for this hook.
 */

/**
 * Implements hook_preprocess_page_title().
 */
function uswds_sec_preprocess_page_title(&$variables) {
  $variables['title_attributes']['class'][] = 'uswds-page-title';

   // If Node Page
   $node = \Drupal::request()->attributes->get('node');
   if (is_string($node)) {
     $node = Node::load($node);
   }
   if ($node && !is_string($node)) {

    $pageTitle = isset($node->field_display_title->value) ? $node->field_display_title->value : $node->label();

    $hasFeatGraphic = isset($node->field_featured_graphic) && !$node->field_featured_graphic->isEmpty();
    $featuredGraphic = $hasFeatGraphic ? file_create_url($node->field_featured_graphic->entity->getFileUri()) : "";

    $pageDescription = isset($node->field_description_abstract) ? $node->field_description_abstract->value : "";

    $contentType = $node->bundle();

    $variables['title'] = $pageTitle;
    $variables['page_description'] = $pageDescription;
    $variables['content_type'] = $contentType;
    $variables['field_featured_graphic'] = $featuredGraphic;
  }
}
