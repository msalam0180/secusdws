<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

use Drupal\migrate\MigrateException;
use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\MigrateSkipRowException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * If the source evaluates to a configured value, skip processing or whole row.
 * Uses either strpos() or preg_match() function on a source string.
 * - contains: The value or pattern being searched for. It can be either a string
 *   or an array with strings.
 * - regex: (optional) If not empty, then preg_match() function will be used
 *   instead of strpos(). Defaults to FALSE.
 * Available configuration keys:
 * @MigrateProcessPlugin(
 *   id = "skip_on_contains"
 * )
 */
class SkipOnContains extends ProcessPluginBase
{

    /**
   * {@inheritdoc}
   */
    public function row($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property)
    {
        $this->configuration += ['regex' => FALSE];
        if (empty($this->configuration['contains']) && !array_key_exists('contains', $this->configuration)) {
            throw new MigrateException('Skip on contains plugin is missing contains configuration.');
        }

        if (is_array($this->configuration['contains'])) {
            foreach ($this->configuration['contains'] as $skipValue) {
                if ($this->configuration['regex']) {
                    if (preg_match($skipValue, $value)) {
                        throw new MigrateSkipRowException();
                    }
                } else if (strpos($value, $skipValue) !== false) {
                    throw new MigrateSkipRowException();
                }
            }
        } else {
            if ($this->configuration['regex']) {
                if (preg_match($this->configuration['contains'], $value)) {
                    throw new MigrateSkipRowException();
                }
            } else if (strpos($value, $this->configuration['contains']) !== false) {
                throw new MigrateSkipRowException();
            }
        }
        return $value;
    }

    /**
   * {@inheritdoc}
   */
    public function process($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property)
    {
        $this->configuration += ['regex' => FALSE];
        if (empty($this->configuration['contains']) && !array_key_exists('contains', $this->configuration)) {
            throw new MigrateException('Skip on contains plugin is missing contains configuration.');
        }

        if (is_array($this->configuration['contains'])) {
            foreach ($this->configuration['contains'] as $skipValue) {
                if ($this->configuration['regex']) {
                    if (preg_match($skipValue, $value)) {
                        throw new MigrateSkipProcessException();
                    }
                } else if (strpos($value, $skipValue) !== false) {
                    throw new MigrateSkipProcessException();
                }
            }
        } else {
            if ($this->configuration['regex']) {
                if (preg_match($this->configuration['contains'], $value)) {
                    throw new MigrateSkipProcessException();
                }
            } else if (strpos($value, $this->configuration['contains']) !== false) {
                throw new MigrateSkipProcessException();
            }
        }

        return $value;
    }


}
