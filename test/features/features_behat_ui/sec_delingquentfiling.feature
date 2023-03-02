Feature: Delinquent Filing List Page and Detail Page
  As a Site Visitor, the user should be able to view list and node pages available on SEC.gov

@ui @api @javascript @wdio
Scenario: Validating Delinquent List View Page
  Given "rulemaking_index" terms:
    | name       | field_respondents |
    | ui-98-po   | Anthony           |
    | ab-12-cd   | Mary              |
  And "customized_comment_form" content:
    | title         | field_display_title | status |
    | Comment behat | Display Title for 1 | 1      |
  And I create "media" of type "link":
    | name           | field_media_entity_link | status |
    | Behat External | http://google.com       | 1      |
    | Behat Internal | https://sec.lndo.site/  | 1      |
  And "release" content:
    | title | field_release_type | field_comments_notice | field_release_number | moderation_state | field_publish_date  | status | field_respondents | field_see_also                 | field_submit_comments | field_release_file_number | field_override_file_number_respo | field_delinquent_filings |
    | Test  | ALJ Orders         | Note                  | 2-12312, 1-32, 4-523 | published        | 2021-02-02 12:00:00 | 1      | Frank             | Behat External, Behat Internal | Comment behat         | ui-98-po, ab-12-cd        |                                  | 1                        |
    | Test2 | ALJ Orders         | Note                  | 2-12312, 1-32, 4-523 | published        | 2019-02-02 12:00:00 | 1      | David             | Behat External, Behat Internal | Comment behat         | ui-98-po, ab-12-cd        | 1                                | 1                        |
  When I am logged in as a user with the "sitebuilder" role
    And I am on "/divisions/enforce/delinquent/delinqindex"
    And I click on the element with css selector "#block-delinquentfilingstopper > div.contextual > button"
    And I wait 2 seconds
    And I click on the element with css selector "#block-delinquentfilingstopper > div.contextual > ul > li:nth-child(4) > a"
    And I wait 2 seconds
  Then I select "Show Default Quick Links" from "field_quick_links"
    And I press "Save"
  Then I take a screenshot on "sec" using "delinquentfilings.feature" file with "@delinquent_list" tag
