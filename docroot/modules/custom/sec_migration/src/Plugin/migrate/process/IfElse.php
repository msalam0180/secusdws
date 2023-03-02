<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\IfElse.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\MigrateException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * IfElse evaluates the value of a source and returns another value
 *
 *
 * Available configuration keys:
 * - source: The value to check
 * - equals: the value to compare to
 * - then: the value to return if source value == equals value
 * - else: the value to return if source value != equals value
 *
 * Example:
 * Given source keys of foo, bar, and baz:
 * @code
 * process_key:
 *   plugin: if_else
 *   source: foo
 *   equals: bar
 *   then: baz
 *   else: qux
 * @endcode
 *
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "if_else"
 * )
 */
class IfElse extends ProcessPluginBase
{

    /**
   * {@inheritdoc}
   */
    public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property)
    {

        if (empty($this->configuration['equals']) && !array_key_exists('equals', $this->configuration)) {
            throw new MigrateException('if_else plugin is missing equals configuration.');
        }

        if (empty($this->configuration['then']) && !array_key_exists('then', $this->configuration)) {
            throw new MigrateException('if_else plugin is missing then configuration.');
        }


        $equalsValue = $this->configuration['equals'];
        $thenValue = $this->configuration['then'];
        $elseValue = null;
        if (isset($this->configuration['else'])) {
            $elseValue = $this->configuration['else'];
        }

        if (str_starts_with($thenValue, '@')) $thenValue = $row->getSourceProperty(str_replace('@','',$thenValue));
        if (str_starts_with($elseValue, '@')) $elseValue = $row->getSourceProperty(str_replace('@', '', $elseValue));

        if (empty($elseValue)) $elseValue = $value;

        if ($value == $equalsValue) {
            return $thenValue;
        } else {
            return $elseValue;
        }


    }

}
