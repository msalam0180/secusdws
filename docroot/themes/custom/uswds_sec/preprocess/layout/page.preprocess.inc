<?php

use Drupal\Core\Config\Config;

/**
 * Implements hook_preprocess_HOOK().
 */
function uswds_sec_preprocess_page(&$variables) {
  // preprocess page

  $node = $variables['node'];
  
  // Is this node using the Node Details Layout
  if ($node) {
    $layout = Drupal::service('entity_display.repository')->getFormDisplay('node', $node->bundle());
    if ($layout) {
      $entity_display = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load($layout->id());
      $ds = $entity_display->getThirdPartySettings('ds');
      if (isset($ds['layout']['id']) && $ds['layout']['id'] == 'node_details_layout') {
        $variables['isUsingNodeDetailsLayout'] = True;
      }
      else
        $variables['isUsingNodeDetailsLayout'] = False;
    }
  }

  // get the homepage path
  $config = \Drupal::config('system.site');
  $front_uri = $config->get('page.front');
  $front_uri_alias = \Drupal::service('path_alias.manager')->getAliasByPath($front_uri);
  $variables['front_uri_alias'] = $front_uri_alias;

  // get current path
  $current_uri = \Drupal::request()->getRequestUri();
  $variables['current_uri'] = $current_uri;

  // Is front or layout for front
  $variables['is_front_plus'] = $variables['is_front'] || $variables['front_uri_alias'] . "/layout" == $current_uri ? true : false;

  // Is an error page
  // Check if current request is an exception to get error type
  $status = \Drupal::requestStack()->getCurrentRequest()->attributes->get('exception');

  if ($status) {
    $variables['attributes']['class'][] = 'error-page';
    $variables['is_error_page'] = true;
    $variables['is_sidenav_hidden'] = true;
  }
  if ($status && $status->getStatusCode() == 404) {
      $variables['attributes']['class'][] = 'path-error-404';
  }
  if ($status && $status->getStatusCode() == 403) {
      $variables['attributes']['class'][] = 'path-error-404';
  }
}
