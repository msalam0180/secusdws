<?php

/**
 * @file
 * Preprocess function for this hook.
 */

/**
 * Implements hook_preprocess_input__number().
 */
function uswds_preprocess_input__number(&$variables) {
  $variables['attributes']['class'][] = 'usa-input';
}
