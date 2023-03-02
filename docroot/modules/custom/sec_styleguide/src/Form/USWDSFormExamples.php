<?php

namespace Drupal\sec_styleguide\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Implements InputDemo form controller.
 *
 * This example demonstrates the different input elements that are used to
 * collect data in a form.
 */
class USWDSFormExamples extends FormBase {

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {

    $form['description'] = [
      '#type' => 'item',
      '#markup' => $this->t('<h2>The form examples below show the use of input-types</h2>'),
    ];

    $form['form_guidance'] = [
      '#type' => 'item',
      '#markup' => $this->t('<h3>Also see <a target="_blank" rel="noopener noreferrer" href="https://designsystem.digital.gov/components/form/">the
      USWDS form guidance page</a> for more information.</h3>'),
    ];

    // CheckBoxes.
    $form['tests_taken'] = [
      '#type' => 'checkboxes',
      '#options' => ['SAT' => $this->t('SAT'), 'ACT' => $this->t('ACT')],
      '#title' => $this->t('What standardized tests did you take?'),
      '#description' => 'USA Checkbox example',
    ];

    $form['places_visited'] = [
      '#type' => 'checkboxes',
      '#options' => [
        'europe' => $this->t('Europe'),
        'south_america' => $this->t('South America'),
        'iceland' => $this->t('Iceland'),
        'asia' => $this->t('Asia'),
        'antarctica' => $this->t('Antarctica'),
      ],
      '#title' => $this->t('Have you visited any of these places?'),
      '#description' => 'USA Checkbox tiles example',
      '#attributes' => ['class' => ['usa-checkbox__input--tile']],
    ];

    // Radios.
    $form['poll_status'] = [
      '#type' => 'radios',
      '#title' => $this->t('Choose a poll status'),
      '#options' => [
        0 => $this->t('Closed'),
        1 => $this->t('Active'),
      ],
      '#description' => $this->t('USA Radio buttons example'),
    ];

    // Radios.
    $form['favorite_food'] = [
      '#type' => 'radios',
      '#title' => $this->t('Choose your favorite food'),
      '#options' => [
        0 => $this->t('Ice Cream'),
        1 => $this->t('Cake'),
        2 => $this->t('Pie'),
      ],
      '#description' => $this->t('USA Radio button tiles example'),
      '#attributes' => ['class' => ['usa-radio__input--tile']],
    ];

    // Text field.
    $form['subject'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Your Name'),
      '#size' => 60,
      '#maxlength' => 128,
      '#description' => $this->t('USA Text input example.'),
    ];

    // Email.
    $form['email'] = [
      '#type' => 'email',
      '#title' => $this->t('Please input your email address'),
      '#description' => $this->t('Email text field example'),
      '#required' => TRUE,
    ];

    // URL.
    $form['url'] = [
      '#type' => 'url',
      '#title' => $this->t('Please input a URL or hyperlink'),
      '#maxlength' => 255,
      '#size' => 30,
      '#description' => $this->t('URL text field example'),
    ];

    // Tel.
    $form['phone'] = [
      '#type' => 'tel',
      '#title' => $this->t('Please input your phone number'),
      '#description' => $this->t('Telephone text field example'),
    ];

    // Number.
    $form['quantity'] = [
      '#type' => 'number',
      '#title' => $this->t('Please input a quantity'),
      '#description' => $this->t('Number text field example (HTML5 number)'),
    ];

    // Password Confirm.
    // $form['password_confirm'] = [
    //   '#type' => 'password_confirm',
    //   '#title' => $this->t('Please input a password and confirm it in the field below'),
    //   '#description' => $this->t('Password text field example'),
    //   '#required' => TRUE,
    // ];

    // Textarea.
    $form['text'] = [
      '#type' => 'textarea',
      '#title' => $this->t('Input a message in this field'),
      '#description' => $this->t('Textarea example'),
    ];

    // Select.
    $form['favorite'] = [
      '#type' => 'select',
      '#title' => $this->t('Favorite color'),
      '#options' => [
        'red' => $this->t('Red'),
        'blue' => $this->t('Blue'),
        'green' => $this->t('Green'),
      ],
      '#empty_option' => $this->t('-select-'),
      '#description' => $this->t('USA select list example'),
    ];

    // Multiple values option elements.
    $form['select_multiple'] = [
      '#type' => 'select',
      '#title' => 'Select (multiple)',
      '#multiple' => TRUE,
      '#options' => [
        'sat' => 'SAT',
        'act' => 'ACT',
        'none' => 'N/A',
      ],
      '#default_value' => ['sat'],
      '#description' => 'USA combo box (select list multiple)',
    ];

    // Weight.
    $form['weight'] = [
      '#type' => 'weight',
      '#title' => $this->t('Chose a weight'),
      '#delta' => 10,
      '#description' => $this->t('Weight select list example'),
    ];

    // Date.
    $form['date_no_time'] = [
      '#type' => 'date',
      '#title' => $this->t('Choose a date for content expiration'),
      '#default_value' => [
        'year' => 2023,
        'month' => 01,
        'day' => 01,
      ],
      '#description' => 'USA Date Picker',
    ];

    // Date-time.
    $form['date_has_time'] = [
      '#type' => 'datetime',
      '#title' => 'Choose a date and time',
      '#date_increment' => 1,
      '#date_timezone' => date_default_timezone_get(),
      '#default_value' => date_default_timezone_get(),
      '#description' => $this->t('Date time picker example'),
    ];

    // Details.
    $form['details'] = [
      '#type' => 'details',
      '#title' => $this->t('Details with summary (closed by default)'),
      '#description' => $this->t('Details, Praesent sapien massa, convallis a pellentesque nec, egestas non nisi.
      Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus.'),
    ];

    // Details.
    $form['details_open'] = [
      '#type' => 'details',
      '#open' => TRUE,
      '#title' => $this->t('Details with Summary (open by default)'),
      '#description' => $this->t('Details, Praesent sapien massa, convallis a pellentesque nec, egestas non nisi.
      Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus.'),
    ];

    // // Range.
    // $form['size'] = [
    //   '#type' => 'range',
    //   '#title' => $this->t('Size'),
    //   '#min' => 10,
    //   '#max' => 100,
    //   '#description' => $this->t('USA range slider example'),
    // ];

    // File.
    $form['file'] = [
      '#type' => 'file',
      '#title' => 'File',
      '#description' => $this->t('File, #type = file'),
    ];

    // Manage file.
    $form['usa_managed_file'] = [
      '#type' => 'managed_file',
      '#title' => 'Managed file',
      '#description' => $this->t('Manage file, #type = managed_file'),
      '#upload_validators'  => [
        'file_validate_extensions' => ['txt pdf'],
      ],
    ];

    // Add a submit button that handles the submission of the form.
    $form['actions']['submit'] = [
      '#type' => 'submit',
      '#value' => $this->t('Submit'),
      '#description' => $this->t('Submit, #type = submit'),
    ];

    // Add a reset button that handles the submission of the form.
    $form['actions']['reset'] = [
      '#type' => 'button',
      '#button_type' => 'reset',
      '#value' => $this->t('Reset'),
      '#description' => $this->t('Submit, #type = button, #button_type = reset, #attributes = this.form.reset();return false'),
      '#attributes' => [
        'onclick' => 'this.form.reset(); return false;',
      ],
    ];

    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'form_api_example_input_demo_form';
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    // Find out what was submitted.
    $values = $form_state->getValues();
    foreach ($values as $key => $value) {
      $label = $form[$key]['#title'] ?? $key;

      // Many arrays return 0 for unselected values so lets filter that out.
      if (is_array($value)) {
        $value = array_filter($value);
      }

      // Only display for controls that have titles and values.
      if ($value && $label) {
        $display_value = is_array($value) ? preg_replace('/[\n\r\s]+/', ' ', print_r($value, 1)) : $value;
        $message = $this->t('Value for %title: %value', [
          '%title' => $label,
          '%value' => $display_value,
        ]);
        $this->messenger()->addMessage($message);
      }
    }
  }

}
