<?php
/**
 * Implements hook_preprocess_HOOK().
 */
function uswds_sec_preprocess_views_view(array &$variables) {
  $variables['path'] = $variables['view']->getRequest()->getPathInfo();
}
