 Feature: Rulemaking Index View Page
  As a Site Visitor, the user should be able to view list pages available on SEC.gov

  @api @javascript
  Scenario: Rulemaking Activity Page View
    Given "rulemaking_index" terms:
        | name     | field_respondents | status | field_ap_status |
        | bi-90-po | Anthony           | 1      | Open            |
        | bi-91-po | Harry             | 1      | Open            |
        | bi-92-po | Larry             | 1      | Open            |
        | bi-93-po | Curly             | 1      | Open            |
        | bi-94-po | Moe               | 1      | Open            |
        And "division_office" terms:
        | name     |
        | office 1 |
        | office 2 |
        And "regulation" content:
        | title                      | body                | field_rule_type | field_release_number | field_publish_date  | moderation_state | status |
        | Behat Proposed Rule 1      | detail body 1       | Proposed        | 01-11111             | 2022-01-04 12:00:00 | published        | 1      |
        | Behat Final-Concept Rule 2 | detail body 2       | Final, Concept  | 02-22222             | 2021-07-01 12:00:00 | published        | 1      |
        | Behat Interim Final Rule 3 | detail body 3       | Interim Final   | 03-33333             | 2021-01-03 12:00:00 | published        | 1      |
        | Behat Concept Rule 4       | detail body 4       | Concept         | 04-44444             | 2020-06-29 12:00:00 | published        | 1      |
        | Behat Interpretive Rule 5  | detail body 5       | Interpretive    | 05-55555             | 2020-01-01 12:00:00 | published        | 1      |
        | Behat Final Rule 6         | detail body 6       | Final           | 05-66666             | 2023-01-01 12:00:00 | published        | 1      |
        | Behat Draft Rule-Release 7 | Draft will not show | Final           | 06-77777             | 2000-01-01 12:00:00 | draft            | 0      |
        And "rule" content:
        | title               | field_display_title | field_file_number | body                             | field_related_rule                          | field_primary_division_office | moderation_state | status |
        | Behat Parent Rule 1 | Behat Parent Rule 1 | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | office 1                      | published        | 1      |
        | Behat Parent Rule 2 | Behat Parent Rule 2 | bi-91-po          | This is a parent rule overview 2 | Behat Draft Rule-Release 7                  | office 2                      | published        | 1      |
        | Behat Parent Rule 3 | Behat Parent Rule 3 |                   | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | office 1                      | published        | 1      |
        | Behat Parent Rule 4 | Behat Parent Rule 4 | bi-92-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | office 2                      | published        | 0      |
        | Behat Parent Rule 5 | Behat Parent Rule 5 | bi-93-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | office 1                      | published        | 1      |
        | Behat Parent Rule 6 | Behat Parent Rule 6 | bi-94-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | office 2                      | published        | 1      |
    Then I take a screenshot on "sec" using "rulemaking.feature" file with "@rulemaking_activity_page" tag
