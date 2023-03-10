<?php

namespace Drupal\ui_patterns_field_formatters\Plugin\Field\FieldFormatter;

use Drupal\Core\Entity\Plugin\DataType\EntityReference;
use Drupal\Core\Field\FieldDefinitionInterface;
use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\Field\FormatterBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Drupal\text\TextProcessed;
use Drupal\ui_patterns\Form\PatternDisplayFormTrait;
use Drupal\ui_patterns\UiPatternsSourceManager;
use Drupal\ui_patterns\UiPatternsManager;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Drupal\Core\Extension\ModuleHandlerInterface;
use Drupal\Core\TypedData\Plugin\DataType\Uri;
use Drupal\Core\Url;

/**
 * Plugin implementation of the 'pattern' formatter.
 *
 * Field types are altered in
 * ui_patterns_field_formatters_field_formatter_info_alter().
 *
 * @FieldFormatter(
 *   id = "pattern_formatter",
 *   label = @Translation("Pattern"),
 *   field_types = {
 *     "string"
 *   },
 * )
 */
class PatternFormatter extends FormatterBase implements ContainerFactoryPluginInterface {

  use PatternDisplayFormTrait;

  /**
   * UI Patterns manager.
   *
   * @var \Drupal\ui_patterns\UiPatternsManager
   */
  protected $patternsManager;

  /**
   * UI Patterns source manager.
   *
   * @var \Drupal\ui_patterns\UiPatternsSourceManager
   */
  protected $sourceManager;

  /**
   * A module manager object.
   *
   * @var \Drupal\Core\Extension\ModuleHandlerInterface
   */
  protected $moduleHandler;

  /**
   * Constructs a Drupal\Component\Plugin\PluginBase object.
   *
   * @param string $plugin_id
   *   The plugin_id for the formatter.
   * @param mixed $plugin_definition
   *   The plugin implementation definition.
   * @param \Drupal\Core\Field\FieldDefinitionInterface $field_definition
   *   The definition of the field to which the formatter is associated.
   * @param array $settings
   *   The formatter settings.
   * @param string $label
   *   The formatter label display setting.
   * @param string $view_mode
   *   The view mode.
   * @param array $third_party_settings
   *   Any third party settings.
   * @param \Drupal\ui_patterns\UiPatternsManager $patterns_manager
   *   UI Patterns manager.
   * @param \Drupal\ui_patterns\UiPatternsSourceManager $source_manager
   *   UI Patterns source manager.
   * @param \Drupal\Core\Extension\ModuleHandlerInterface $module_handler
   *   Module handler.
   */
  public function __construct($plugin_id, $plugin_definition, FieldDefinitionInterface $field_definition, array $settings, $label, $view_mode, array $third_party_settings, UiPatternsManager $patterns_manager, UiPatternsSourceManager $source_manager, ModuleHandlerInterface $module_handler) {
    parent::__construct($plugin_id, $plugin_definition, $field_definition, $settings, $label, $view_mode, $third_party_settings);
    $this->patternsManager = $patterns_manager;
    $this->sourceManager = $source_manager;
    $this->moduleHandler = $module_handler;
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition) {
    return new static(
      $plugin_id,
      $plugin_definition,
      $configuration['field_definition'],
      $configuration['settings'],
      $configuration['label'],
      $configuration['view_mode'],
      $configuration['third_party_settings'],
      $container->get('plugin.manager.ui_patterns'),
      $container->get('plugin.manager.ui_patterns_source'),
      $container->get('module_handler')
    );
  }

  /**
   * {@inheritdoc}
   */
  public static function defaultSettings() {
    return [
      'pattern' => '',
      'pattern_variant' => '',
      'pattern_mapping' => [],
      // Used by ui_patterns_settings.
      'pattern_settings' => [],
      'variants_token' => [],
    ] + parent::defaultSettings();
  }

  /**
   * {@inheritdoc}
   */
  public function settingsForm(array $form, FormStateInterface $form_state) {
    $form = parent::settingsForm($form, $form_state);
    $field_storage_definition = $this->fieldDefinition->getFieldStorageDefinition();
    $context = [
      'storageDefinition' => $field_storage_definition,
      'limit' => $field_storage_definition->getPropertyNames(),
    ];
    // Some modifications to make 'variant' default value working.
    $configuration = $this->getSettings();

    $this->buildPatternDisplayForm($form, 'field_properties', $context, $configuration);

    $form['#element_validate'] = [[static::class, 'cleanSettings']];
    return $form;
  }

  /**
   * Clean up pattern settings.
   *
   * @param array $element
   *   The pattern settings element.
   * @param \Drupal\Core\Form\FormStateInterface $form_state
   *   The form state.
   * @param array $form
   *   The form definition.
   */
  public static function cleanSettings(array &$element, FormStateInterface $form_state, array $form) {
    $element_value = $form_state->getValue($element['#parents']);
    static::processFormStateValues($element_value);
    $form_state->setValue($element['#parents'], $element_value);
  }

