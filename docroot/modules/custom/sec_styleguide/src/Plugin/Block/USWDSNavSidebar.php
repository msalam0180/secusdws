<?php

namespace Drupal\sec_styleguide\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Symfony\Component\Yaml\Parser;

/**
 * Provides a custom links block.
 *
 * @Block(
 *   id = "uswds_usa_side_nav",
 *   admin_label = @Translation("SEC Style Guide Side Navigation Block")
 * )
 */
class USWDSNavSidebar extends BlockBase {

  /**
   * {@inheritdoc}
   */
  public function build() {
    // D8 way of getting a module path.
    $module_handler = \Drupal::service('module_handler');
    $module_path = $module_handler->getModule('sec_styleguide')->getPath();
    // Define the path to the data file.
    $path_to_navigation = $module_path . '/data/uswds_navigation.yml';
    // Instantiate the Symfony YAML parser
    // as defined above in the use statement.
    $parser = new Parser();
    // Parse the data from the file.
    $nav_data = $parser->parse(file_get_contents($path_to_navigation));
    // Now derive the yml data array.
    $nav_yml = $nav_data["components"];

    foreach ($nav_yml as $element) {
      // Define the yaml path and the current path for comparison.
      $yml_path = $element["href"];
      // dump($yml_path);
      $current_path = \Drupal::service('path.current')->getPath();
      // dump($current_path);
      // Compare the paths.
      if ($yml_path == $current_path) {
        // Set the dynamic page title.
        $active_path = $element["title"];
        // dd($element);
      }
    }

    return [
      '#theme' => 'uswds_usa_side_nav',
      '#module_path' => $module_path,
      '#nav_yml' => $nav_yml,
      '#active_path' => $active_path,
    ];
  }

}
