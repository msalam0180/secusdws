<?php

/**
 * @file
 * Preprocess function for this hook.
 */

/**
 * Implements hook_preprocess_input__radio().
 */
function uswds_preprocess_input__radio(&$variables) {
  $variables['attributes']['class'][] = 'usa-radio__input';
}
