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

    // get image for landing page header
    $hasFeatGraphic = isset($node->field_featured_graphic) && !$node->field_featured_graphic->isEmpty();
    $featuredGraphic = $hasFeatGraphic ? file_create_url($node->field_featured_graphic->entity->getFileUri()) : "";

    // get event add to calnedar
    $hasAddToCalendar = isset($node->field_add_to_calendar) && !$node->field_add_to_calendar->isEmpty();
    $addToCalendar = $hasAddToCalendar && ($node->field_add_to_calendar->value == 1) ? $node->field_add_to_calendar->view(['label' => 'hidden']) : "";

    $pageDescription = isset($node->field_description_abstract) ? $node->field_description_abstract->value : "";

    $contentType = $node->bundle();

    $variables['title'] = $pageTitle;
    $variables['page_description'] = $pageDescription;
    $variables['content_type'] = $contentType;
    $variables['field_featured_graphic'] = $featuredGraphic;
    $variables['field_add_to_calendar'] = $addToCalendar;
  }

  /**
   * Logic to show parts of the title of the title
   */

  $variables['show_above_title'] = true;
  $variables['show_breadcrumbs'] = true;
  $variables['show_page_category'] = true;

  if ($variables['show_page_category'] == true) {
    // TODO: set category values
    $variables['page_category_text'] = "Page Category";
    $variables['page_category_path'] = "/";
  }

  $status = \Drupal::requestStack()->getCurrentRequest()->attributes->get('exception'); // Is an error page

  if ($status) {
    $variables['show_above_title'] = false;
    $variables['show_breadcrumbs'] = false;
  }else{
    $variables['show_above_title'] = true;
    $variables['show_breadcrumbs'] = true;
  }

}
