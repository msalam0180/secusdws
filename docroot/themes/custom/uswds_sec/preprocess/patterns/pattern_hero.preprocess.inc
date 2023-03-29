<?php

function uswds_sec_preprocess_pattern_hero(array &$variables) {
  // get the homepage path
  $config = \Drupal::config('system.site');
  $front_uri = $config->get('page.front');
  $front_uri_alias = \Drupal::service('path_alias.manager')->getAliasByPath($front_uri);

  // get current path
  $current_uri = \Drupal::request()->getRequestUri();

  $variables['use_full_width'] = $front_uri_alias . "/layout" == $current_uri ? false : true;
}