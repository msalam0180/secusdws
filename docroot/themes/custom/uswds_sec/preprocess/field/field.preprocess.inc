<?php

/**
 * Implements hook_preprocess_HOOK() for field.html.twig.
 */
function uswds_sec_preprocess_field(&$variables) {

  
  if (isset($variables['element'])) {
    $bundle = $variables['element']['#bundle'];
    $field_name = $variables['element']['#field_name'];
    
    switch ($field_name) {
      case "field_add_to_calendar":
        if ($bundle == "event") {
          $startTime = new \DateTime($variables['element']['#object']->field_sec_event_date->value, new DateTimeZone("UTC"));
          $startTime = $startTime->setTimezone(new DateTimeZone("UTC"));

          $endTime = new \DateTime($variables['element']['#object']->field_sec_event_end_date->value, new DateTimeZone("UTC"));
          $endTime = $endTime->setTimezone(new DateTimeZone("UTC"));

          $variables['#attached']['drupalSettings']['cal_item'] = ['start' => $startTime->format("Ymd\THis"), 'end' => $endTime->format("Ymd\THis")];
        }
        break;
    }
  }
}
