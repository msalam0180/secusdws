<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\SubmitComments.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * SubmitComments attempts to find a file number to reference
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "submit_comments"
 * )
 */
class SubmitComments extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    if (empty($value)) {
      //we need to see if we can grab
      $source_field = "respondents";
      if (!empty($this->configuration["source_field"])) {
        $source_field = $this->configuration["source_field"];
      }
      $data = $row->getSourceProperty($source_field);
      preg_match("/(.+)?Submit comments on ([A-Z,0-9]+?-[A-Z,0-9]+-?[A-Z,0-9]+)?/i", $data, $matches);
      if (!empty($matches[2])) {
        return trim($matches[2]);
      }
    }

    return $value;
  }
}
