Feature: Layout Builder with the New Theme Views
  As a sitebuilder or above user can use Layout Builder to SEC.gov
  I want to be able to view content that allows for layouts
  So that I quickly change the section and/or blocks

  @email_alerts_signup_block @wdio
  Scenario: Email Alert Signup Block
    Given I set my screensize to desktop
    When I visit "/page/behat-layout-builder-new-theme-email-alert-block-lp"
    Then I take screenshot of element "#block-uswds-sec-content"

 @investor_dot_gov_block @wdio
  Scenario: Investor.gov Global Block
    Given I set my screensize to desktop
    When I visit "/page/behat-investor-gov-global-block-1"
    Then I take screenshot of element "#block-uswds-sec-content"
    When I visit "/page/behat-investor-gov-global-block-2"
    Then I take screenshot of element "#block-uswds-sec-content"

  @custom_basic_card_group @wdio
  Scenario: Custom Basic Card Group using the Component Block
    Given I set my screensize to desktop
    When I visit "/page/behat-custom-basic-card-group"
    Then I take screenshot of element "#block-uswds-sec-content"

  @custom_horizontal_card_group @wdio
  Scenario: Custom Horizontal Card Group with Component Block
    Given I set my screensize to desktop
    When I visit "/page/behat-custom-horizontal-card-group"
    Then I take screenshot of element "#block-uswds-sec-content"

  @subpage_card_group @wdio
  Scenario: Subpage Card Group with Component Block
    Given I set my screensize to desktop
    When I visit "/page/behat-subpage-card-group"
    Then I take screenshot of element "#block-uswds-sec-content"

  @new_theme_footer @wdio
  Scenario: New theme footer integration
    Given I set my screensize to desktop
    When I visit "/"
    Then I take screenshot of element "#footer"

  @custom_accordian_block @wdio
  Scenario: Custom Accordion using Component Block
    Given I set my screensize to desktop
    When I visit "/page/behat-custom-accordion"
    Then I take screenshot of element "#main-content > div > div.l-wrap > div"

  @custom_alert_block @wdio
  Scenario: Custom Alert using Component Block
    Given I set my screensize to desktop
    When I visit "/page/behat-custom-alert"
    Then I take screenshot of element "#main-content > div > div.l-wrap > div"

  @image_block @wdio
  Scenario: Image using Component Block
    Given I set my screensize to desktop
    When I visit "/page/behat-image-block-landing-page/"
    Then I take screenshot of element "#main-content > div > div.l-wrap > div"

  @person_card_block @wdio
  Scenario: Person Card Group Block
    Given I set my screensize to desktop
    When I visit "/page/behat-person-card-group-landing-page"
    Then I take screenshot of element "#main-content > div > div.l-wrap > div"
