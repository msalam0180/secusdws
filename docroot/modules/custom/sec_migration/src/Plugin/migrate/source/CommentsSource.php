<?php

namespace Drupal\sec_migration\Plugin\migrate\source;

use Drupal\migrate_source_csv\Plugin\migrate\source\CSV;

/**
 * Extracts Submit Comments records
 *
 * @MigrateSource(
 *   id = "comments_source",
 *   source_module = "sec_migration",
 * )
 */
class CommentsSource extends CSV {


  /**
   * {@inheritdoc}
   */
  public function initializeIterator() {
    $respondents = parent::initializeIterator();

    return $this->getYield($respondents);
  }

  /**
   * Filters rows with no comments
   *
   * @param \Generator $respondents
   *   The source respondents string object.
   *
   * @return \Generator
   *   A row for each comments note in the source respondents string
   */
  public function getYield(\Generator $respondents) {
    $source_field = "respondents";
    if (!empty($this->configuration["source_field"])) {
      $source_field = $this->configuration["source_field"];
    }
    foreach ($respondents as $row) {

      if (preg_match("/ Submit Comments /i", $row[$source_field])) {
        yield $row;
      }

    }
  }


  /**
   * {@inheritdoc}
   */
  public function getIds() {
    return [
      'id' => [
        'type' => 'string',
        'alias' => 'id',
      ]
    ];
  }
}
