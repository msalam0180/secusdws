<?php

/**
 * @file
 * Preprocess function for this hook.
 */

/**
 * Implements hook_preprocess_menu_local_tasks().
 */
function uswds_sec_preprocess_menu_local_tasks(&$variables) {
  if (!empty($variables['primary'])) {
    foreach ($variables['primary'] as $menu_item_key => $menu_attributes) {
      $variables['primary'][$menu_item_key]['#link']['localized_options']['attributes']['class'][] = 'usa-button--base';
    }
  }
}
