<?php

/**
 * @file
 * Taxonomy-related hook implementations.
 */


/**
 * Implements hook_theme_suggestions_HOOK_alter().
 */
function uswds_sec_theme_suggestions_taxonomy_term_alter(array &$suggestions, array $variables) {
  $bundle = $variables['elements']['name']['#bundle'];
  $view_mode = $variables['elements']['#view_mode'];
  $suggestions[] = 'taxonomy_term__' . $view_mode;
  $suggestions[] = 'taxonomy_term__' . $bundle . '__' . $view_mode;
}
