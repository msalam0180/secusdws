# USWDS Style Guide

## Create a new Component

1. Set up the Navigation and metadata
    
    Add the component to the `/data/uswds_navigation.yml `

    This will cause the component to be added to the main page and pass in the metadata to the template

    ```yml
      - href: /sec-styleguide/usa-card
        title: "Card"
        desc: "Cards contain content and actions about a single subject."
        dev_note: "In Development: Review font size, are there any other variations we need to consider? Need to add card without image"
        usage: "TODO"
        external_documentation: "https://designsystem.digital.gov/components"
    ```
    ### Keys
    - **title**: component title
    - **desc**: a description of the component
    - **href**: path to component
    - **dev_note**: not for developers during development
    - **usage**: Currently unused, this value may be removed
    - **external_documentation**: Link to external documentation

2. Set up the Routing

    Add the component to the `/php-includes/uswds_theme.inc`

    This sets up the routing so Drupal understands where the template is located

    ```php
        'usa_card' => [
          'render element' => 'children',
          'template' => 'components/usa-card',
          'variables' => [
            'card_yml' => '',
            'title' => 'USA Card',
            'component_yml' => '',
            'module_path' => '',
          ],
        ],
    ```

3. Add the template in the `/templates` directory

    The template file name should match the template name listed in the above routing
    `'template' => 'components/usa-card',`

    It is best to copy a simple existing component template to get started






