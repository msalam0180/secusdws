<?php

namespace Drupal\sec_releases\Plugin\views\filter;

use Drupal\Core\Form\FormStateInterface;
use Drupal\views\Plugin\views\filter\FilterPluginBase;
use Drupal\Core\Database\Connection;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Drupal\Core\Entity\EntityTypeManagerInterface;

/**
 * Filter by division/office.
 *
 * @ingroup views_filter_handlers
 *
 * @ViewsFilter("division_office_filter")
 */
class DivisionOfficeFilter extends FilterPluginBase {

  /**
   * The database connection.
   *
   * @var \Drupal\Core\Database\Connection
   */
  protected $database;

  /**
   * The entity type manager.
   *
   * @var \Drupal\Core\Entity\EntityTypeManagerInterface
   */
  protected $entityTypeManager;

  /**
   * Constructs DivisionOfficeFilter object.
   *
   * @param array $configuration
   *   Configuration array.
   * @param [type] $plugin_id
   *   Plugin ID.
   * @param [type] $plugin_definition
   *   Plugin definition.
   * @param \Drupal\Core\Database\Connection $connection
   *   Database connection.
   * @param \Drupal\Core\Entity\EntityTypeManagerInterface $entity_type_manager
   *   Entity type manager.
   */
  public function __construct(array $configuration, $plugin_id, $plugin_definition, Connection $connection, EntityTypeManagerInterface $entity_type_manager) {
    $this->database = $connection;
    $this->entityTypeManager = $entity_type_manager;
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition) {
    return new static(
      $configuration,
      $plugin_id,
      $plugin_definition,
      $container->get('database'),
      $container->get('entity_type.manager')
    );
  }

  public function buildExposedForm(&$form, FormStateInterface $form_state) {
    $terms = $this->entityTypeManager->getStorage('taxonomy_term')->loadTree('division_office');
    $term_options = [];

    foreach ($terms as $term) {
      $term_options[$term->tid] = $term->name;
    }

    asort($term_options);

    $form['division_office'] = [
      '#type' => 'select',
      '#title' => t('Division/Office'),
      '#options' => $term_options,
      '#empty_option' => 'All Divisions',
      '#default_value' => $this->value ?? NULL,
    ];
  }

  public function query() {

    $input = $this->view->getExposedInput();

    if (!empty($input['division_office'])) {
      $subquery = $this->database->select('node_field_data', 'srnfd');
      $subquery->join('node__field_primary_division_office', 'srnfpdo', 'srnfpdo.entity_id = srnfd.nid');
      $subquery->join('node__field_release_file_number', 'srnfrfn', 'srnfrfn.entity_id = srnfd.nid');
      $subquery->join('taxonomy_term_field_data', 'srtfd2', 'srtfd2.tid = srnfrfn.field_release_file_number_target_id');

      $subquery
        ->condition('srnfd.type', 'regulation')
        ->condition('srnfd.status', 1)
        ->condition('srnfpdo.field_primary_division_office_target_id', $input['division_office'])
        ->fields('srtfd2', ['name']);

      $this->query->addWhere(0, 'taxonomy_term_field_data.name', $subquery, 'IN');
    }

  }

  public function acceptExposedInput($input) {
    return TRUE;
  }

}
