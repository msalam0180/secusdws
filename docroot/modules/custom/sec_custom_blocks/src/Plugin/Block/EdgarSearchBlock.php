<?php

/**
 * @file
 * Contains \src\Plugin\Block\EdgarSearchBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides an EDGAR Search block.
 *
 * @Block(
 *   id = "edgar_search_block",
 *   admin_label = @Translation("EDGAR Search"),
 * )
 */

class EdgarSearchBlock extends BlockBase
{

    /**
     * {@inheritdoc}
     */
    public function build()
    {
        $markup = '';
        return [
            '#type' => 'markup',
            '#markup' => $markup,
            '#theme' => 'edgar_search_block',
        ];
    }

}
