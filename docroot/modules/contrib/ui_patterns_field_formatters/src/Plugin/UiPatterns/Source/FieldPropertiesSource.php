<?php

namespace Drupal\ui_patterns_field_formatters\Plugin\UiPatterns\Source;

use Drupal\Core\Field\FieldTypePluginManager;
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Drupal\ui_patterns\Plugin\PatternSourceBase;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Defines Field values source plugin.
 *
 * @UiPatternsSource(
 *   id = "field_properties",
 *   label = @Translation("Field properties"),
 *   tags = {
 *     "field_properties"
 *   }
 * )
 */
class FieldPropertiesSource extends PatternSourceBase implements ContainerFactoryPluginInterface {

  /**
   * The field_type plugin manager.
   *
   * @var \Drupal\Core\Field\FieldTypePluginManager
   */
  protected FieldTypePluginManager $fieldTypeManager;

  /**
   * {@inheritdoc}
   */
  public function getSourceFields() {
    $sources = [];
    $storageDefinition = $this->getContextProperty('storageDefinition');
    $fields = $storageDefinition->getPropertyNames();
    foreach ($fields as $field) {
      if (!$this->getContextProperty('limit')) {
        $sources[] = $this->getSourceField($field, $storageDefinition->getPropertyDefinition($field)->getLabel());
      }
      elseif (in_array($field, $this->getContextProperty('limit'))) {
        $sources[] = $this->getSourceField($field, $storageDefinition->getPropertyDefinition($field)->getLabel());
      }
    }

    // Support selecting displayed value for options based fields.
    $fieldClass = $this->fieldTypeManager->getDefinition($storageDefinition->getType())['class'];
    if (is_subclass_of($fieldClass, 'Drupal\Core\TypedData\OptionsProviderInterface')) {
      $sources[] = $this->getSourceField('_value_display', 'Displayed value');
    }

    $sources[] = $this->getSourceField('_label', 'Label');
    return $sources;
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition) {
    $instance = new static($configuration, $plugin_id, $plugin_definition);
    $instance->fieldTypeManager = $container->get('plugin.manager.field.field_type');
    return $instance;
  }

}
