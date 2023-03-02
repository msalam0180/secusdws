<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetSROCategory.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetSROCategory returns the SRO category based on the release url for an SRO
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_sro_category"
 * )
 */
class GetSROCategory extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {

    $filenumber = $row->getSourceProperty("file_number");
    if (!empty($filenumber) && str_starts_with($filenumber[0], "SR-")) {
      $all_codes = [];
      //parse the file number value and return the shortcode for sro organizations
      if (is_array($filenumber)) {
        foreach ($filenumber as $f) {
          $short_code = preg_replace('/SR-(.[^-]+)-.+$/i', "$1", $f);
          $all_codes[] = strtolower($short_code);
        }
        return array_unique($all_codes);
      } else {
        $short_code = preg_replace('/SR-(.[^-]+)-.+$/i', "$1", $filenumber);
        return $short_code;
      }
    }
    else if (empty($value)) {
      // Skip this item if there's no value data.
      throw new MigrateSkipProcessException();
    } else if (strpos($value,"https://www.sec.gov/rules/") == 0 ) {
      $cat = explode("/",$value)[5];
      if ($cat == "other"){
        //check fileurl if possible otherwise assume 17-d
        $fileurl = $row['fileurl'];
        if (!empty($fileurl) && strpos($fileurl, "https://www.sec.gov/rules/") == 0 ) {
          $cat = explode("/", $fileurl)[5];
        } else {
          $cat = "17-d";
        }
      }
      return $cat;
    }
  }
}