  /**
   * {@inheritdoc}
   */
  public function settingsSummary() {
    $summary = [];
    $pattern = $this->getSetting('pattern');

    if (!empty($pattern)) {
      $pattern_definition = $this->patternsManager->getDefinition($pattern);

      $label = $this->t('None');
      if (!empty($this->getSetting('pattern'))) {
        $label = $pattern_definition->getLabel();
      }
      $summary[] = $this->t('Pattern: @pattern', ['@pattern' => $label]);

      $pattern_variant = $this->getSetting('pattern_variant');
      if (!empty($pattern_variant)) {
        $variant = $pattern_definition->getVariant($pattern_variant)->getLabel();
        $summary[] = $this->t('Variant: @variant', ['@variant' => $variant]);
      }
    }

    return $summary;
  }

  /**
   * {@inheritdoc}
   */
  public function viewElements(FieldItemListInterface $items, $langcode) {
    $elements = [];
    foreach ($items as $delta => $item) {
      $pattern = $this->getSetting('pattern');

      // Set pattern fields.
      $fields = [];
      $mapping = $this->getSetting('pattern_mapping');
      foreach ($mapping as $source => $field) {
        if ($field['destination'] === '_hidden') {
          continue;
        }
        // Get rid of the source tag.
        $source = explode(":", $source)[1];
        if ($source == '_label') {
          $fields[$field['destination']][] = $items->getFieldDefinition()->getLabel();
          continue;
        }
        if ($source == '_value_display') {
          /** @var \Drupal\Core\TypedData\OptionsProviderInterface $item */
          $allowedValues = $item->getPossibleOptions();
          $value = $item->get('value')->getValue();
          if (!empty($allowedValues[$value])) {
            $fields[$field['destination']][] = $allowedValues[$value];
          }
          continue;
        }
        $property = $item->get($source);
        if ($property instanceof TextProcessed) {
          $value = $property->getValue();
        }
        elseif ($property instanceof EntityReference) {
          if (!empty($property->getTarget())) {
            $entity = $property->getTarget()->getEntity();
            // Drupal loads the entity in its default language and should load
            // the translated one if available.
            if ($entity->hasTranslation($langcode)) {
              $translated_entity = $entity->getTranslation($langcode);
              $value = $translated_entity->label();
            }
            else {
              $value = $entity->label();
            }
          }
        }
        else {
          $value = $item->get($source)->getValue();
          $value = empty($value) ? '' : $value;
        }
        // Preprocess Uri datatype instead of pushing the raw value.
        if ($property instanceof Uri) {
          $options = [];
          // Most of the time, Uri datatype is met in a "link" field type.
          if ($item->getPluginId() === "field_item:link") {
            $options = $item->get('options')->toArray();
          }
          $value = Url::fromUri($value, $options)->toString();
        }
        if (!empty($value)) {
          $fields[$field['destination']][] = $value;
        }
      }

      // Set pattern render array.
      $elements[$delta] = [
        '#type' => 'pattern',
        '#id' => $this->getSetting('pattern'),
        '#fields' => $fields,
        '#multiple_sources' => TRUE,
      ];

      // Set the variant.
      $pattern_variant = $this->getSetting('pattern_variant');
      if (!empty($pattern_variant)) {
        $elements[$delta]['#variant'] = $pattern_variant;
      }

      // Set the settings.
      $settings = $this->getSetting('pattern_settings');
      $pattern_settings = !empty($settings) && isset($settings[$pattern]) ? $settings[$pattern] : NULL;
      if (!empty($pattern_settings)) {
        $elements[$delta]['#settings'] = $pattern_settings;
      }

      // Set the variant tokens.
      $variant_tokens = $this->getSetting('variants_token');
      $variant_token = !empty($variant_tokens) && isset($variant_tokens[$pattern]) ? $variant_tokens[$pattern] : NULL;
      if (!empty($variant_tokens)) {
        $elements[$delta]['#variant_token'] = $variant_token;
      }

      // Set pattern context.
      $entity = $items->getEntity();
      $elements[$delta]['#context'] = [
        'type' => 'field_formatter',
        'entity' => $entity,
        'item' => $item,
      ];
    }
    return $elements;
  }

  /**
   * {@inheritdoc}
   */
  protected function getDefaultValue(array $configuration, $field_name, $value) {
    // Some modifications to make 'destination' default value working.
    if (isset($configuration['pattern_mapping'][$field_name][$value])) {
      return $configuration['pattern_mapping'][$field_name][$value];
    }
    return NULL;
  }

}
