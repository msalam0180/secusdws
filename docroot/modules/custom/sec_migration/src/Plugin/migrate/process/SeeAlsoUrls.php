<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\SeeAlsoUrls.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\MigrateSkipRowException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * SeeAlsoUrls returns all See Also urls from string
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 *  Available configuration keys:
 *   - return_associative: will return an associative array for use with SubProcess plugin
 * @MigrateProcessPlugin(
 *   id = "see_also_urls"
 * )
 */
class SeeAlsoUrls extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    if (!empty($value)) {
      $returnAssociative = !empty($this->configuration['return_associative']) ?: false;
      $regex = "/(https?|public)\:\/\/[^\" \n \)]+/i";
      preg_match_all($regex, $value, $matches);
      if (!empty($matches)) {
        if ($returnAssociative) {
          $allUrls = [];
          foreach ($matches[0] as $url) {
            $invalidUrls = [
              "sec.gov/about/acrobat.htm",
            ];
            $isInvalid = (str_replace($invalidUrls, '', $url) != $url);
            if (!$isInvalid) {
              array_push($allUrls, ['url' => $url]);
            }
          }
          return $allUrls;
        }
        return $matches[0];
      }

      return [];
    }
  }
}
