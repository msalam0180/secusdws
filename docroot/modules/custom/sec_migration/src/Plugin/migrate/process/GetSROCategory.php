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
    $details = $row->getSourceProperty("details");
    $an_categories = ["FICC","DTC","OCC","NSCC"];
    if (!empty($filenumber) && str_starts_with($filenumber[0], "SR-") && !str_contains($value, "-an/")) {
      $all_codes = [];
      //parse the file number value and return the shortcode for sro organizations
      if (is_array($filenumber)) {
        foreach ($filenumber as $f) {
          $short_code = preg_replace('/SR-(.[^-]+)-.+$/i', "$1", $f);
          if (str_contains($details, "Advance Notice") && in_array(strtoupper($short_code), $an_categories)) $short_code = $short_code . "-an";
          $all_codes[] = strtolower($short_code);
        }
        return array_unique($all_codes);
      } else {
        $short_code = preg_replace('/SR-(.[^-]+)-.+$/i', "$1", $filenumber);
        if (str_contains($details, "Advance Notice") && in_array(strtoupper($short_code), $an_categories)) $short_code = $short_code . "-an";
        return $short_code;
      }
    }
    else if (empty($value)) {
      // Skip this item if there's no value data.
      throw new MigrateSkipProcessException();
    } else if (str_contains($value,"/rules/")) {
      $urlparts = explode("/",$value);
      $cat = $urlparts[5];
      if ($urlparts[4] == "other"){
        $cat = "17d-2";
      }
      if (str_contains($details, "Advance Notice") && in_array(strtoupper($cat), $an_categories)) $cat = $cat . "-an";
      if (str_contains($details, "Allocation of Regulatory Responsibilities") && in_array(strtoupper($cat), $an_categories)) $cat = "17d-2";
      return $cat;
    }
  }
}
