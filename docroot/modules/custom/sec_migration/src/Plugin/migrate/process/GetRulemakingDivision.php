<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetRulemakingDivision.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetRulemakingDivision returns a rulemaking division given a file number
 * sourced from https://www.sec.gov/rules/rulemaking-index.shtml
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_rulemaking_division"
 * )
 */
class GetRulemakingDivision extends ProcessPluginBase
{

    /**
   * {@inheritdoc}
   */
    public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property)
    {
        if (empty($value)) {
            throw new MigrateSkipProcessException();
        }

        $division = \Drupal::database()->query('SELECT division FROM {rulemaking_division} WHERE file_number = :filenum', [':filenum' => $value])->fetchField();
        if (!empty($division) && str_contains(",",$division)) {
            return explode(",", $division);
        }
        return $division;
    }

}
