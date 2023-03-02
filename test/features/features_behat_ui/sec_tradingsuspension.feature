Feature: Trading Suspension List Page and Detail Page
  As a Site Visitor, the user should be able to view list and node pages available on SEC.gov

@ui @api @javascript @wdio
Scenario: Trading Suspension Pages Screenshot
  Given "rulemaking_index" terms:
      | name       | field_respondents |
      | ui-98-po   | Anthony           |
      | ab-12-cd   | Mary              |
    And "release" content:
      | title               | field_release_type  | field_release_number | field_respondents | moderation_state | field_publish_date  | status | field_release_file_number | field_override_file_number_respo | nid   | field_comments_received             |
      | Trading Suspension1 | Trading Suspensions | 34-12345             | Allen             | published        | 2021-02-02 12:00:00 | 1      | ui-98-po, ab-12-cd        |                                  | 45687 |                                     |
      | Trading Suspension2 | Trading Suspensions | 34-23456             | Beverly hidden    | draft            | -2 days             | 0      |                           |                                  | 23568 |                                     |
      | Trading Suspension3 | Trading Suspensions | 34-34567             | Caroline          | published        | 2021-05-03 12:00:00 | 1      |                           |                                  |       |                                     |
      | Trading Suspension4 | Trading Suspensions | 34-12345             | David             | published        | 2021-02-02 12:00:00 | 1      | ui-98-po, ab-12-cd        | 1                                |       | Go to SEC.gov - https://www.sec.gov |
  When I am logged in as a user with the "Content Creator" role
    And I visit "/node/45687/edit"
    And I fill in "edit-field-comments-received-0-uri" with "https://www.google.com"
    And I press "Save"
  Then I take a screenshot on "sec" using "tradingsuspension.feature" file with "@tradingsuspensionlist" tag
    And I take a screenshot on "sec" using "tradingsuspension.feature" file with "@tradingsuspensionnode" tag
