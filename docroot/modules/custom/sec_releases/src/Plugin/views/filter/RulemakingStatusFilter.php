<?php

namespace Drupal\sec_releases\Plugin\views\filter;

use Drupal\Core\Form\FormStateInterface;
use Drupal\views\Plugin\views\filter\FilterPluginBase;
use Drupal\Core\Database\Connection;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Drupal\views\Plugin\views\display\DisplayPluginBase;
use Drupal\views\ViewExecutable;
use Drupal\Core\Entity\EntityTypeManagerInterface;

/**
 * Filter by rulemaking.
 *
 * @ingroup views_filter_handlers
 *
 * @ViewsFilter("rulemaking_status_filter")
 */
class RulemakingStatusFilter extends FilterPluginBase {

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

  protected $termOptions;

  /**
   * Constructs RulemakingStatusFilter object.
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

    $term_options = [];
    $vid = 'rule_type';
    $terms = $this->entityTypeManager->getStorage('taxonomy_term')->loadTree($vid, 0, 1);
    foreach ($terms as $term) {
      $terms_allowed = [
        'Proposed',
        'Final',
        'Interpretive',
        'Interim Final',
        'Concept',
      ];
      if (in_array($term->name, $terms_allowed)) {
        $term_options[$term->tid] = $term->name;
      }
    }

    $this->termOptions = $term_options;
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

  /**
   * {@inheritdoc}
   */
  public function init(ViewExecutable $view, DisplayPluginBase $display, array &$options = NULL) {
    parent::init($view, $display, $options);
    $this->valueTitle = $this->t("Rulemaking Status");
  }

  public function buildExposedForm(&$form, FormStateInterface $form_state) {


    $form['rulemaking_status'] = [
      '#type' => 'select',
      '#title' => t('Status'),
      '#options' => $this->termOptions,
      '#default_value' => $this->value ?? NULL,
      '#required' => FALSE,
      '#empty_option' => '- Any -',
    ];
  }

  public function query() {

    $input = $this->view->getExposedInput();
    $subquery = $this->database->select('node_field_data', 'sr_vf_status_nfd');
      $subquery->join('node__field_rule_type', 'sr_vf_rt_fpd', 'sr_vf_rt_fpd.entity_id = sr_vf_status_nfd.nid');
      $subquery->join('node__field_related_rule', 'sr_vf_status_frr', 'sr_vf_status_frr.field_related_rule_target_id = sr_vf_status_nfd.nid');

      $subquery
        ->condition('sr_vf_status_nfd.type', 'regulation')
        ->condition('sr_vf_status_nfd.status', 1)
        ->condition('sr_vf_status_frr.delta', '0');

    if (!empty($input['rulemaking_status']) && $input['rulemaking_status'] != '_none') {
      $subquery->condition('sr_vf_rt_fpd.field_rule_type_target_id', $input['rulemaking_status']);
    }
    else {
      $tids = array_keys($this->termOptions);
      $subquery->condition('sr_vf_rt_fpd.field_rule_type_target_id', $tids, 'IN');
    }

    $subquery->fields('sr_vf_status_frr', ['entity_id']);
    $this->query->addWhere(NULL, 'node_field_data.nid', $subquery, 'IN');
  }

  public function acceptExposedInput($input) {
    return TRUE;
  }

}
