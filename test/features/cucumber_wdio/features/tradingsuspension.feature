Feature: Styles on Trading Suspension
  As a site visitor, I want to be able to view Trading Suspension List and Node page
  So that visitors to sec.gov can learn about trading suspension

  @tradingsuspensionlist @wdio
  Scenario: Trading Suspension List Page
    Given I set my screensize to desktop
    When I login as admin
      And I visit "/litigation/suspensions"
      And I hide "#toolbar-bar"
      And I hide "#environment-indicator"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#page > footer"
      And I hide "#addthis-icons > div > div > div.addthis_toolbox.addthis_default_style.hide-for-small"
      And I hide "body > a.back-to-top"
    Then I take full page screenshot

  @tradingsuspensionnode @wdio
  Scenario: Trading Suspension Node Page
    Given I set my screensize to desktop
    When I login as admin
      And I visit "/litigation/suspensions/trading-suspension1"
    Then I take screenshot of element "#content-wrapper"
    When I visit "/litigation/suspensions/trading-suspension4"
    Then I take screenshot of element "#content-wrapper"
