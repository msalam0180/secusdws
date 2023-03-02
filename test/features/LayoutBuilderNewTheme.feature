Feature: Utilizing Layout Builder with the New Theme
  As a sitebuilder or above user can use Layout Builder to SEC.gov
  I want to be able to view content that allows for layouts
  So that I quickly change the section and/or blocks

# Pre-requisite Setup to new theme:
# Have to be switched to the new Theme called "SEC USWDS" on your local from: /admin/appearance
# But it will also be necessary to clear cache from: /admin/config/development/performance in another tab;
# Then hit "Clear Cache" button after you have switched

  Background:
    Given "division_office" terms:
        | name                     |
        | The Rebel Alliance-Luke  |
        | The Rebel Alliance-Leia  |
        | The Rebel Alliance-Solo  |
        | The Rebel Alliance-Lando |
        | The Rebel Alliance-Wedge |
        | The Rebel Alliance-OB1   |

  @api @javascript
  Scenario: Adding an Email Alerts Sign-Up Block
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                                               | moderation_state |
      | BEHAT Layout Builder New Theme Email Alert Block LP | published        |
    When I am on "/page/behat-layout-builder-new-theme-email-alert-block-lp/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I click "Email Alerts Signup"
      And I fill in "Title" with "BEHAT Email Alerts Signup Block"
      And I fill in "Heading" with "This block created by BEHAT for users to get filing search announcements sent straight to your inbox! :-)"
      And I fill in "Email List ID" with "USSEC_C27"
      And I press "Add block"
    Then I should see the text "BEHAT Email Alerts Signup Block"
    When I scroll to the top
      And I press "Save layout"
      And I am not logged in
      And I am on "/page/behat-layout-builder-new-theme-email-alert-block-lp"
    Then I should see the heading "BEHAT Layout Builder New Theme Email Alert Block LP"
      And I should see the heading "BEHAT Email Alerts Signup Block"
      And I should see the "h2" element with the "class" attribute set to "email-alerts__heading" in the "uswds_main_block" region
      And I should see the heading "This block created by BEHAT for users to get filing search announcements sent straight to your inbox! :-)"
      And I should see the text "Your email address"
    When I fill in "email" with "john_doe@tester.com"
      And I press "Subscribe"
    Then I should see the text "New Subscriber"

  @api @javascript
  Scenario: Modifying Display Title and Heading Level for Email Alerts Sign-Up Block
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                                               | moderation_state |
      | BEHAT Layout Builder New Theme Email Alert Block LP | published        |
    When I am on "/page/behat-layout-builder-new-theme-email-alert-block-lp/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I click "Email Alerts Signup"
      And I fill in "Title" with "BEHAT Email Alerts Signup Block"
      # Unchecking "Display title" checkbox
      And I click on the element with css selector "#layout-builder-add-block > div.usa-checkbox.js-form-item.form-item.js-form-type-checkbox.form-type-checkbox.js-form-item-settings-label-display.form-item-settings-label-display > label"
      And I fill in "Heading" with "This block created by BEHAT for users to get filing search announcements sent straight to your inbox! :-)"
      And I select "4" from "Heading Level"
      And I fill in "Email List ID" with "USSEC_C27"
      And I press "Add block"
    Then I should not see the text "BEHAT Email Alerts Signup Block"
    When I scroll to the top
      And I press "Save layout"
      And I am not logged in
      And I am on "/page/behat-layout-builder-new-theme-email-alert-block-lp"
    Then I should see the heading "BEHAT Layout Builder New Theme Email Alert Block LP"
      And I should not see the text "BEHAT Email Alerts Signup Block"
      And I should see the "h4" element with the "class" attribute set to "email-alerts__heading" in the "uswds_main_block" region
      And I should see the heading "This block created by BEHAT for users to get filing search announcements sent straight to your inbox! :-)"
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/page/behat-layout-builder-new-theme-email-alert-block-lp/layout"
      And I scroll ".layout-builder__region" into view
      And I hover over the element "#layout-builder > div:nth-child(2) > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.block-layout-builder.block-inline-blockemail-alerts-signup"
      And I wait 1 seconds
      # Checking "Display title" checkbox
      And I click on the element with css selector "#layout-builder > div:nth-child(2) > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.block-layout-builder.block-inline-blockemail-alerts-signup > div.contextual > ul > li.layout-builder-block-update > a"
      And I click on the element with css selector "#layout-builder-update-block > div.usa-checkbox.js-form-item.form-item.js-form-type-checkbox.form-type-checkbox.js-form-item-settings-label-display.form-item-settings-label-display > label"
      And I fill in "Heading" with "This block will send alerts straight to your inbox!"
      And I select "3" from "Heading Level"
      And I press "Update"
    Then I should see the text "BEHAT Email Alerts Signup Block"
    When I scroll to the top
      And I press "Save layout"
    When I am not logged in
      And I am on "/page/behat-layout-builder-new-theme-email-alert-block-lp"
    Then I should see the heading "BEHAT Layout Builder New Theme Email Alert Block LP"
      And I should see the heading "BEHAT Email Alerts Signup Block"
      And I should see the "h3" element with the "class" attribute set to "email-alerts__heading" in the "uswds_main_block" region
      And I should see the heading "This block will send alerts straight to your inbox!"
    When I fill in "email" with "john_doe@tester.com"
      And I press "Subscribe"
    Then I should see the text "New Subscriber"

  @api @javascript
  Scenario: Adding a Investor.gov Global Block
    Given I am logged in as a user with the "sitebuilder" role
      And I create "media" of type "image_media":
      | name         | field_media_image           | field_media_caption | status |
      | Investor.gov | behat-sec-logo-investor.png | Investor CTA        | 1      |
      And "landing_page" content:
      | title                           | moderation_state |
      | BEHAT Investor gov Global Block | published        |
    # Adding investor.gov logo (media) to investor global block that has been created manually
    When I am on "/admin/structure/block/block-content"
      And I click "Edit" in the "Investor.gov: Call to action Block" row
      And I press "Add media"
      And I click on the element with css selector "div.views-field.views-field-rendered-entity.js-click-to-select-trigger.media-library-item__click-to-select-trigger"
      And I click "Insert selected" on the modal "Add or select media"
      And I press "Save"
    # Adding the investor block to the "BEHAT Investor gov Global Block" landing page using layout builder
    When I am on "/page/behat-investor-gov-global-block/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I fill in "Filter by block name" with "Investor.gov: Call to action Block"
      And I click "Investor.gov: Call to action Block" in the "landingpage_blocks" region
      And I fill in "Title" with "BEHAT Investor CTA Block"
      And I press "Add block"
    Then I should see the text "BEHAT Investor CTA Block"
      And I scroll to the top
      And I press "Save layout"
    When I am not logged in
      And I am on "/page/behat-investor-gov-global-block"
    Then I should see the heading "BEHAT Investor gov Global Block"
      And I should see the heading "BEHAT Investor CTA Block"
    When I click "Visit Investor.gov"
    Then I should be on "https://www.investor.gov/"

  @api @javascript
  Scenario: Updating Investor.gov Global Block will update everywhere the block displays on the site
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                             | moderation_state |
      | BEHAT Investor gov Global Block 1 | published        |
      | BEHAT Investor gov Global Block 2 | published        |
      And I create "media" of type "image_media":
      | name         | field_media_image           | field_media_caption | status |
      | Investor.gov | behat-sec-logo-investor.png | Investor CTA        | 1      |
    # Adding investor.gov logo (media) to investor global block that has been created manually
    When I am on "/admin/structure/block/block-content"
      And I click "Edit" in the "Investor.gov: Call to action Block" row
      And I press the "Add media" button
      And I click on the element with css selector "div.views-field.views-field-rendered-entity.js-click-to-select-trigger.media-library-item__click-to-select-trigger"
      And I click "Insert selected" on the modal "Add or select media"
      And I press "Save"
    # Adding the investor block to the "BEHAT Investor gov Global Block 1" landing page using layout builder
    When I am on "/page/behat-investor-gov-global-block-1/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I fill in "Filter by block name" with "Investor.gov: Call to action Block"
      And I click "Investor.gov: Call to action Block" in the "landingpage_blocks" region
      And I fill in "Title" with "BEHAT Investor CTA Block"
      And I press "Add block"
    Then I should see the text "BEHAT Investor CTA Block"
      And I scroll to the top
    When I press "Save layout"
    Then I should see the heading "BEHAT Investor gov Global Block 1"
      And I should see the heading "BEHAT Investor CTA Block"
      And I should see the text "Financial Tools and Calculators"
    # Adding the same investor block to the "BEHAT Investor gov Global Block 2" landing page using layout builder
    When I am on "/page/behat-investor-gov-global-block-2/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I fill in "Filter by block name" with "Investor.gov: Call to action Block"
      And I click "Investor.gov: Call to action Block" in the "landingpage_blocks" region
      And I fill in "Title" with "BEHAT Investor CTA Block"
      And I press "Add block"
    Then I should see the text "BEHAT Investor CTA Block"
      And I scroll to the top
      And I press "Save layout"
      And I should see the heading "BEHAT Investor gov Global Block 2"
      And I should see the heading "BEHAT Investor CTA Block"
      And I should see the text "Financial Tools and Calculators"
    # Updating Investor.gov Global Block
    When I am on "/admin/structure/block/block-content"
      And I click "Edit" in the "Investor.gov: Call to action Block" row
      And I fill in "field_sidebar_list_items[0][value]" with "FABIO COINS ARE FABULOUS"
      And I fill in "URL" with "https://www.investor.gov/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-alerts/digital-asset"
      And I fill in "Link text" with "Invest in Fabio Coins"
      And I press "Save"
      And I am not logged in
      And I visit "/page/behat-investor-gov-global-block-1"
    Then I should not see the text "Financial Tools and Calculators"
      And I should see the text "FABIO COINS ARE FABULOUS"
    When I click "Invest in Fabio Coins"
    Then I should see the text "Digital Asset and “Crypto” Investment Scams – Investor Alert"
    When I visit "/page/behat-investor-gov-global-block-2"
    Then I should not see the text "Financial Tools and Calculators"
      And I should see the text "FABIO COINS ARE FABULOUS"
    When I click "Invest in Fabio Coins"
    Then I should see the text "Digital Asset and “Crypto” Investment Scams – Investor Alert"
    # Cleanup - Revert changes to Investor.gov Global Block
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/admin/structure/block/block-content"
      And I click "Edit" in the "Investor.gov: Call to action Block" row
      And I fill in "field_sidebar_list_items[0][value]" with "Financial Tools and Calculators"
      And I fill in "URL" with "https://www.investor.gov"
      And I fill in "Link text" with "Visit Investor.gov"
      And I press "Save"
    Then I should see the text "Card with Sidebar Investor.gov: Call to action Block has been updated."

  @api @javascript
  Scenario: Adding a Component Block - Custom Basic Card Group
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                         | moderation_state |
      | BEHAT Custom Basic Card Group | published        |
      | Stop the Insanity             | published        |
      | Stop the War                  | published        |
      | Stop the Crimes               | published        |
      And I create "media" of type "image_media":
      | name             | field_media_image           | field_media_caption | status | mid    |
      | Investorgov logo | behat-sec-logo-investor.png | investor.gov        | 1      | 902100 |
      | F-35             | behat-f35.png               | a F-35 fighter jet  | 1      | 902101 |
      | F-22             | behat-f22-1.png             | a F-22 fighter jet  | 1      | 902102 |
    # Adding the cards using layout builder
    When I am on "/page/behat-custom-basic-card-group/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I click "Component Block"
      And I fill in "Title" with "BEHAT Custom Basic Card Group"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-card-group.dropbutton-action.secondary-action"
      # Create card 1
      And I fill in "settings[block_form][field_text][0][subform][field_card][0][subform][field_title][0][value]" with "Card 1"
      And I fill in "Body" with "This is card one"
      And I select the first autocomplete option for "Stop the Insanity" on the "URL" field
      And I fill in "Link text" with "investor.gov"
      And I select the first autocomplete option for "Investorgov logo" on the "Use existing media" field
      And I press "Add Card"
      # Create card 2
      And I fill in "settings[block_form][field_text][0][subform][field_card][1][subform][field_title][0][value]" with "Card 2"
      And I fill in "Body" with "This is card two"
      And I select the first autocomplete option for "Stop the War" on the "URL" field
      And I fill in "Link text" with "FIGHTER JET"
      And I select the first autocomplete option for "F-35" on the "Use existing media" field
      And I press "Add Card"
      # Create card 3
      And I fill in "settings[block_form][field_text][0][subform][field_card][2][subform][field_title][0][value]" with "Card 3"
      And I fill in "Body" with "This is card three"
      And I select the first autocomplete option for "Stop the Crimes" on the "URL" field
      And I fill in "Link text" with "Supersonic"
      And I select the first autocomplete option for "F-22" on the "Use existing media" field
      And I press "Add block"
    Then I should see the text "BEHAT Custom Basic Card Group"
    When I scroll to the top
      And I press "Save layout"
      And I am not logged in
      And I am on "/page/behat-custom-basic-card-group"
    Then I should see the heading "BEHAT Custom Basic Card Group"
      And I should see the heading "Card 1"
      And I should see the heading "Card 2"
      And I should see the heading "Card 3"
      And I should see the text "This is card one"
      And I should see the text "This is card two"
      And I should see the text "This is card three"
      And I should see the link "investor.gov"
      And I should see the link "FIGHTER JET"
      And I should see the link "Supersonic"
    When I click "FIGHTER JET"
    Then I should see the heading "Stop the War"

 @api @javascript
  Scenario: Modifying Custom Basic Card Group
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                         | moderation_state |
      | BEHAT Custom Basic Card Group | published        |
      | Stop the Insanity             | published        |
      | Stop the War                  | published        |
      | Stop the Crimes               | published        |
      And I create "media" of type "image_media":
      | name             | field_media_image           | field_media_caption | status | mid    |
      | Investorgov logo | behat-sec-logo-investor.png | investor.gov        | 1      | 902100 |
      | F-35             | behat-f35.png               | a F-35 fighter jet  | 1      | 902101 |
      | F-22             | behat-f22-1.png             | a F-22 fighter jet  | 1      | 902102 |
    # Adding the cards using layout builder
    When I am on "/page/behat-custom-basic-card-group/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I click "Component Block"
      And I fill in "Title" with "BEHAT Custom Basic Cards"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-card-group.dropbutton-action.secondary-action"
      # Create card 1
      And I fill in "settings[block_form][field_text][0][subform][field_card][0][subform][field_title][0][value]" with "Card 1"
      And I fill in "Body" with "This is card one"
      And I select the first autocomplete option for "Stop the Insanity" on the "URL" field
      And I fill in "Link text" with "investor.gov"
      And I select the first autocomplete option for "Investorgov logo" on the "Use existing media" field
      And I press "Add Card"
      # Create card 2
      And I fill in "settings[block_form][field_text][0][subform][field_card][1][subform][field_title][0][value]" with "Card 2"
      And I fill in "Body" with "This is card two"
      And I select the first autocomplete option for "Stop the War" on the "URL" field
      And I fill in "Link text" with "FIGHTER JET"
      And I select the first autocomplete option for "F-35" on the "Use existing media" field
      And I press "Add Card"
      # Create card 3
      And I fill in "settings[block_form][field_text][0][subform][field_card][2][subform][field_title][0][value]" with "Card 3"
      And I fill in "Body" with "This is card three"
      And I select the first autocomplete option for "Stop the Crimes" on the "URL" field
      And I fill in "Link text" with "Supersonic"
      And I select the first autocomplete option for "F-22" on the "Use existing media" field
      And I press "Add block"
    Then I should see the text "BEHAT Custom Basic Cards"
    When I scroll to the top
      And I press "Save layout"
      And I am not logged in
      And I am on "/page/behat-custom-basic-card-group"
    Then "Card 1" should precede "Card 2" for the query "//div[contains(@class, 'usa-card__header')]//h2"
      And "Card 2" should precede "Card 3" for the query "//div[contains(@class, 'usa-card__header')]//h2"
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/page/behat-custom-basic-card-group/layout"
      And I scroll ".layout-builder__region" into view
      And I hover over the element "#layout-builder > div:nth-child(2) > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.block-layout-builder.block-inline-blockcomponent-block"
      And I wait 1 seconds
      And I click on the element with css selector "#layout-builder > div:nth-child(2) > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.block-layout-builder.block-inline-blockcomponent-block > div.contextual > ul > li.layout-builder-block-update > a"
      # Un-checking "Display title" checkbox
      And I click on the element with css selector "#layout-builder-update-block > div.usa-checkbox.js-form-item.form-item.js-form-type-checkbox.form-type-checkbox.js-form-item-settings-label-display.form-item-settings-label-display > label"
      # Make modifications
      And I press "Show row weights"
      And I press "settings_block_form_field_text_0_edit"
      And I press "settings_block_form_field_text_0_subform_field_card_1_edit"
      And I fill in "settings[block_form][field_text][0][subform][field_card][1][subform][field_title][0][value]" with "Card X"
      And I fill in "settings[block_form][field_text][0][subform][field_card][1][subform][field_button][0][title]" with "Top Gun"
      And I select "3" from "settings[block_form][field_text][0][subform][field_card][0][_weight]"
      And I select "1" from "settings[block_form][field_text][0][subform][field_card][1][_weight]"
      And I select "2" from "settings[block_form][field_text][0][subform][field_card][2][_weight]"
      And I press "Update"
      And I scroll to the top
      And I press "Save layout"
      And I am not logged in
      And I am on "/page/behat-custom-basic-card-group"
    Then "Card X" should precede "Card 3" for the query "//div[contains(@class, 'usa-card__header')]//h2"
      And "Card 3" should precede "Card 1" for the query "//div[contains(@class, 'usa-card__header')]//h2"
      And I should not see the text "BEHAT Custom Basic Cards"

 @api @javascript
  Scenario: Removing Card In Custom Basic Card Group
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                         | moderation_state |
      | BEHAT Custom Basic Card Group | published        |
      | Stop the Insanity             | published        |
      | Stop the War                  | published        |
      | Stop the Crimes               | published        |
      And I create "media" of type "image_media":
      | name             | field_media_image           | field_media_caption | status | mid    |
      | Investorgov logo | behat-sec-logo-investor.png | investor.gov        | 1      | 902100 |
      | F-35             | behat-f35.png               | a F-35 fighter jet  | 1      | 902101 |
      | F-22             | behat-f22-1.png             | a F-22 fighter jet  | 1      | 902102 |
    # Adding the cards using layout builder
    When I am on "/page/behat-custom-basic-card-group/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I click "Component Block"
      And I fill in "Title" with "BEHAT Custom Basic Cards"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-card-group.dropbutton-action.secondary-action"
      # Create card 1
      And I fill in "settings[block_form][field_text][0][subform][field_card][0][subform][field_title][0][value]" with "Card 1"
      And I fill in "Body" with "This is card one"
      And I select the first autocomplete option for "Stop the Insanity" on the "URL" field
      And I fill in "Link text" with "investor.gov"
      And I select the first autocomplete option for "Investorgov logo" on the "Use existing media" field
      And I press "Add Card"
      # Create card 2
      And I fill in "settings[block_form][field_text][0][subform][field_card][1][subform][field_title][0][value]" with "Card 2"
      And I fill in "Body" with "This is card two"
      And I select the first autocomplete option for "Stop the War" on the "URL" field
      And I fill in "Link text" with "FIGHTER JET"
      And I select the first autocomplete option for "F-35" on the "Use existing media" field
      And I press "Add Card"
      # Create card 3
      And I fill in "settings[block_form][field_text][0][subform][field_card][2][subform][field_title][0][value]" with "Card 3"
      And I fill in "Body" with "This is card three"
      And I select the first autocomplete option for "Stop the Crimes" on the "URL" field
      And I fill in "Link text" with "Supersonic"
      And I select the first autocomplete option for "F-22" on the "Use existing media" field
      And I press "Add block"
    Then I should see the text "BEHAT Custom Basic Cards"
    When I scroll to the top
      And I press "Save layout"
      And I am not logged in
      And I am on "/page/behat-custom-basic-card-group"
    Then I should see the heading "Card 1"
      And I should see the heading "Card 2"
      And I should see the heading "Card 3"
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/page/behat-custom-basic-card-group/layout"
      And I scroll ".layout-builder__region" into view
      And I hover over the element "#layout-builder > div:nth-child(2) > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.block-layout-builder.block-inline-blockcomponent-block"
      And I wait 1 seconds
      And I click on the element with css selector "#layout-builder > div:nth-child(2) > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.block-layout-builder.block-inline-blockcomponent-block > div.contextual > ul > li.layout-builder-block-update > a"
      # Deleting a card
      And I press "settings_block_form_field_text_0_edit"
      And I press "Toggle Actions" in the "subforms" region
      And I press "settings_block_form_field_text_0_subform_field_card_0_remove"
      And I press "Update"
      And I scroll to the top
      And I press "Save layout"
      And I am not logged in
      And I am on "/page/behat-custom-basic-card-group"
    Then I should not see the text "Card 1"
      And I should see the heading "Card 2"
      And I should see the heading "Card 3"
      And "Card 2" should precede "Card 3" for the query "//div[contains(@class, 'usa-card__header')]//h2"

  @api @javascript
  Scenario: Adding Component Block - Custom Horizontal Card Group
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                              | moderation_state |
      | BEHAT Custom Horizontal Card Group | published        |
      | Stop the War                       | published        |
      | Stop the Crimes                    | published        |
      And I create "media" of type "image_media":
      | name             | field_media_image           | field_media_caption | status | mid    |
      | Investorgov logo | behat-sec-logo-investor.png | investor.gov        | 1      | 902100 |
      | F-35             | behat-f35.png               | a F-35 fighter jet  | 1      | 902101 |
      | F-22             | behat-f22-1.png             | a F-22 fighter jet  | 1      | 902102 |
    # Adding the horizontal card using layout builder
    When I am on "/page/behat-custom-horizontal-card-group/layout"
      And I click "Add section"
      And I wait for ajax to finish
      And I click "One column"
      And I wait for ajax to finish
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Component Block"
      And I wait for ajax to finish
      And I fill in "Title" with "BEHAT Custom Horizontal Card Group"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-horizontal-card.dropbutton-action.secondary-action"
      And I fill in "settings[block_form][field_text][0][subform][field_title_horz_card][0][value]" with "Horizontal Card 1"
      And I fill in "settings[block_form][field_text][0][subform][field_body_horz_card][0][value]" with "This is the horizontal card one"
      And I select the first autocomplete option for "Stop the War" on the "settings[block_form][field_text][0][subform][field_button_horz_card][0][uri]" field
      And I fill in "Link text" with "No More War"
      And I select the first autocomplete option for "F-22" on the "Use existing media" field
      # Adding another horizontal card through Duplicate functionality
      And I click on the element with css selector "div.paragraphs-actions > div"
      And I press "Duplicate"
      And I fill in "settings[block_form][field_text][1][subform][field_title_horz_card][0][value]" with "Horizontal Card 2"
      And I fill in "settings[block_form][field_text][1][subform][field_body_horz_card][0][value]" with "This is the horizontal card two"
      And I select the first autocomplete option for "Stop the Crimes" on the "settings[block_form][field_text][1][subform][field_button_horz_card][0][uri]" field
      And I select the first autocomplete option for "F-35" on the "settings[block_form][field_text][1][subform][field_image_horz_card][0][target_id]" field
      And I fill in "settings[block_form][field_text][1][subform][field_button_horz_card][0][title]" with "Top Gun"
      And I press "Add block"
      And I should see the text "BEHAT Custom Horizontal Card Group"
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I should see the text "The layout override has been saved."
    # Viewing as a site visitor
    When I am not logged in
      And I am on "/page/behat-custom-horizontal-card-group"
    Then I should see the heading "BEHAT Custom Horizontal Card Group"
      And I should see the heading "Horizontal Card 1"
      And I should see the heading "Horizontal Card 2"
      And I should see the text "This is the horizontal card one"
      And I should see the text "This is the horizontal card two"
    When I click "No More War"
    Then I should see the heading "Stop the War"
    When I move backward one page
      And I click "Top Gun"
    Then I should see the heading "Stop the Crimes"

  @api @javascript
  Scenario: Adding Component Block - SubPage Card Group
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                    | moderation_state |
      | BEHAT SubPage Card Group | published        |
      | Stop the War             | published        |
      | Stop the Crimes          | published        |
      | Stop the Insanity        | published        |
    # Adding the horizontal card using layout builder
    When I am on "/page/behat-subpage-card-group/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I click "Component Block"
      And I fill in "Title" with "BEHAT SubPage Card Group"
      And I click on the element with css selector "li.dropbutton-toggle"
      # Adding SubPage card 1
      And I click on the element with css selector "li.add-more-button-subpage-card-group.dropbutton-action.secondary-action"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][0][subform][field_title_subpage_card][0][value]" with "SubPage Card 1"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][0][subform][field_body_subpage_card][0][value]" with "This is SubPage card one"
      And I select the first autocomplete option for "Stop the War" on the "Link" field
      # Adding SubPage card 2
      And I press "settings_block_form_field_text_0_subform_field_subpage_card_subpage_card_add_more"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][1][subform][field_title_subpage_card][0][value]" with "SubPage Card 2"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][1][subform][field_body_subpage_card][0][value]" with "This is SubPage card two"
      And I select the first autocomplete option for "Stop the Crimes" on the "Link" field
      # Adding SubPage card 3
      And I press "settings_block_form_field_text_0_subform_field_subpage_card_subpage_card_add_more"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][2][subform][field_title_subpage_card][0][value]" with "SubPage Card 3"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][2][subform][field_body_subpage_card][0][value]" with "This is SubPage card three"
      And I select the first autocomplete option for "Stop the Insanity" on the "Link" field
      And I press "Add block"
    Then I should see the text "BEHAT SubPage Card Group"
    # Adding SubPage card block and card to test OSSS-22567 - Subpage Card Group URL Update to allow users to link to external sites
    When I click "Add block"
      And I click "Create custom block"
      And I click "Component Block"
      And I fill in "Title" with "BEHAT SubPage Card Group for External Link Test"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-subpage-card-group.dropbutton-action.secondary-action"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][0][subform][field_title_subpage_card][0][value]" with "SubPage Card links to an external site"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][0][subform][field_body_subpage_card][0][value]" with "This is a SubPage card to link externally"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][0][subform][field_link_subpage_card][0][uri]" with "https://www.starwars.com"
      And I press "Add block"
    Then I should see the text "BEHAT SubPage Card Group for External Link Test"
      And I scroll to the top
      And I press "Save layout"
    # As a site visitor, verifying all SubPage Cards
    When I am not logged in
      And I am on "/page/behat-subpage-card-group"
    Then I should see the heading "BEHAT SubPage Card Group"
      And I should see the link "SubPage Card 1"
      And I should see the link "SubPage Card 2"
      And I should see the link "SubPage Card 3"
      And I should see the link "SubPage Card links to an external site"
    When I click "SubPage Card 1"
    Then I should see the heading "Stop the War"
    When I move backward one page
      And I click "SubPage Card 2"
    Then I should see the heading "Stop the Crimes"
    When I move backward one page
      And I click "SubPage Card 3"
    Then I should see the heading "Stop the Insanity"
    When I move backward one page
    Then the hyperlink "SubPage Card links to an external site" should match the Drupal url "https://www.starwars.com"

  @api @javascript
  Scenario: Integrate the footer with the new theme
    Given I am on "/"
      And I scroll to the bottom
    Then I should see the heading "About the SEC"
      And I should see the heading "Transparency"
      And I should see the heading "Websites"
      And I should see the heading "Site Information"
      And I should see the heading "Stay connected. Sign up for our newsletter."
      And I should see the text "Your email address"
    When I click "Budget & Performance"
    Then I should see the text "Planning, Performance, and Budget"
    When I am on "/"
      And I scroll to the bottom
      And I click on the element with css selector "section > ul > li:nth-child(2) > a"
    Then I should see the heading "Careers at the Securities and Exchange Commission"
    When I am on "/"
      And I scroll to the bottom
      And I click "Commission Votes"
    Then I should see the heading "Commission Votes"
    When I am on "/"
      And I scroll to the bottom
      And I click "Contact"
    Then I should see the heading "Contact the SEC"
    When I am on "/"
      And I scroll to the bottom
      And I click "Contracts"
    Then I should see the heading "Office of Acquisitions"
    When I am on "/"
      And I scroll to the bottom
      And I click "Data Resources"
    Then I should see the heading "SEC Data Resources"
    When I am on "/"
      And I scroll to the bottom
      And I click "Accessibility & Disability"
    Then I should see the heading "Accessibility and Disability Program"
    When I am on "/"
      And I scroll to the bottom
      And I click "Diversity & Inclusion"
    Then I should see the heading "Diversity and Inclusion"
    When I am on "/"
      And I scroll to the bottom
      And I click "FOIA"
    Then I should see the heading "The Office of FOIA Services"
    When I am on "/"
      And I scroll to the bottom
      And I click "Inspector General"
    Then I should see the heading "Office of Inspector General"
    When I am on "/"
      And I scroll to the bottom
      And I click "No FEAR Act & EEO Data"
    Then I should see the heading "Office of Equal Employment Opportunity"
    When I am on "/"
      And I scroll to the bottom
      And I click "Ombudsman"
    Then I should see the heading "Ombudsman"
    When I am on "/"
      And I scroll to the bottom
      And I click "Whistleblower Protection"
    Then I should see the heading "Office of the Whistleblower"
    When I am on "/"
      And I scroll to the bottom
      And I click on the element with css selector "div:nth-child(3) > section > ul > li:nth-child(1) > a"
      And I wait for ajax to finish
    Then I am on "https://www.investor.gov"
    When I am on "/"
      And I scroll to the bottom
      And I click "Related Sites"
    Then I should see the heading "Related Sites"
    When I am on "/"
      And I scroll to the bottom
      And I click "USA.gov"
      And I wait for ajax to finish
    Then I am on "https://www.usa.gov"
    When I am on "/"
      And I scroll to the bottom
      And I click "Plain Writing"
    Then I should see the heading "Plain Writing Initiative"
    When I am on "/"
      And I scroll to the bottom
      And I click "Privacy & Security"
    Then I should see the heading "SEC Web Site Privacy and Security Policy"
    When I am on "/"
      And I scroll to the bottom
      And I click "Sitemap"
    Then I should see the heading "Site Map"
    When I am on "/"
      And I scroll to the bottom
      And I fill in "email" with "john_doe@tester.com"
      And I press "Sign Up"
    Then I am on "/https://public.govdelivery.com/accounts/USSEC/subscribers/qualify"
    # Social media bar
    # Twitter
    When I am on "/"
      And I scroll to the bottom
      And I click "Twitter"
    Then I am on "/opa/socialmedia"
    # Facebook
    When I am on "/"
      And I scroll to the bottom
      And I click "Facebook"
    Then I am on "/opa/socialmedia"
    # RSS
    When I am on "/"
      And I scroll to the bottom
      And I click "RSS"
    Then I am on "/opa/socialmedia"
    # Youtube
    When I am on "/"
      And I scroll to the bottom
    Then the hyperlink "YouTube" should match the Drupal url "https://www.youtube.com/user/SECViews/videos"
    # Email
    When I am on "/"
      And I scroll to the bottom
      And I click "Email Updates"
    Then I am on "https://public.govdelivery.com/accounts/USSEC/subscriber/new"
    # Return to top
    When I am on "/"
      And I scroll to the bottom
      And I click "Return to top"
    Then I should see the text "We make markets work better."

  @api @javascript
  Scenario: Adding Component Block - Custom Accordion default settings
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                  | moderation_state |
      | BEHAT Custom Accordion | published        |
    # Adding the accordion block using layout builder
    When I am on "/page/behat-custom-accordion/layout"
      And I click "Add section"
      And I wait for ajax to finish
      And I click "One column"
      And I wait for ajax to finish
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Component Block"
      And I wait for ajax to finish
      And I fill in "Title" with "BEHAT Custom Accordion Block"
      And I click on the element with css selector "li.dropbutton-toggle"
      # Adding Accordion section 1
      And I click on the element with css selector "li.add-more-button-accordion.dropbutton-action"
      And I fill in "Heading" with "Accordion One"
      And I type "Accordions are cool" in the "Body" WYSIWYG editor
      # Adding Accordion section 2
      And I press "settings_block_form_field_text_0_subform_field_accoridion_section_accordion_section_add_more"
      And I fill in "Heading" with "Accordion Two"
      And I type "Accordions are awesome" in the "Body" WYSIWYG editor
      # Adding Accordion section 3
      And I press "settings_block_form_field_text_0_subform_field_accoridion_section_accordion_section_add_more"
      And I fill in "Heading" with "Accordion Three"
      And I type "Accordions can be musical" in the "Body" WYSIWYG editor
      # Adding Accordion section 4
      And I press "settings_block_form_field_text_0_subform_field_accoridion_section_accordion_section_add_more"
      And I fill in "Heading" with "Accordion Four"
      And I type "Accordions can be harmonious" in the "Body" WYSIWYG editor
      # Adding Accordion section 5
      And I press "settings_block_form_field_text_0_subform_field_accoridion_section_accordion_section_add_more"
      And I fill in "Heading" with "Accordion Five"
      And I type "Accordions have the best sound" in the "Body" WYSIWYG editor
      And I press "Add block"
      And I should see the text "BEHAT Custom Accordion Block"
      #Saving the layout
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I should see the text "The layout override has been saved."
    # As a site visitor, verifying Accordion sections are Single Select at a time and not Expanded (Default settings)
    When I am not logged in
      And I am on "/page/behat-custom-accordion"
    Then I should see the heading "BEHAT Custom Accordion"
      And I should see the text "Accordion One" in the "uswds_accordion_block" region
      And I should see the text "Accordion Two" in the "uswds_accordion_block" region
      And I should see the text "Accordion Three" in the "uswds_accordion_block" region
      And I should see the text "Accordion Four" in the "uswds_accordion_block" region
      And I should see the text "Accordion Five" in the "uswds_accordion_block" region
      And I should not see the text "Accordions are cool" in the "uswds_accordion_block" region
      And I should not see the text "Accordions are awesome" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be musical" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be harmonious" in the "uswds_accordion_block" region
      And I should not see the text "Accordions have the best sound" in the "uswds_accordion_block" region
    When I press "Accordion One"
    Then I should see the text "Accordions are cool" in the "uswds_accordion_block" region
      And I should not see the text "Accordions are awesome" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be musical" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be harmonious" in the "uswds_accordion_block" region
      And I should not see the text "Accordions have the best sound" in the "uswds_accordion_block" region
    When I press "Accordion Two"
    Then I should not see the text "Accordions are cool" in the "uswds_accordion_block" region
      And I should see the text "Accordions are awesome" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be musical" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be harmonious" in the "uswds_accordion_block" region
      And I should not see the text "Accordions have the best sound" in the "uswds_accordion_block" region
    When I press "Accordion Three"
    Then I should not see the text "Accordions are cool" in the "uswds_accordion_block" region
      And I should not see the text "Accordions are awesome" in the "uswds_accordion_block" region
      And I should see the text "Accordions can be musical" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be harmonious" in the "uswds_accordion_block" region
      And I should not see the text "Accordions have the best sound" in the "uswds_accordion_block" region
    When I press "Accordion Four"
    Then I should not see the text "Accordions are cool" in the "uswds_accordion_block" region
      And I should not see the text "Accordions are awesome" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be musical" in the "uswds_accordion_block" region
      And I should see the text "Accordions can be harmonious" in the "uswds_accordion_block" region
      And I should not see the text "Accordions have the best sound" in the "uswds_accordion_block" region
    When I press "Accordion Five"
    Then I should not see the text "Accordions are cool" in the "uswds_accordion_block" region
      And I should not see the text "Accordions are awesome" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be musical" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be harmonious" in the "uswds_accordion_block" region
      And I should see the text "Accordions have the best sound" in the "uswds_accordion_block" region

  @api @javascript
  Scenario: Custom Accordion - Verifying Accordion sections are set to Multiselectable
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                  | moderation_state |
      | BEHAT Custom Accordion | published        |
    # Adding the accordion block using layout builder
    When I am on "/page/behat-custom-accordion/layout"
      And I click "Add section"
      And I wait for ajax to finish
      And I click "One column"
      And I wait for ajax to finish
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Component Block"
      And I wait for ajax to finish
      And I fill in "Title" with "BEHAT Custom Accordion Block"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-accordion.dropbutton-action"
      # Setting "Multiselectable" option
      And I click on the element with css selector ".form-item-settings-block-form-field-text-0-subform-field-multiselectable-value label"
      # Adding Accordion section 1
      And I fill in "Heading" with "Accordion One"
      And I type "Accordions are cool" in the "Body" WYSIWYG editor
      # Adding Accordion section 2
      And I press "settings_block_form_field_text_0_subform_field_accoridion_section_accordion_section_add_more"
      And I fill in "Heading" with "Accordion Two"
      And I type "Accordions are awesome" in the "Body" WYSIWYG editor
      # Adding Accordion section 3
      And I press "settings_block_form_field_text_0_subform_field_accoridion_section_accordion_section_add_more"
      And I fill in "Heading" with "Accordion Three"
      And I type "Accordions can be musical" in the "Body" WYSIWYG editor
      And I press "Add block"
      And I should see the text "BEHAT Custom Accordion Block"
      #Saving the layout
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I should see the text "The layout override has been saved."
    # As a site visitor, verifying Accordion sections are Multiselectable
    When I am not logged in
      And I am on "/page/behat-custom-accordion"
    Then I should see the heading "BEHAT Custom Accordion"
      And I should see the text "Accordion One" in the "uswds_accordion_block" region
      And I should see the text "Accordion Two" in the "uswds_accordion_block" region
      And I should see the text "Accordion Three" in the "uswds_accordion_block" region
      And I should not see the text "Accordions are cool" in the "uswds_accordion_block" region
      And I should not see the text "Accordions are awesome" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be musical" in the "uswds_accordion_block" region
    When I press "Accordion One"
    Then I should see the text "Accordions are cool" in the "uswds_accordion_block" region
      And I should not see the text "Accordions are awesome" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be musical" in the "uswds_accordion_block" region
    When I press "Accordion Two"
    Then I should see the text "Accordions are cool" in the "uswds_accordion_block" region
      And I should see the text "Accordions are awesome" in the "uswds_accordion_block" region
      And I should not see the text "Accordions can be musical" in the "uswds_accordion_block" region
    When I press "Accordion Three"
    Then I should see the text "Accordions are cool" in the "uswds_accordion_block" region
      And I should see the text "Accordions are awesome" in the "uswds_accordion_block" region
      And I should see the text "Accordions can be musical" in the "uswds_accordion_block" region

  @api @javascript
  Scenario: Custom Accordion - Verifying Accordion sections are set to Expanded
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                  | moderation_state |
      | BEHAT Custom Accordion | published        |
    # Adding the accordion block using layout builder
    When I am on "/page/behat-custom-accordion/layout"
      And I click "Add section"
      And I wait for ajax to finish
      And I click "One column"
      And I wait for ajax to finish
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Component Block"
      And I wait for ajax to finish
      And I fill in "Title" with "BEHAT Custom Accordion Block"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-accordion.dropbutton-action"
     # Setting "Multiselectable" option (this has to be set as a result of the ootb nuance of layout buidler in order to see all expanded)
      And I click on the element with css selector ".form-item-settings-block-form-field-text-0-subform-field-multiselectable-value label"
      # Adding Accordion section 1
      # Setting "Expanded" option
      And I click on the element with css selector ".form-item-settings-block-form-field-text-0-subform-field-accoridion-section-0-subform-field-expanded-value label"
      And I fill in "Heading" with "Accordion One"
      And I type "Accordions are cool" in the "Body" WYSIWYG editor
      # Adding Accordion section 2
      And I press "settings_block_form_field_text_0_subform_field_accoridion_section_accordion_section_add_more"
      # Setting "Expanded" option
      And I click on the element with css selector ".form-item-settings-block-form-field-text-0-subform-field-accoridion-section-1-subform-field-expanded-value label"
      And I fill in "Heading" with "Accordion Two"
      And I type "Accordions are awesome" in the "Body" WYSIWYG editor
      # Adding Accordion section 3
      And I press "settings_block_form_field_text_0_subform_field_accoridion_section_accordion_section_add_more"
      # Setting "Expanded" option
      And I click on the element with css selector ".form-item-settings-block-form-field-text-0-subform-field-accoridion-section-2-subform-field-expanded-value label"
      And I fill in "Heading" with "Accordion Three"
      And I type "Accordions can be musical" in the "Body" WYSIWYG editor
      And I press "Add block"
      And I should see the text "BEHAT Custom Accordion Block"
      #Saving the layout
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I should see the text "The layout override has been saved."
    # As a site visitor, verifying Accordions sections are Expanded
    When I am not logged in
      And I am on "/page/behat-custom-accordion"
    Then I should see the heading "BEHAT Custom Accordion"
      And I should see the text "Accordion One" in the "uswds_accordion_block" region
      And I should see the text "Accordion Two" in the "uswds_accordion_block" region
      And I should see the text "Accordion Three" in the "uswds_accordion_block" region
      And I should see the text "Accordions are cool" in the "uswds_accordion_block" region
      And I should see the text "Accordions are awesome" in the "uswds_accordion_block" region
      And I should see the text "Accordions can be musical" in the "uswds_accordion_block" region

  @api @javascript
  Scenario: Adding Component Block - Custom Alert with multiple in 1 block
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title              | moderation_state |
      | BEHAT Custom Alert | published        |
    # Adding the alert block using layout builder with multiple in 1 block
    When I am on "/page/behat-custom-alert/layout"
      And I click "Add section"
      And I wait for ajax to finish
      And I click "One column"
      And I wait for ajax to finish
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Component Block"
      And I wait for ajax to finish
      And I fill in "Title" with "BEHAT Custom Alert Block"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-alert.dropbutton-action.secondary-action"
      # Adding Informative Alert
      And I select "Informative" from "settings[block_form][field_text][0][subform][field_alert_type]"
      And I fill in "Heading" with "Informative Alert"
      And I type "This is an Informative Alert" in the "Body" WYSIWYG editor
      # Adding Warning Alert
      And I click on the element with css selector "div.paragraphs-actions > div > button"
      And I press "Duplicate"
      And I select "Warning" from "settings[block_form][field_text][1][subform][field_alert_type]"
      And I fill in "Heading" with "Warning Alert"
      And I type "This is a Warning Alert" in the "Body" WYSIWYG editor
      And I press "Add block"
      And I should see the text "BEHAT Custom Alert Block"
      #Saving the layout
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I should see the text "The layout override has been saved."
    # As a site visitor, verifying alert block
    When I am not logged in
      And I am on "/page/behat-custom-alert"
    Then I should see the heading "BEHAT Custom Alert"
      And I should see the text "BEHAT Custom Alert Block"
      And I should see the text "Warning Alert" in the "uswds_accordion_block" region
      And I should see the text "This is a Warning AlertThis is an Informative Alert" in the "uswds_accordion_block" region
      And I should see the text "Informative alert" in the "uswds_accordion_block" region
      And I should see the text "This is an Informative Alert" in the "uswds_accordion_block" region

  @api @javascript
  Scenario: Adding Component Block - Custom Alert with single per block
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title              | moderation_state |
      | BEHAT Custom Alert | published        |
    # Adding the alert block using layout builder with single per block
    When I am on "/page/behat-custom-alert/layout"
      And I click "Add section"
      And I wait for ajax to finish
      And I click "One column"
      And I wait for ajax to finish
      And I press "Add section"
      # Adding Informative Alert Block
      And I click "Add block"
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Component Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Informative Alert Block"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-alert.dropbutton-action.secondary-action"
      And I select "Informative" from "settings[block_form][field_text][0][subform][field_alert_type]"
      And I fill in "Heading" with "Informative Alert"
      And I type "This is an Informative Alert" in the "Body" WYSIWYG editor
      And I press "Add block"
      And I should see the text "Informative Alert Block"
      # Adding Warning Alert Block
      And I click "Add block"
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Component Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Warning Alert Block"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-alert.dropbutton-action.secondary-action"
      And I select "Warning" from "settings[block_form][field_text][0][subform][field_alert_type]"
      And I fill in "Heading" with "Warning Alert"
      And I type "This is a Warning Alert" in the "Body" WYSIWYG editor
      And I press "Add block"
      And I should see the text "Warning Alert Block"
      # Adding Error Alert Block
      And I click "Add block"
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Component Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Error Alert Block"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-alert.dropbutton-action.secondary-action"
      And I select "Error" from "settings[block_form][field_text][0][subform][field_alert_type]"
      And I fill in "Heading" with "Error Alert"
      And I type "This is an Error Alert" in the "Body" WYSIWYG editor
      And I press "Add block"
      And I should see the text "Error Alert Block"
      # Adding Success Alert Block
      And I click "Add block"
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Component Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Success Alert Block"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-alert.dropbutton-action.secondary-action"
      And I select "Success" from "settings[block_form][field_text][0][subform][field_alert_type]"
      And I fill in "Heading" with "Success Alert"
      And I type "This is a Success Alert" in the "Body" WYSIWYG editor
      And I press "Add block"
      And I should see the text "Success Alert Block"
      # Adding None Alert Block
      And I click "Add block"
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Component Block"
      And I wait for ajax to finish
      And I fill in "Title" with "None Alert Block"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-alert.dropbutton-action.secondary-action"
      And I select "None" from "settings[block_form][field_text][0][subform][field_alert_type]"
      And I fill in "Heading" with "None Alert"
      And I type "This is a None Alert" in the "Body" WYSIWYG editor
      And I press "Add block"
      #Saving the layout
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I should see the text "The layout override has been saved."
    # As a site visitor, verifying alert blocks
    When I am not logged in
      And I am on "/page/behat-custom-alert"
    Then I should see the heading "BEHAT Custom Alert"
      And I should see the text "Informative Alert Block" in the "uswds_accordion_block" region
      And I should see the text "Informative alert" in the "uswds_accordion_block" region
      And I should see the text "This is an Informative Alert" in the "uswds_accordion_block" region
      And I should see the text "Warning Alert Block" in the "uswds_accordion_block" region
      And I should see the text "Warning alert" in the "uswds_accordion_block" region
      And I should see the text "This is a Warning Alert" in the "uswds_accordion_block" region
      And I should see the text "Error Alert Block" in the "uswds_accordion_block" region
      And I should see the text "Error alert" in the "uswds_accordion_block" region
      And I should see the text "This is an Error Alert" in the "uswds_accordion_block" region
      And I should see the text "Success Alert Block" in the "uswds_accordion_block" region
      And I should see the text "Success alert" in the "uswds_accordion_block" region
      And I should see the text "This is a Success Alert" in the "uswds_accordion_block" region
      And I should see the text "None Alert Block" in the "uswds_accordion_block" region
      And I should see the text "None alert" in the "uswds_accordion_block" region
      And I should see the text "This is a None Alert" in the "uswds_accordion_block" region

  @api @javascript
  Scenario: Adding Component Block - Custom Alert with Link for more info
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title              | moderation_state |
      | BEHAT Custom Alert | published        |
    # Adding the alert block using layout builder
    When I am on "/page/behat-custom-alert/layout"
      And I click "Add section"
      And I wait for ajax to finish
      And I click "One column"
      And I wait for ajax to finish
      And I press "Add section"
      And I wait for ajax to finish
      # Adding Informative Alert Block with some link
      And I click "Add block"
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Component Block"
      And I wait for ajax to finish
      And I fill in "Title" with "Informative Alert Block with Link"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-alert.dropbutton-action.secondary-action"
      And I select "Informative" from "settings[block_form][field_text][0][subform][field_alert_type]"
      And I fill in "Heading" with "Informative Alert"
      And I type "This is an Informative Alert with a link for more information:                            " in the "Body" WYSIWYG editor
      And I press "Link (Ctrl+K)" in the "Body" WYSIWYG Toolbar
      And I wait for ajax to finish
      And I fill in "https://www.sec.gov/edgar/search/" for "URL" in the "modal" region
      And I click on the element with css selector "div.ui-dialog-buttonpane.ui-widget-content.ui-helper-clearfix > div"
      And I wait for ajax to finish
      And I press "Add block"
      And I should see the text "Informative Alert Block with Link"
      #Saving the layout
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I should see the text "The layout override has been saved."
    # As a site visitor, verifying alert block Link
    When I am not logged in
      And I am on "/page/behat-custom-alert"
    Then I should see the heading "BEHAT Custom Alert"
      And I should see the text "Informative Alert Block with Link" in the "uswds_accordion_block" region
      And I should see the text "Informative alert" in the "uswds_accordion_block" region
      And I should see the text "This is an Informative Alert with a link for more information" in the "uswds_accordion_block" region
    When I click "https://www.sec.gov/edgar/search/" in the "uswds_accordion_block" region
    Then I am on "https://www.sec.gov/edgar/search/"

  @api @javascript
  Scenario: Adding a Component Block - Image Block
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                          | moderation_state |
      | BEHAT Image Block Landing Page | published        |
      And I create "media" of type "image_media":
      | name   | field_media_image | field_media_caption | status |
      | F-22   | behat-f22-1.png   | a F-22 fighter jet  | 1      |
      | F-35   | behat-f35.png     | a F-35 fighter jet  | 1      |
    # Adding the image block using layout builder
    When I am on "/page/behat-image-block-landing-page/layout"
      And I click "Add section"
      And I wait for ajax to finish
      And I click "One column"
      And I wait for ajax to finish
      And I press "Add section"
      And I wait for ajax to finish
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I click "Component Block"
      And I fill in "Title" with "BEHAT Image Block"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-image.dropbutton-action.secondary-action"
      # Adding F-22 Image
      And I select the first autocomplete option for "F-22" on the "settings[block_form][field_text][0][subform][field_image][0][target_id]" field
      # Adding F-35 Image after duplicating F-22 Image section
      And I click on the element with css selector "div.paragraphs-actions > div > button"
      And I press "Duplicate"
      And I select the first autocomplete option for "F-35" on the "settings[block_form][field_text][1][subform][field_image][0][target_id]" field
      And I press "Add block"
      And I should see the text "BEHAT Image Block"
    When I scroll to the top
      And I press "Save layout"
      And I am not logged in
      And I am on "/page/behat-image-block-landing-page/"
    Then I should see the heading "BEHAT Image Block Landing Page"
      And I should see the text "BEHAT Image Block"
      And I should see the text "a F-22 fighter jet"
      And I should see the text "a F-35 fighter jet"

  @api @javascript
  Scenario: Adding a Person Card Group Block
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                                | moderation_state |
      | BEHAT Person Card Group Landing Page | published        |
      And "secperson" content:
      | title            | field_first_name_secperson | field_last_name_secperson | field_email           | field_phone  | field_primary_division_office | body                                                                                                                                               | field_enable_biography_page | status | moderation_state |
      | Luke Skywalker   | Luke                       | Skywalker                 | skywalker@testing.com | 444-222-9999 | The Rebel Alliance-Luke       | A young adult raised by his aunt and uncle on Tatooine, who dreams of something more than his current life and learns about the Force and the Jedi | 1                           | 1      | published        |
      | Princess Leia    | Leia                       | Organa                    | organa@testing.com    | 555-222-9999 | The Rebel Alliance-Leia       | The princess of the planet Alderaan who is a member of the Imperial Senate and, secretly, one of the leaders of the Rebel Alliance                 | 1                           | 1      | published        |
      | Han Solo         | Han                        | Solo                      | solo@testing.com      | 777-222-9999 | The Rebel Alliance-Solo       | A cynical smuggler and captain of the Millennium Falcon                                                                                            | 1                           | 1      | published        |
      | Lando Calrissian | Lando                      | Calrissian                | lando@testing.com     | 999-222-9999 | The Rebel Alliance-Lando      | An old friend of Han Solo and the administrator of the floating Cloud City on the gas planet Bespin                                                | 1                           | 1      | published        |
      | Wedge Antilles   | Wedge                      | Antilles                  | antilles@testing.com  | 333-222-9999 | The Rebel Alliance-Wedge      | A famed Corellian pilot and general, known as a hero of the Rebel Alliance and New Republic                                                        | 1                           | 1      | published        |
      | Obi-Wan Kenobi   | Obi-Wan                    | Kenobi                    | ob1@testing.com       | 111-222-9999 | The Rebel Alliance-OB1        | A legendary Jedi Master, he was a noble man and gifted in the ways of the Force (No image)                                                         | 1                           | 1      | published        |
    # Edit each Person page to add person image & position
    When I am on "/biography/luke-skywalker/edit"
      And I press "Add Position History"
      And I select "Other" from "Position Category"
      And I fill in "Jedi" for "Position Title"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 01-01-1999 |
      And I check "Current Position"
      And I attach the file "behat-luke.png" to "Photo"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Luke"
      And I publish it
    Then I should see the heading "Luke Skywalker"
      And I should see the "img" element with the "alt" attribute set to "Luke" in the "uswds_person_image_area" region
    When I am on "/biography/princess-leia/edit"
      And I press "Add Position History"
      And I select "Other" from "Position Category"
      And I fill in "Princess" for "Position Title"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 01-01-1999 |
      And I check "Current Position"
      And I attach the file "behat-leia.png" to "Photo"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Leia Organa"
      And I publish it
    Then I should see the heading "Princess Leia"
      And I should see the "img" element with the "alt" attribute set to "Leia Organa" in the "uswds_person_image_area" region
    When I am on "/biography/han-solo/edit"
      And I press "Add Position History"
      And I select "Other" from "Position Category"
      And I fill in "Space Pirate" for "Position Title"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 01-01-1999 |
      And I check "Current Position"
      And I attach the file "behat-han.png" to "Photo"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Han"
      And I publish it
    Then I should see the heading "Han Solo"
      And I should see the "img" element with the "alt" attribute set to "Han" in the "uswds_person_image_area" region
    When I am on "/biography/lando-calrissian/edit"
      And I press "Add Position History"
      And I select "Other" from "Position Category"
      And I fill in "Bespin Administrator" for "Position Title"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 01-01-1999 |
      And I check "Current Position"
      And I attach the file "behat-lando.png" to "Photo"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Lando"
      And I publish it
    Then I should see the heading "Lando Calrissian"
      And I should see the "img" element with the "alt" attribute set to "Lando" in the "uswds_person_image_area" region
    When I am on "/biography/wedge-antilles/edit"
      And I press "Add Position History"
      And I select "Other" from "Position Category"
      And I fill in "Corellian pilot & general" for "Position Title"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 01-01-1999 |
      And I check "Current Position"
      And I attach the file "behat-wedge.png" to "Photo"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Wedge"
      And I publish it
    Then I should see the heading "Wedge Antilles"
      And I should see the "img" element with the "alt" attribute set to "Wedge" in the "uswds_person_image_area" region
    # Image Optional - adding an image is optional
    When I am on "/biography/obi-wan-kenobi/edit"
      And I press "Add Position History"
      And I select "Other" from "Position Category"
      And I fill in "Legendary Jedi Master" for "Position Title"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 01-01-1999 |
      And I check "Current Position"
      And I publish it
    Then I should see the heading "Obi-Wan Kenobi"
      And I should not see the css selector "div.block.block-layout-builder.block-field-blocknodesecpersonfield-photo-person > div > div.field__item"
    # Adding the person card group block using layout builder & adding the cards
    When I am on "/page/behat-person-card-group-landing-page/layout"
      And I click "Add section"
      And I wait for ajax to finish
      And I click "One column"
      And I wait for ajax to finish
      And I press "Add section"
      And I wait for ajax to finish
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Person Card"
      And I fill in "Title" with "BEHAT Person Card Group"
      # Create card 1 - Luke
      And I fill in "settings[block_form][field_person_card][0][target_id]" with "Luke Skywalker"
      # Create card 2 - Leia
      And I press "Add another item"
      And I fill in "settings[block_form][field_person_card][1][target_id]" with "Princess Leia"
      # Create card 3 - Han
      And I press "Add another item"
      And I fill in "settings[block_form][field_person_card][2][target_id]" with "Han Solo"
      # Create card 4 - Lando
      And I press "Add another item"
      And I fill in "settings[block_form][field_person_card][3][target_id]" with "Lando Calrissian"
      # Create card 5 - Wedge
      And I press "Add another item"
      And I fill in "settings[block_form][field_person_card][4][target_id]" with "Wedge Antilles"
      # Create card 5 - Obi-Wan
      And I press "Add another item"
      And I fill in "settings[block_form][field_person_card][5][target_id]" with "Obi-Wan Kenobi"
      And I press "Add block"
    Then I should see the text "BEHAT Person Card Group"
    #Saving the layout
    When I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I should see the text "The layout override has been saved."
    # As a site visitor, verifying all person attributes in the card and block display
    When I am not logged in
      And I am on "/page/behat-person-card-group-landing-page"
    Then I should see the heading "BEHAT Person Card Group Landing Page"
      And I should see the link "Luke Skywalker"
      And I should see the link "Leia Organa"
      And I should see the link "Han Solo"
      And I should see the link "Lando Calrissian"
      And I should see the link "Wedge Antilles"
      And I should see the link "Obi-Wan Kenobi"
      And I should see the text "Jedi"
      And I should see the text "Princess"
      And I should see the text "Space Pirate"
      And I should see the text "Bespin Administrator"
      And I should see the text "Corellian pilot & general"
      And I should see the text "Legendary Jedi Master"
      And I should see the text "The Rebel Alliance-Luke"
      And I should see the text "The Rebel Alliance-Leia"
      And I should see the text "The Rebel Alliance-Solo"
      And I should see the text "The Rebel Alliance-Lando"
      And I should see the text "The Rebel Alliance-Wedge"
      And I should see the text "The Rebel Alliance-OB1"
      And I should see the link "skywalker@testing.com"
      And I should see the link "organa@testing.com"
      And I should see the link "solo@testing.com"
      And I should see the link "lando@testing.com"
      And I should see the link "antilles@testing.com"
      And I should see the link "ob1@testing.com"
      And I should see the link "444-222-9999"
      And I should see the link "555-222-9999"
      And I should see the link "777-222-9999"
      And I should see the link "999-222-9999"
      And I should see the link "333-222-9999"
      And I should see the link "111-222-9999"
    # Link to person page
    When I click "Wedge Antilles"
    Then I should be on "/biography/wedge-antilles"
      And I should see the heading "Wedge Antilles"

  @api @javascript
  Scenario: Hide Images for Person Card Group via Show Photo option being Unchecked
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                                | moderation_state |
      | BEHAT Person Card Group Landing Page | published        |
      And "secperson" content:
      | title            | field_first_name_secperson | field_last_name_secperson | field_email           | field_phone  | field_primary_division_office | body                                                                                                                                               | field_enable_biography_page | status | moderation_state |
      | Luke Skywalker   | Luke                       | Skywalker                 | skywalker@testing.com | 444-222-9999 | The Rebel Alliance-Luke       | A young adult raised by his aunt and uncle on Tatooine, who dreams of something more than his current life and learns about the Force and the Jedi | 1                           | 1      | published        |
      | Princess Leia    | Leia                       | Organa                    | organa@testing.com    | 555-222-9999 | The Rebel Alliance-Leia       | The princess of the planet Alderaan who is a member of the Imperial Senate and, secretly, one of the leaders of the Rebel Alliance                 | 1                           | 1      | published        |
      | Han Solo         | Han                        | Solo                      | solo@testing.com      | 777-222-9999 | The Rebel Alliance-Solo       | A cynical smuggler and captain of the Millennium Falcon                                                                                            | 1                           | 1      | published        |
    # Edit each Person page to add person image & position
    When I am on "/biography/luke-skywalker/edit"
      And I press "Add Position History"
      And I select "Other" from "Position Category"
      And I fill in "Jedi" for "Position Title"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 01-01-1999 |
      And I check "Current Position"
      And I attach the file "behat-luke.png" to "Photo"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Luke"
      And I publish it
    Then I should see the heading "Luke Skywalker"
      And I should see the "img" element with the "alt" attribute set to "Luke" in the "uswds_person_image_area" region
    When I am on "/biography/princess-leia/edit"
      And I press "Add Position History"
      And I select "Other" from "Position Category"
      And I fill in "Princess" for "Position Title"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 01-01-1999 |
      And I check "Current Position"
      And I attach the file "behat-leia.png" to "Photo"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Leia Organa"
      And I publish it
    Then I should see the heading "Princess Leia"
      And I should see the "img" element with the "alt" attribute set to "Leia Organa" in the "uswds_person_image_area" region
    When I am on "/biography/han-solo/edit"
      And I press "Add Position History"
      And I select "Other" from "Position Category"
      And I fill in "Space Pirate" for "Position Title"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 01-01-1999 |
      And I check "Current Position"
      And I attach the file "behat-han.png" to "Photo"
      And I wait for ajax to finish
      And I fill in "Alternative text" with "Han"
      And I publish it
    Then I should see the heading "Han Solo"
      And I should see the "img" element with the "alt" attribute set to "Han" in the "uswds_person_image_area" region
    # Adding the person card group block using layout builder & adding the cards
    When I am on "/page/behat-person-card-group-landing-page/layout"
      And I click "Add section"
      And I wait for ajax to finish
      And I click "One column"
      And I wait for ajax to finish
      And I press "Add section"
      And I wait for ajax to finish
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Person Card"
      And I fill in "Title" with "BEHAT Person Card Group"
     # Hide images - "Show Photo" option for card group is Unchecked
      And I click on the element with css selector ".form-item-settings-block-form-field-show-photo-value label"
      # Create card 1 - Luke
      And I fill in "settings[block_form][field_person_card][0][target_id]" with "Luke Skywalker"
      # Create card 2 - Leia
      And I press "Add another item"
      And I fill in "settings[block_form][field_person_card][1][target_id]" with "Princess Leia"
      # Create card 3 - Han
      And I press "Add another item"
      And I fill in "settings[block_form][field_person_card][2][target_id]" with "Han Solo"
      And I press "Add block"
    Then I should see the text "BEHAT Person Card Group"
    #Saving the layout
    When I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I should see the text "The layout override has been saved."
    # As a site visitor, verifying no images are displayed in the card group/block display
    When I am not logged in
      And I am on "/page/behat-person-card-group-landing-page"
    Then I should see the heading "BEHAT Person Card Group Landing Page"
      And I should not see the css selector "div > div > div:nth-child(1) > div > a > img"
      And I should not see the css selector "div:nth-child(2) > div > a > img"
      And I should not see the css selector "div:nth-child(3) > div > a > img"
