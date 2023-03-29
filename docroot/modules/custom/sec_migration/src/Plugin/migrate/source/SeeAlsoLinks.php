<?php

namespace Drupal\sec_migration\Plugin\migrate\source;

use Drupal\migrate_source_csv\Plugin\migrate\source\CSV;

/**
 * Extracts rows See Also Links urls
 *
 * @MigrateSource(
 *   id = "see_also_links",
 *   source_module = "sec_migration",
 * )
 */
class SeeAlsoLinks extends CSV {


  /**
   * {@inheritdoc}
   */
  public function initializeIterator() {
    $rows = parent::initializeIterator();

    return $this->getYield($rows);
  }

  /**
   * Prepares multiple rows per item
   *
   * @param \Generator $rows
   *   The source rows string object.
   *
   * @return \Generator
   *   A new row, one for each url in the source field string
   */
  public function getYield(\Generator $rows) {
    $source_field = "respondents";
    if (!empty($this->configuration["source_field"])) {
      $source_field = $this->configuration["source_field"];
    }
    foreach ($rows as $row) {
      $regex = "/ (\( Note:|;|,|See also:) ([\w\s.-]+) \((http.+?)(\)|$)/i";
      preg_match_all($regex, $row[$source_field], $matches);
      if (!empty($matches)) {
        for ($i=0; $i < count($matches[3]); $i++) {
          $url = $matches[3][$i];
          $label = $matches[2][$i];
          $label = preg_replace('/See also:? /i', '', $label);
          $invalidUrls = [
            "federalregister.gov",
            "sec.gov/comments",
            "gpo.gov/fdsys",
            "sec.gov/about/acrobat.htm",
            "public://"
          ];
          $isInvalid = (str_replace($invalidUrls, '', $url) != $url);
          if (!$isInvalid) {
            $new_row = $row;
            $new_row["id"] = substr($url, 0, 255);
            $new_row["url"] = $url;
            $new_row["title"] = substr($label, 0, 255);
            yield ($new_row);
          }
        }
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
