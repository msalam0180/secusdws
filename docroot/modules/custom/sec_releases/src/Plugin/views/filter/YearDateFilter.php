<?php

namespace Drupal\sec_releases\Plugin\views\filter;

use Drupal\Core\Form\FormStateInterface;
use Drupal\views\Plugin\views\filter\FilterPluginBase;
use Drupal\Core\Database\Connection;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Drupal\Core\Entity\EntityTypeManagerInterface;
use Drupal\views\Plugin\ViewsHandlerManager;
use Drupal\views\Plugin\views\display\DisplayPluginBase;
use Drupal\views\ViewExecutable;

/**
 * Filter by last action date.
 *
 * @ingroup views_filter_handlers
 *
 * @ViewsFilter("regulation_year_date_filter")
 */
class YearDateFilter extends FilterPluginBase {

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
   *  The join manager.
   *
   * @var \Drupal\views\Plugin\ViewsHandlerManager
   */
  protected $joinManager;

  /**
   * Constructs YearDateFilter object.
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
   * @param \Drupal\views\Plugin\ViewsHandlerManager $join_manager
   *   The views plugin join manager.
   */
  public function __construct(array $configuration, $plugin_id, $plugin_definition, Connection $connection,
                              EntityTypeManagerInterface $entity_type_manager, ViewsHandlerManager $join_manager) {
    $this->database = $connection;
    $this->entityTypeManager = $entity_type_manager;
    $this->joinManager = $join_manager;
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
      $container->get('entity_type.manager'),
      $container->get('plugin.manager.views.join')
    );
  }

  /**
   * {@inheritdoc}
   */
  public function init(ViewExecutable $view, DisplayPluginBase $display, array &$options = NULL) {
    parent::init($view, $display, $options);
    $this->valueTitle = $this->t("Last Action Date");
  }

  public function buildExposedForm(&$form, FormStateInterface $form_state) {

    $years = range(date("Y"), 2000);
    $year_options = array_combine($years, $years);
    $form['regulation_year'] = [
      '#type' => 'select',
      '#title' => t('Last Action Date'),
      '#options' =>$year_options,
      '#default_value' => $this->value ?? NULL,
      '#required' => FALSE,
      '#empty_option' => '- Any -',
    ];
  }

  public function query() {

    $input = $this->view->getExposedInput();

    if (!empty($input['regulation_year']) && $input['regulation_year'] != '_none') {
      $subquery = $this->database->select('node_field_data', 'sr_vf_nfd');
      $subquery->join('node__field_publish_date', 'sr_vf_fpd', 'sr_vf_fpd.entity_id = sr_vf_nfd.nid');
      $subquery->join('node__field_related_rule', 'sr_vf_frr', 'sr_vf_frr.field_related_rule_target_id = sr_vf_nfd.nid');

      $subquery
        ->condition('sr_vf_nfd.type', 'regulation')
        ->condition('sr_vf_nfd.status', 1)
        ->fields('sr_vf_frr', ['entity_id'])
        ->groupBy('sr_vf_frr.entity_id');
      $subquery->addExpression('MAX(sr_vf_fpd.field_publish_date_value)', 'field_publish_date');

      $join_array = [
        'type' => 'INNER',
        'table formula' => $subquery,
        'field' => 'entity_id',
        'left_table' => 'node_field_data',
        'left_field' => 'nid',
        'adjust' => TRUE,
      ];

      $join = $this->joinManager->createInstance('standard', $join_array);
      $this->query->addRelationship('last_action_date', $join, 'node_field_data');

      $this->query->addWhere(0, 'last_action_date.field_publish_date', $this->database->escapeLike($input['regulation_year']) . '%', 'LIKE');

    }

  }

  public function acceptExposedInput($input) {
    return TRUE;
  }

}
