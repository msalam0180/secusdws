Feature: Rule-Rule Release Details View Page
  As a site visitor, I want to be able to view Litigation Releases List and Node page
  So that visitors to sec.gov can learn about Litigation Releases

  @rule_view @wdio
  Scenario: Rule-Rule Release Details Page
    Given I set my screensize to desktop
    When I visit "/rules/rule-parent-a"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#page > footer"
      And I hide "body > a.back-to-top"
    Then I take full page screenshot

  @rule_view_with_accordion @wdio
  Scenario: Rule-Rule Release Details accordion Page
    Given I set my screensize to desktop
    When I visit "/rules/rule-parent-b"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#page > footer"
      And I hide "body > a.back-to-top"
      And I click on "#ui-id-1"
      And I wait for "3" seconds
    Then I take full page screenshot

  @nse_view @wdio
  Scenario: Rules Showing on NSE View
    Given I set my screensize to desktop
    When I visit "/rules-regulations/national-securities-exchanges-rulemaking"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#page > footer"
      And I hide "body > a.back-to-top"
    Then I take full page screenshot
