<?php

/**
 * @file
 * Contains sec_styleguide.module.
 */

/**
 * Implements hook_theme().
 */
function sec_styleguide_theme() {
  return [
    'uswds_components' => [
      'render element' => 'children',
      'variables' => [
        'config_data' => '',
        'colors_yml' => '',
        'module_path' => '',
      ],
    ],

    'usa_accordion' => [
      'render element' => 'children',
      'template' => 'components/usa-accordion',
      'variables' => [
        'content_yml' => '',
        'component_yml' => '',
        'title' => 'USA Accordion',
        'module_path' => '',
      ],
    ],

    'usa_alert' => [
      'render element' => 'children',
      'template' => 'components/usa-alert',
      'variables' => [
        'alert_yml' => '',
        'component_yml' => '',
        'title' => 'USA Alert (Drupal messages)',
        'module_path' => '',
      ],
    ],

    'usa_breadcrumb' => [
      'render element' => 'children',
      'template' => 'components/usa-breadcrumb',
      'variables' => [
        'title' => 'USA Breadcrumb',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    'usa_button_group' => [
      'render element' => 'children',
      'template' => 'components/usa-button-group',
      'variables' => [
        'title' => 'USA Button Group',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    'usa_button' => [
      'render element' => 'children',
      'template' => 'components/usa-button',
      'variables' => [
        'button_yml' => '',
        'component_yml' => '',
        'title' => 'USA Button',
        'module_path' => '',
      ],
    ],

    'usa_card' => [
      'render element' => 'children',
      'template' => 'components/usa-card',
      'variables' => [
        'card_yml' => '',
        'component_yml' => '',
        'title' => 'USA Card',
        'module_path' => '',
      ],
    ],

    'usa_card_group' => [
      'render element' => 'children',
      'template' => 'components/usa-card-group',
      'variables' => [
        'card_yml' => '',
        'component_yml' => '',
        'title' => 'USA Card Group',
        'module_path' => '',
      ],
    ],

    'usa_collection' => [
      'render element' => 'children',
      'template' => 'components/usa-collection',
      'variables' => [
        'title' => 'USA Collection',
        'collection_yml' => '',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    'usa_grid' => [
      'render element' => 'children',
      'template' => 'components/usa-grid',
      'variables' => [
        'title' => 'USA Grid',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    'usa_icon' => [
      'render element' => 'children',
      'template' => 'components/usa-icon',
      'variables' => [
        'icon_yml' => '',
        'title' => 'USA Icon',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    'usa_link' => [
      'render element' => 'children',
      'template' => 'components/usa-link',
      'variables' => [
        'title' => 'USA Link',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    'usa_pagination' => [
      'render element' => 'children',
      'template' => 'components/usa-pagination',
      'variables' => [
        'title' => 'USA Pagination',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    # 'usa_process_list' => [
    #   'render element' => 'children',
    #   'template' => 'components/usa-process-list',
    #   'variables' => [
    #     'title' => 'USA Process List',
    #     'component_yml' => '',
    #     'module_path' => '',
    #   ],
    # ],

    # 'usa_search' => [
    #   'render element' => 'children',
    #   'template' => 'components/usa-search',
    #   'variables' => [
    #     'title' => 'USA Search',
    #     'component_yml' => '',
    #     'module_path' => '',
    #   ],
    # ],

    'usa_side_navigation' => [
      'render element' => 'children',
      'template' => 'components/usa-side-navigation',
      'variables' => [
        'title' => 'USA Side Navigation',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    'usa_step_indicator' => [
      'render element' => 'children',
      'template' => 'components/usa-step-indicator',
      'variables' => [
        'title' => 'USA Step Indicator',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    # 'usa_summary_box' => [
    #   'render element' => 'children',
    #   'template' => 'components/usa-summary-box',
    #   'variables' => [
    #     'title' => 'USA Summary Box',
    #     'component_yml' => '',
    #     'module_path' => '',
    #   ],
    # ],

    'usa_table' => [
      'render element' => 'children',
      'template' => 'components/usa-table',
      'variables' => [
        'title' => 'USA Table',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    'usa_typography' => [
      'render element' => 'children',
      'template' => 'components/usa-typography',
      'variables' => [
        'title' => 'USA Typography',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    'email_alerts' => [
      'render element' => 'children',
      'template' => 'components/email-alerts',
      'variables' => [
        'title' => 'Email Alerts Promo',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    'landing_page_title' => [
      'render element' => 'children',
      'template' => 'components/landing-page-title',
      'variables' => [
        'title' => 'Landing Page Title',
        'component_yml' => '',
        'module_path' => '',
      ],
    ],

    // 'test_component' => [
    //   'render element' => 'children',
    //   'template' => 'components/test-component',
    //   'variables' => [
    //     'title' => 'Test Component',
    //     'component_yml' => '',
    //     'module_path' => '',
    //   ],
    // ],

    // This is a custom block and not part of the components above.
    'uswds_usa_hero' => [
      'variables' => [
        'theme_path' => '',
        'module_path' => '',
        'hero_title' => '',
        'hero_title_callout' => '',
        'hero_text' => '',
        'hero_button_cta' => '',
        'hero_button_cta_class' => '',
        'hero_image' => '',
        'component_yml' => '',
      ],
    ],

    'uswds_usa_side_nav' => [
      'variables' => [
        'theme_path' => '',
        'module_path' => '',
        'nav_yml' => '',
        'component_yml' => '',
        'active_path' => '',
      ],
    ],
  ];
}
