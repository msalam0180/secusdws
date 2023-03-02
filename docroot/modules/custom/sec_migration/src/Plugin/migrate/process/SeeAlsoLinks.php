<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\SeeAlsoLinks.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipRowException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * SeeAlsoLinks returns the first see Also url and label from string
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "see_also_links"
 * )
 */
class SeeAlsoLinks extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    if (empty($value)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipRowException();
    }
    $regex = "/See also:? (.*) \((http.[^)]+)\)/i";


    preg_match($regex, $value, $matches);
    $returnArr = [];
    if (!empty($matches)) {
      $returnArr[0] = substr($matches[1], 0, 255);
      $returnArr[1] = $matches[2];
      if (strpos($returnArr[0], "(http")) {
        $split = explode("(", $matches[1]);
        $title = substr($split[0], 0, 255);
        $url = explode(")", $split[1])[0];
        $returnArr[0] = $title;
        $returnArr[1] = $url;
      }
    }
    return $returnArr;
  }
}
