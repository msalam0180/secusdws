Feature: Layout Builder with the New Theme for WDIO
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

  @ui @api @javascript @wdio
  Scenario: New Email Alerts Signup Block
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
      And I fill in "Heading" with "This block was created by BEHAT for users to get alerts/announcements sent straight to your inbox! :-)"
      And I fill in "Email List ID" with "USSEC_C27"
      And I press "Add block"
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I take a screenshot on "sec" using "layout_builder_new_theme.feature" file with "@email_alerts_signup_block" tag

  @ui @api @javascript @wdio
  Scenario: Adding Investor.gov Global Block and update everywhere the block displays on the site
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                             | moderation_state |
      | BEHAT Investor gov Global Block 1 | published        |
      | BEHAT Investor gov Global Block 2 | published        |
      And I create "media" of type "image_media":
      | name              | field_media_image           | field_media_caption | status | mid    |
      | Investorgov Image | behat-sec-logo-investor.png | investor.gov        | 1      | 902100 |
    # Adding investor.gov logo (media) to investor global block
    When I am on "/admin/structure/block/block-content"
      And I click "Edit" in the "Investor.gov: Call to action Block" row
      # This line must be commented out in the initial run then uncommented out there-after:
      And I press "Remove"
      And I press "Add media"
      And I wait for ajax to finish
      And I click on the element with css selector "div.views-field.views-field-rendered-entity.js-click-to-select-trigger.media-library-item__click-to-select-trigger"
      And I click "Insert selected" on the modal "Add or select media"
      And I press "Save"
    # Adding the investor block to the BEHAT 1 landing page using layout builder
    When I am on "/page/behat-investor-gov-global-block-1/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I fill in "Filter by block name" with "Investor.gov: Call to action Block"
      And I click "Investor.gov: Call to action Block" in the "landingpage_blocks" region
      And I wait for ajax to finish
      And I fill in "Title" with "BEHAT Investor CTA Block"
      And I press "Add block"
      And I scroll to the top
      And I press "Save layout"
    # Adding the same investor block to the BEHAT 2 landing page using layout builder
    When I am on "/page/behat-investor-gov-global-block-2/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I fill in "Filter by block name" with "Investor.gov: Call to action Block"
      And I click "Investor.gov: Call to action Block" in the "landingpage_blocks" region
      And I fill in "Title" with "BEHAT Investor CTA Block"
      And I press "Add block"
      And I scroll to the top
      And I press "Save layout"
    # Updating Investor.gov Global Block and taking screenshots
    When I am on "/admin/structure/block/block-content"
      And I click "Edit" in the "Investor.gov: Call to action Block" row
      And I fill in "field_sidebar_list_items[0][value]" with "FABIO COINS ARE FABULOUS"
      And I fill in "URL" with "https://www.investor.gov/introduction-investing/general-resources/news-alerts/alerts-bulletins/investor-alerts/digital-asset"
      And I fill in "Link text" with "Invest in Fabio Coins"
      And I press "Save"
      And I wait for ajax to finish
    Then I take a screenshot on "sec" using "layout_builder_new_theme.feature" file with "@investor_dot_gov_block" tag
    # Cleanup - Revert changes to Investor.gov Global Block
    When I am on "/admin/structure/block/block-content"
      And I click "Edit" in the "Investor.gov: Call to action Block" row
      And I fill in "field_sidebar_list_items[0][value]" with "Financial Tools and Calculators"
      And I fill in "URL" with "https://www.investor.gov"
      And I fill in "Link text" with "Visit Investor.gov"
      And I press "Save"

  @ui @api @javascript @wdio
  Scenario: Custom Basic Card Group from Component Block
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                         | moderation_state |
      | BEHAT Custom Basic Card Group | published        |
      And I create "media" of type "image_media":
      | name              | field_media_image           | field_media_caption | status | mid    |
      | Investorgov Image | behat-sec-logo-investor.png | investor.gov        | 1      | 902100 |
      | F-35              | behat-f35.png               | a F-35 fighter jet  | 1      | 902101 |
      | F-22              | behat-f22-1.png             | a F-22 fighter jet  | 1      | 902102 |
    # Adding the cards using layout builder
    When I am on "page/behat-custom-basic-card-group/layout"
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
      And I fill in "URL" with "https://www.tesla.com"
      And I fill in "Link text" with "Tesla"
      And I select the first autocomplete option for "Investorgov Image" on the "Use existing media" field
      And I press "Add Card"
      # Create card 2
      And I fill in "settings[block_form][field_text][0][subform][field_card][1][subform][field_title][0][value]" with "Card 2"
      And I fill in "Body" with "This is card two"
      And I fill in "URL" with "https://www.apple.com"
      And I fill in "Link text" with "Apple"
      And I select the first autocomplete option for "F-35" on the "Use existing media" field
      And I press "Add Card"
      # Create card 3
      And I fill in "settings[block_form][field_text][0][subform][field_card][2][subform][field_title][0][value]" with "Card 3"
      And I fill in "Body" with "This is card three"
      And I fill in "URL" with "https://www.google.com"
      And I fill in "Link text" with "Google"
      And I select the first autocomplete option for "F-22" on the "Use existing media" field
      And I press "Add block"
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I take a screenshot on "sec" using "layout_builder_new_theme.feature" file with "@custom_basic_card_group" tag

  @ui @api @javascript @wdio
  Scenario: Custom Horizontal Card Group from Component Block
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                              | moderation_state |
      | BEHAT Custom Horizontal Card Group | published        |
      And I create "media" of type "image_media":
      | name   | field_media_image | field_media_caption | status | mid    |
      | F-22-1 | behat-f22-1.png   | a F-22 fighter jet  | 1      | 902102 |
      | F-35   | behat-f35.png     | a F-35 fighter jet  | 1      | 902101 |
    # Adding the horizontal card using layout builder
    When I am on "page/behat-custom-horizontal-card-group/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I click "Component Block"
      And I fill in "Title" with "BEHAT Custom Horizontal Card Group"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-horizontal-card.dropbutton-action.secondary-action"
      And I fill in "settings[block_form][field_text][0][subform][field_title_horz_card][0][value]" with "Horizontal Card 1"
      And I fill in "settings[block_form][field_text][0][subform][field_body_horz_card][0][value]" with "This is the horizontal card one"
      And I fill in "URL" with "https://www.google.com"
      And I fill in "Link text" with "Top Gun"
      And I select the first autocomplete option for "F-22-1" on the "Use existing media" field
      # Adding another horizontal card through duplicate functionality
      And I click on the element with css selector "div.paragraphs-actions > div"
      And I press "Duplicate"
      And I fill in "settings[block_form][field_text][1][subform][field_title_horz_card][0][value]" with "Horizontal Card 2"
      And I fill in "settings[block_form][field_text][1][subform][field_body_horz_card][0][value]" with "This is the horizontal card two"
      And I fill in "settings[block_form][field_text][1][subform][field_button_horz_card][0][title]" with "Top Gun Maverick"
      And I select the first autocomplete option for "F-35" on the "settings[block_form][field_text][1][subform][field_image_horz_card][0][target_id]" field
      And I press "Add block"
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I take a screenshot on "sec" using "layout_builder_new_theme.feature" file with "@custom_horizontal_card_group" tag

  @ui @api @javascript @wdio
  Scenario: SubPage Card Group from Component Block
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                    | moderation_state |
      | BEHAT SubPage Card Group | published        |
    # Adding the horizontal card using layout builder
    When I am on "page/behat-subpage-card-group/layout"
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
      And I select the first autocomplete option for "Press Release" on the "Link" field
      # Adding SubPage card 2
      And I press "settings_block_form_field_text_0_subform_field_subpage_card_subpage_card_add_more"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][1][subform][field_title_subpage_card][0][value]" with "SubPage Card 2"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][1][subform][field_body_subpage_card][0][value]" with "This is SubPage card two"
      And I select the first autocomplete option for "Press Release" on the "Link" field
      # Adding SubPage card 3
      And I press "settings_block_form_field_text_0_subform_field_subpage_card_subpage_card_add_more"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][2][subform][field_title_subpage_card][0][value]" with "SubPage Card 3"
      And I fill in "settings[block_form][field_text][0][subform][field_subpage_card][2][subform][field_body_subpage_card][0][value]" with "This is SubPage card three"
      And I select the first autocomplete option for "Press Release" on the "Link" field
      And I press "Add block"
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I take a screenshot on "sec" using "layout_builder_new_theme.feature" file with "@subpage_card_group" tag

  @ui @api @javascript @wdio
  Scenario: Footer integration using new theme
    Given I am on "/"
      And I scroll to the bottom
    Then I take a screenshot on "sec" using "layout_builder_new_theme.feature" file with "@new_theme_footer" tag

  @ui @api @javascript @wdio
  Scenario: Custom Accordion from Component Block
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
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I take a screenshot on "sec" using "layout_builder_new_theme.feature" file with "@custom_accordian_block" tag

  @ui @api @javascript @wdio
  Scenario: Custom Alert from Component Block
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
      # Saving the layout
      And I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I take a screenshot on "sec" using "layout_builder_new_theme.feature" file with "@custom_alert_block" tag

  @ui @api @javascript @wdio
  Scenario: Image from Component Block
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                          | moderation_state |
      | BEHAT Image Block Landing Page | published        |
      And I create "media" of type "image_media":
      | name   | field_media_image | field_media_caption | status |
      | F-22   | behat-f22-1.png   | a F-22 fighter jet  | 1      |
      | Birds  | behat-birds.gif   | Birds sitting       | 1      |
    # Adding the image block using layout builder
    When I am on "/page/behat-image-block-landing-page/layout"
      And I click "Add section"
      And I click "One column"
      And I press "Add section"
      And I click "Add block"
      And I click "Create custom block"
      And I click "Component Block"
      And I fill in "Title" with "BEHAT Image Block"
      And I click on the element with css selector "li.dropbutton-toggle"
      And I click on the element with css selector "li.add-more-button-image.dropbutton-action.secondary-action"
      # Adding F-22 Image
      And I select the first autocomplete option for "F-22" on the "settings[block_form][field_text][0][subform][field_image][0][target_id]" field
      # Adding Birds Image after duplicating F-22 Image section
      And I click on the element with css selector "div.paragraphs-actions > div > button"
      And I press "Duplicate"
      And I select the first autocomplete option for "Birds" on the "settings[block_form][field_text][1][subform][field_image][0][target_id]" field
      And I press "Add block"
    When I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I take a screenshot on "sec" using "layout_builder_new_theme.feature" file with "@image_block" tag

  @ui @api @javascript @wdio
  Scenario: Person Card Block
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title                                | moderation_state |
      | BEHAT Person Card Group Landing Page | published        |
      And "secperson" content:
      | title            | field_first_name_secperson | field_last_name_secperson | field_email_secperson | field_phone_secperson | field_primary_division_office | body                                                                                                                                               | field_enable_biography_page | status | moderation_state |
      | Luke Skywalker   | Luke                       | Skywalker                 | skywalker@testing.com | 444-222-9999          | The Rebel Alliance-Luke       | A young adult raised by his aunt and uncle on Tatooine, who dreams of something more than his current life and learns about the Force and the Jedi | 1                           | 1      | published        |
      | Princess Leia    | Leia                       | Organa                    | organa@testing.com    | 555-222-9999          | The Rebel Alliance-Leia       | The princess of the planet Alderaan who is a member of the Imperial Senate and, secretly, one of the leaders of the Rebel Alliance                 | 1                           | 1      | published        |
      | Han Solo         | Han                        | Solo                      | solo@testing.com      | 777-222-9999          | The Rebel Alliance-Solo       | A cynical smuggler and captain of the Millennium Falcon                                                                                            | 1                           | 1      | published        |
      | Lando Calrissian | Lando                      | Calrissian                | lando@testing.com     | 999-222-9999          | The Rebel Alliance-Lando      | An old friend of Han Solo and the administrator of the floating Cloud City on the gas planet Bespin                                                | 1                           | 1      | published        |
      | Wedge Antilles   | Wedge                      | Antilles                  | antilles@testing.com  | 333-222-9999          | The Rebel Alliance-Wedge      | A famed Corellian pilot and general, known as a hero of the Rebel Alliance and New Republic                                                        | 1                           | 1      | published        |
      | Obi-Wan Kenobi   | Obi-Wan                    | Kenobi                    | ob1@testing.com       | 111-222-9999          | The Rebel Alliance-OB1        | A legendary Jedi Master, he was a noble man and gifted in the ways of the Force (No image)                                                         | 1                           | 1      | published        |
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
    When I am on "/biography/obi-wan-kenobi/edit"
      And I press "Add Position History"
      And I select "Other" from "Position Category"
      And I fill in "Legendary Jedi Master" for "Position Title"
      And I fill in the following:
        | field_position_history_paragraph[0][subform][field_from][0][value][date] | 01-01-1999 |
      And I check "Current Position"
      And I publish it
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
      # Show Phone & Email (checkboxes checked)
      And I click on the element with css selector ".form-item-settings-block-form-field-show-phone-value label"
      And I click on the element with css selector ".form-item-settings-block-form-field-show-email-value label"
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
    #Saving the layout
    When I scroll to the top
      And I press "Save layout"
      And I wait for ajax to finish
    Then I take a screenshot on "sec" using "layout_builder_new_theme.feature" file with "@person_card_block" tag
