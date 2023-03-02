<?php

/**
 * @file
 * Form-related hook implementations.
 */

/**
 * Implements hook_theme_suggestions_HOOK_alter().
 */
function uswds_sec_theme_suggestions_container_alter(array &$suggestions, array $variables) {
  $array_parents = isset($variables['element']['#array_parents']) ? $variables['element']['#array_parents'] : NULL;

  // Add parents as template suggestions.
  if (isset($array_parents)) {
    $ancestors = [];

    foreach ($array_parents as $value) {
      if (is_string($value)) {
        $ancestors[] = $value;
        $suggestions[] = 'container__' . implode('__', $ancestors);
      }
    }
  }

  // Add Views-related template suggestions.
  if (isset($variables['element']['#type']) && $variables['element']['#type'] !== 'container') {
    $suggestions[] = 'container__' . $variables['element']['#type'];

    if (isset($variables['element']['#name'])) {
      $suggestions[] = 'container__' . $variables['element']['#type'] . '__' . $variables['element']['#name'];
    }
  }

  $pattern = '';
  $type = '';
  if (isset($variables['element']['#theme'])) {
    $haystack = $variables['element']['#theme'];
    $needle   = 'pattern_';

    if (strpos($haystack, $needle) !== false) {
      $pattern = 'pattern_preview';
    }

    array_unshift($suggestions, 'container__' . $pattern);
  }

}

/**
 * Implements hook_theme_suggestions_HOOK_alter().
 */
function uswds_sec_theme_suggestions_form_alter(array &$suggestions, array $variables) {
  if (isset($variables['element']['#form_id'])) {
    $suggestions[] = 'form__' . $variables['element']['#form_id'];
  }
}

/**
 * Implements hook_theme_suggestions_HOOK_alter().
 */
function uswds_sec_theme_suggestions_form_element_alter(array &$suggestions, array $variables) {
  $id = isset($variables['element']['#id']) ? $variables['element']['#id'] : NULL;
  $type = isset($variables['element']['#type']) ? $variables['element']['#type'] : NULL;

  if (isset($type)) {
    $suggestions[] = 'form-element__' . $type;
  }

  if (isset($id)) {
    $suggestions[] = 'form-element__' . $id;
  }
}
