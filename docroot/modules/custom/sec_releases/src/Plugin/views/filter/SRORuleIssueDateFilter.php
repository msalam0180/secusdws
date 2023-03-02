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
 * Filter by sec issue date.
 *
 * @ingroup views_filter_handlers
 *
 * @ViewsFilter("sro_rule_issue_date_filter")
 */
class SRORuleIssueDateFilter extends FilterPluginBase {

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
    $this->valueTitle = $this->t("SEC Issue Date Year/Month Filter");
  }

  public function buildExposedForm(&$form, FormStateInterface $form_state) {

    $years = range(date("Y"), 2000);
    $year_options = array_combine($years, $years);
    $month_options = array_reduce(range(1,12),function($rslt,$m){ $rslt[$m] = date('F',mktime(0,0,0,$m,10)); return $rslt; });
    $form['regulation_year'] = [
      '#type' => 'select',
      '#title' => t('Year'),
      '#options' =>$year_options,
      '#default_value' => $this->value ?? NULL,
      '#required' => FALSE,
      '#empty_option' => '- Any -',
    ];
    $form['regulation_month'] = [
      '#type' => 'select',
      '#title' => t('Month'),
      '#options' =>$month_options,
      '#default_value' => $this->value ?? NULL,
      '#required' => FALSE,
      '#empty_option' => '- Any -',
      '#states' => [
        'invisible' => [
          ':input[name="regulation_year"]' => ['value' => ''],
        ],
      ],
    ];
  }

  public function query() {

    $input = $this->view->getExposedInput();

    if (!empty($input['regulation_year']) && $input['regulation_year'] != '_none') {
      $year = $input['regulation_year'];
      $date_string = $year;

      if (!empty($input['regulation_month']) && $input['regulation_month'] != '_none') {
        $month = str_pad($input['regulation_month'], 2, "0");
        $date_string .= "-{$month}";
      }

      $this->query->addWhere(0, 'node__field_publish_date.field_publish_date_value', $this->database->escapeLike($date_string) . '%', 'LIKE');
    }

  }

  public function acceptExposedInput($input) {
    return TRUE;
  }

}
