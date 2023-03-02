<?php

namespace Drupal\layout_builder_customizer\Form;

use Drupal\Core\Form\ConfigFormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Class LayoutBuilderCustomizerForm.
 */
class LayoutBuilderCustomizerForm extends ConfigFormBase {

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'layout_builder_customizer_admin_settings';
  }

  /**
   * {@inheritdoc}
   */
  protected function getEditableConfigNames() {
    return [
      'layout_builder_customizer.settings_form',
    ];
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {
    $config = $this->config('layout_builder_customizer.settings_form');
    $form['layout_builder_customizer_disable'] = [
      '#type' => 'checkbox',
      '#title' => 'Disable Option "Allow each Entity Type to have its layout customized."',
      '#default_value' => $config->get('layout_builder_customizer_disable'),
      '#description' => 'If checked, Disables option "Allow each Entity Type to have its layout customized" in Manage Display Page for Respective Entity Type.',
    ];
    return parent::buildForm($form, $form_state);
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    $this->config('layout_builder_customizer.settings_form')
      ->set('layout_builder_customizer_disable', $form_state->getValue('layout_builder_customizer_disable'))
      ->save();
    parent::submitForm($form, $form_state);
  }

}
