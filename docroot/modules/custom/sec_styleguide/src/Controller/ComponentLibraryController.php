<?php

namespace Drupal\sec_styleguide\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\Yaml\Parser;

/**
 * Class ComponentLibraryController View.
 */
class ComponentLibraryController extends ControllerBase {

  /**
   * The main components page.
   *
   * @inheritdoc
   */
  public function view(): array {
    // Module paths and handlers.
    $module_handler = \Drupal::service('module_handler');
    $module_path = $module_handler->getModule('sec_styleguide')->getPath();
    // Define the path to the data file.
    $path_to_navigation = $module_path . '/data/uswds_navigation.yml';
    $path_to_colors = $module_path . '/data/usa_colors.yml';
    // Instantiate the Symfony YAML parser
    // as defined above in the use statement.
    $parser = new Parser();
    // Parse the data from the file.
    $nav_data = $parser->parse(file_get_contents($path_to_navigation));
    $colors_data = $parser->parse(file_get_contents($path_to_colors));
    // Now derive the yml data array.
    $config_data = $nav_data["components"];

    // Sort alphabetically by component title
    usort($config_data, function($a, $b) {
        return $a['title'] <=> $b['title'];
    });

    $config_colors_data = $colors_data["colors_content"];

    return [
      '#theme' => 'uswds_components',
      '#config_data' => $config_data,
      '#module_path' => $module_path,
      '#colors_yml' => $config_colors_data,
    ];

  }

  /**
   * Returns a page title.
   */
  public function getTitle() {
    // Module paths and handlers.
    $module_handler = \Drupal::service('module_handler');
    $module_path = $module_handler->getModule('sec_styleguide')->getPath();
    $parser = new Parser();
    // Define the path to the data file.
    $path_to_title = $module_path . '/data/uswds_navigation.yml';
    // Parse the data from the file.
    $title_data = $parser->parse(file_get_contents($path_to_title));
    // Define the empty title array.
    $title = [];
    foreach ($title_data["components"] as $element) {
      // Define the yaml path and the current path for comparison.
      $yml_path = $element["href"];
      $current_path = \Drupal::service('path.current')->getPath();
      // Compare the paths.
      if ($yml_path == $current_path) {
        // Set the dynamic page title.
        // $title = t('USWDS') . ' ' . $element["title"];
        $title = $element["title"];
      }
    }
    return $title;

  }

  /**
   * Dynamic template files & YAML data.
   */
  public function subpage($path): array {
    // Repeat the same code as per above to pull in YAML files.
    $module_handler = \Drupal::service('module_handler');
    $module_path = $module_handler->getModule('sec_styleguide')->getPath();
    // Define the yaml parser.
    $parser = new Parser();

    // @todo refactor pulling YAML below as arrays.
    // Data paths.
    $path_to_content = $module_path . '/data/content.yml';
    $path_to_alert = $module_path . '/data/usa_alert.yml';
    $path_to_button = $module_path . '/data/usa_button.yml';
    $path_to_card = $module_path . '/data/usa_card.yml';
    $path_to_collection = $module_path . '/data/usa_collection.yml';
    $path_to_icon = $module_path . '/data/usa_icon.yml';
    $path_to_icon = $module_path . '/data/usa_icon.yml';
    $path_to_component_details = $module_path . '/data/uswds_navigation.yml';


    // Parse the data.
    $content_data = $parser->parse(file_get_contents($path_to_content));
    $alert_data = $parser->parse(file_get_contents($path_to_alert));
    $button_data = $parser->parse(file_get_contents($path_to_button));
    $card_data = $parser->parse(file_get_contents($path_to_card));
    $collection_data = $parser->parse(file_get_contents($path_to_collection));
    $icon_data = $parser->parse(file_get_contents($path_to_icon));
    $component_details_data = $parser->parse(file_get_contents($path_to_component_details));

    // dd($navigation_data );
    // Set the content YML data file.
    $config_content_data = $content_data["content_config"];
    $config_alert_data = $alert_data["alert_content"];
    $config_button_data = $button_data["button_content"];
    $config_card_data = $card_data["card_content"];
    $config_collection_data = $collection_data["collection_content"];
    $config_icon_data = $icon_data["icon_content"];
    // Dynamic method of creating a path for every
    // template file in this module's templates directory.
    // e.g. /sec-styleguide/usa-accordion will use
    // the usa-accordion.html.twig theme file.
    $path = str_replace('-', '_', $path);
    // Return variables for use in templates.

    // dump($component_details_data["components"][8]);
    foreach ($component_details_data["components"] as $element) {
      // Define the yaml path and the current path for comparison.
      $yml_path = $element["href"];
      // dump($yml_path);
      $current_path = \Drupal::service('path.current')->getPath();
      // dump($current_path);
      // Compare the paths.
      if ($yml_path == $current_path) {
        // Set the dynamic page title.
        $component_data = $element;
        // dd($component_data);
      }
    }
    return [
      '#theme' => $path,
      '#content_yml' => $config_content_data,
      '#alert_yml' => $config_alert_data,
      '#button_yml' => $config_button_data,
      '#card_yml' => $config_card_data,
      '#collection_yml' => $config_collection_data,
      '#icon_yml' => $config_icon_data,
      '#component_yml' => $component_data,
      '#module_path' => $module_path,
    ];
  }

}
