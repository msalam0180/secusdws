<?php

/**
 * @file
 * Alterations for this form.
 */

use Drupal\Core\Form\FormStateInterface;

/**
 * Implements hook_form_FORM_ID_alter().
 */
function uswds_form_user_profile_form_alter(&$form, FormStateInterface $form_state, $form_id) {
  _uswds_container_to_details($form['account'], t('Account settings'));
  if (isset($form['user_picture'])) {
    _uswds_container_to_details($form['user_picture'], t('Picture'));
  }
}
