<?php

/**
 * @file
 * Preprocess function for this hook.
 */

/**
 * Implements hook_preprocess_input__checkbox().
 */
function uswds_preprocess_input__checkbox(&$variables) {
  $variables['attributes']['class'][] = 'usa-checkbox__input';
}
