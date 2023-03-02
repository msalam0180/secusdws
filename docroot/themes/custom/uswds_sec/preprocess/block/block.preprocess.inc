<?php

/**
 * Implements hook_preprocess_HOOK() for block.html.twig.
 */
function uswds_sec_preprocess_block(&$variables) {

  // adding custom attribute class for block
  if ($variables['elements']['#base_plugin_id'] == 'block_content') {
    $blockType = strtr($variables['content']['#block_content']->bundle(), '_', '-');
    $variables['attributes']['class'][] = 'block--type-' . $blockType;
  }
}