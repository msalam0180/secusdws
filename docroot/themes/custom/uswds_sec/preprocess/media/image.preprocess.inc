<?php
/**
 * Implements hook_preprocess_HOOK().
 */
function uswds_sec_preprocess_image(array &$variables) {
  if (empty($variables['attributes']['alt'])) {
    $variables['attributes']['alt'] = '';
  }
}
