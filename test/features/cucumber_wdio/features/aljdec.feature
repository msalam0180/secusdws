Feature: Styles on ALJ Initial Decisions
  As a site visitor, I want to be able to view ALJ Initial Decisions List and Node page
  So that visitors to sec.gov can learn about ALJ Initial Decisions

  @aljdeclist @wdio
  Scenario: ALJ Initial Decisions List Page
    Given I set my screensize to desktop
    When I login as admin
      And I visit "/alj/aljdec"
      And I hide "#toolbar-bar"
      And I hide "#environment-indicator"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#page > footer"
      And I hide "#addthis-icons > div > div > div.addthis_toolbox.addthis_default_style.hide-for-small"
      And I hide "body > a.back-to-top"
    Then I take full page screenshot

  @aljdecnode @wdio
  Scenario: ALJ Initial Decisions Node Page
    Given I set my screensize to desktop
    When I login as admin
      And I visit "/alj/aljdec/test"
    Then I take screenshot of element "#content-wrapper"
    When I visit "/alj/aljdec/test2"
    Then I take screenshot of element "#content-wrapper"
