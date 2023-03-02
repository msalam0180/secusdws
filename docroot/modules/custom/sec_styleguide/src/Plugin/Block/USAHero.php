<?php

namespace Drupal\sec_styleguide\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a custom links block.
 *
 * @Block(
 *   id = "uswds_usa_hero",
 *   admin_label = @Translation("USWDS Hero Block")
 * )
 */
class USAHero extends BlockBase {

  /**
   * {@inheritdoc}
   */
  public function build() {
    // D8 way of getting a module path.
    $module_handler = \Drupal::service('module_handler');
    // Add the theme handler service.
    $themeHandler = \Drupal::service('theme_handler');
    $module_path = $module_handler->getModule('sec_styleguide')->getPath();
    // Set a var for the theme path.
    $theme_path = $themeHandler->getTheme($themeHandler->getDefault())
      ->getPath();

    $hero_title_callout = t('Welcome!');
    $hero_title = t('Explore Washington, DC!');
    $hero_text = t('Plan your trip ahead of time for the best experience');
    $hero_button_cta = t('Learn more');
    $hero_button_cta_class = t('usa-button');
    $hero_image = 'andy-feliciotti-VBU2sowf-nw-unsplash.jpg';

    return [
      '#theme' => 'uswds_usa_hero',
      '#theme_path' => $theme_path,
      '#module_path' => $module_path,
      '#hero_title' => $hero_title,
      '#hero_title_callout' => $hero_title_callout,
      '#hero_text' => $hero_text,
      '#hero_button_cta' => $hero_button_cta,
      '#hero_button_cta_class' => $hero_button_cta_class,
      '#hero_image' => $hero_image,
    ];
  }

}
