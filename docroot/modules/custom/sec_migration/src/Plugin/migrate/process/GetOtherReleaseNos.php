<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetOtherReleaseNos.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetOtherReleaseNos returns the other release numbers from respondent string extracted from legacy AWS content listings
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_other_release_nos"
 * )
 */
class GetOtherReleaseNos extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    if (empty($value)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipProcessException();
    }

    $returnArr = [];
    //first add the id to the list of release numbers
    $id = $row->getSourceProperty("id");
    $idField = isset($this->configuration['id_field']) ? $this->configuration['id_field'] : 'id';
    $id = $row->getSourceProperty($idField);
    $returnArr[] = $id;

    //next we search using regular expressions for various formats of release numbers in source data
    $regex = "/(?s)(Other Release Nos\.:?|Release No\.:?|Release Nos\.:?|Other Rel\. Nos?\.:?|Other Release No\.:?) (.+?) ?(?=Note|See|\)|Effective|Comments|Federal Register|Compliance|\(|File No|$)/i";
    preg_match_all($regex, $value, $matches);
    
    if (!empty($matches) && !empty($matches[2])) {
      foreach ($matches[2] as $rn) {
        //exclude Press Release numbers
        if (!empty($rn) && !str_contains($value, "Press Release No. " . $rn)) {
          $rn = rtrim($rn,";");
          //if this is a delimited list of releases, add them all in
          if (strpos($rn, ";")) {
            $returnArr = array_merge($returnArr, explode(";", $rn));
          } else if (strpos($rn, ",")) {
            $returnArr = array_merge($returnArr, explode(",", $rn));
          } else if (preg_match("/\w{1,4}-\d+/i", $rn)) {
            array_push($returnArr, $rn);
          }
        }
      }
    }

    //check if theres an AAER for this ID
    $aaer = \Drupal::database()->query('SELECT id FROM {aaer} WHERE respondents like :id', [':id' => "%$id%"])->fetchField();
    if (!empty($aaer)) {
      array_push($returnArr, $aaer);
    }

    //finally trim all release numbers to avoid extra spaces
    $returnArr = array_map('trim', $returnArr);
    $returnArr = array_unique($returnArr);
    return $returnArr;
  }
}
