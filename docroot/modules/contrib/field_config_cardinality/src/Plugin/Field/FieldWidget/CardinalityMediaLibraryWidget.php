<?php

namespace Drupal\field_config_cardinality\Plugin\Field\FieldWidget;

use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\Form\FormStateInterface;
use Drupal\media_library\Plugin\Field\FieldWidget\MediaLibraryWidget;

class CardinalityMediaLibraryWidget extends MediaLibraryWidget {

  /**
   * {@inheritdoc}
   */
  public function formElement(FieldItemListInterface $items, $delta, array $element, array &$form, FormStateInterface $form_state) {
    $cardinality = $this->fieldDefinition->getThirdPartySetting('field_config_cardinality', 'cardinality_config');
    $cardinality = (integer) $cardinality;
    $storage_cardinality = $this->fieldDefinition->getFieldStorageDefinition()->getCardinality();

    if ($cardinality === 0) {
      $element['#cardinality'] = $storage_cardinality;
    }
    else {
      $element += ['#cardinality' => $cardinality === $storage_cardinality ? $storage_cardinality : $cardinality];
    }

    return parent::formElement($items, $delta, $element, $form, $form_state);
  }

}
