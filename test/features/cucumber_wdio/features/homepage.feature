Feature: homepage
  As a Site Visitor and Drupal User, the user should be able to navigate easily throughout SEC.gov homepage

  @enable_banner @wdio
  Scenario: Government Official Banner Disable
    Given I set my screensize to desktop
    When I visit "/"
      And I click on ".usa-accordion__button "
      And I wait for "2" seconds
    Then I take screenshot of element "#top > div.dialog-off-canvas-main-canvas > div > section > div"

  @disable_banner @wdio
  Scenario: Government Official Banner Disable
    Given I set my screensize to desktop
    When I visit "/"
    Then I take screenshot of element ".usa-banner__inner"

  @header_uswdssec @wdio
  Scenario: Screenshot of the Header with uswdssec
    Given I set my screensize to desktop
    When I visit "/"
      And I wait for "2" seconds
    Then I take screenshot of element ".usa-navbar"

  @homepagefullscreen @wdio
  Scenario: Full Screenshot of the Homepage
    Given I set my screensize to desktop
    When I visit "/"
      And I wait for "2" seconds
    Then I take full page screenshot
    When I visit "/ohr"
      And I wait for "2" seconds
    Then I take full page screenshot
    When I visit "/edgar/filer-information/specifications/form-144-xml-technical-specification"
      And I wait for "2" seconds
    Then I take full page screenshot
    When I visit "/education/glossary"
      And I wait for "2" seconds
    Then I take full page screenshot
    When I visit "/division-investment-management-about-chief-counsels-office"
      And I wait for "2" seconds
    Then I take full page screenshot
    When I visit "/spotlight/affinity-fraud.shtml"
      And I wait for "2" seconds
    Then I take full page screenshot
    When I visit "/exams"
      And I wait for "2" seconds
    Then I take full page screenshot
    When I visit "/finhub"
      And I wait for "2" seconds
    Then I take full page screenshot
    When I visit "/tell-us"
      And I wait for "2" seconds
    Then I take full page screenshot
    When I visit "/dera"
      And I wait for "2" seconds
    Then I take full page screenshot
    When I visit "/whistleblower"
      And I wait for "2" seconds
    Then I take full page screenshot
    When I visit "/structureddata"
      And I wait for "2" seconds
    Then I take full page screenshot