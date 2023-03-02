Feature: SRO Rule Release Details View Page
  As a site visitor, I want to be able to view SRO Node page
  So that visitors to sec.gov can learn about SROs

  @sro_rule_view @wdio
  Scenario: Rule-Rule Release Details Page
    Given I set my screensize to desktop
    When I visit "/rules/sro/77-sro-987"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#page > footer"
      And I hide "body > a.back-to-top"
    Then I take full page screenshot

  @sro_rule_accordion @wdio
  Scenario: Rule-Rule Release Details accordion Page
    Given I set my screensize to desktop
    When I visit "/rules/sro/66-sro-456"
      And I hide "#global-navigation"
      And I hide "#global-header"
      And I hide "#global-search-form > fieldset > div > label"
      And I hide "#page > footer"
      And I hide "body > a.back-to-top"
      And I click on "#ui-id-1"
      And I wait for "3" seconds
    Then I take full page screenshot

  @sro_custom_comments_rec @wdio
  Scenario: Custom Link Text for Comments Received on SRO Node
    Given I set my screensize to desktop
    When I visit "/rules/sro/ui-987"
    Then I take screenshot of element "#block-secgov-content > article > div.main > div > div.grid-container-two-col__section-main > div.public-comments"

  @sro_default_comments_rec @wdio
  Scenario: Default Link Text for Comments Received on SRO Node
    Given I set my screensize to desktop
    When I visit "/rules/sro/ui-700"
    Then I take screenshot of element "#block-secgov-content > article > div.main > div > div.grid-container-two-col__section-main > div.public-comments"
