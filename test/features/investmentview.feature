Feature: Investment Company Act View
As a sec.gov site visitor, I should be able to view Investment Company Acts Notices and Orders.

  Background:
    Given "rulemaking_index" terms:
        | name      |
        | bi-90-po  |
        | bi-91-po  |
        | bi-92-po  |
      And "investment_company_act_category" terms:
        | name        |
        | Behat-ica-1 |
        | Behat-ica-2 |
        | Behat-ica-3 |
      And "customized_comment_form" content:
        | title         | field_display_title | status | field_file_number | field_rule_path    | field_ruling |
        | Comment Form  | Display Title for 1 | 1      | bi-90-po          | /comments/bi-90-po | bi-90-po     |
      And I create "media" of type "static_file":
        | name         | field_display_title | field_media_file | field_description_abstract | status |
        | Behat file 1 | published media     | behat-file.pdf   | This is description abs    | 1      |
        | Behat file 2 | published media     | behat-file.pdf   | This is description abs    | 1      |
        | Behat file 3 | published media     | behat-file.pdf   | This is description abs    | 1      |
      And "regulation" content:
        | title                      | body                | field_rule_type               | field_release_number | field_publish_date  | moderation_state | status | field_release_file | field_see_also             |
        | Behat Proposed Rule 1      | detail body 1       | Investment Company Act Notice | 01-11111             | 2022-01-04 12:00:00 | published        | 1      | behat file 1       | behat file 1, Behat file 2 |
        | Behat Final-Concept Rule 2 | detail body 2       | Investment Company Act Order  | 02-22222             | 2021-07-01 12:00:00 | published        | 1      | behat file 2       | behat file 2               |
        | Behat Interim Final Rule 3 | detail body 3       | Investment Company Act Notice | 03-33333             | 2021-01-03 12:00:00 | published        | 1      | behat file 3       | behat file 3               |
        | Behat Concept Rule 4       | detail body 4       | Investment Company Act Notice | 04-44444             | 2020-06-29 12:00:00 | published        | 1      |                    |                            |
        | Behat Interpretive Rule 5  | detail body 5       | Investment Company Act Order  | 05-55555             | 2020-01-01 12:00:00 | published        | 1      |                    |                            |
        | Behat Final Rule 6         | detail body 6       | Investment Company Act Order  | 05-66666,01-11111    | 2023-01-01 12:00:00 | published        | 1      |                    |                            |
        | Behat Draft Rule-Release 7 | Draft will not show | Investment Company Act Notice | 06-77777             | 2000-01-01 12:00:00 | draft            | 0      |                    |                            |
      And "rule" content:
        | title               | field_display_title | field_file_number | body                             | field_related_rule                                | moderation_state | status | field_investment_company_act_cat | field_show_comments_received | field_show_submit_comments | field_submit_comments | field_comments_received             | field_comments_date_format | field_comments_due_date | field_comments_notice |
        | Behat Parent Rule 1 | Behat Parent Rule 1 | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Final-Concept Rule 2 | published        | 1      | Behat-ica-1                      | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov | date                       | 2018-12-05T17:00:00     |                       |
        | Behat Parent Rule 2 | Behat Parent Rule 2 | bi-91-po          | This is a parent rule overview 2 | Behat Draft Rule-Release 7                        | published        | 1      | Behat-ica-2                      | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov |                            |                         |                       |
        | Behat Parent Rule 3 | Behat Parent Rule 3 |                   | This is a parent rule overview 3 | Behat Interim Final Rule 3                        | published        | 1      | Behat-ica-3                      |                              |                            |                       |                                     |                            |                         |                       |
        | Behat Parent Rule 4 | Behat Parent Rule 4 | bi-92-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                        | published        | 0      | Behat-ica-2                      |                              |                            |                       |                                     |                            |                         |                       |

  @api @javascript
  Scenario: Validate Default Investment Company Act Page
    Given I am on "/rules/icreleases"
    Then I should see the heading "Investment Company Act Notices and Orders"
      And I should see the text "Investment Company" in the "NSE_table" region
      And I should see the text "File Number" in the "NSE_table" region
      And I should see the text "Notice" in the "NSE_header" region
      And I should see the text "Order" in the "NSE_header" region
      And I should see the text "Category" in the "NSE_header" region
      And I should see the text "bi-90-po" in the "Behat Parent Rule 1" row
      And I should see the text "01-11111 (01/04/2022)" in the "Behat Parent Rule 1" row
      And I should see the text "02-22222 (07/01/2021)" in the "Behat Parent Rule 1" row
      And I should see the text "Behat-ica-1" in the "Behat Parent Rule 1" row
      And I should see the text "bi-91-po" in the "Behat Parent Rule 2" row
      And I should see the text "06-77777 (01/01/2000)" in the "Behat Parent Rule 2" row
      And I should see the text "Behat-ica-2" in the "Behat Parent Rule 2" row
      And I should see the text "03-33333 (01/03/2021)" in the "Behat Parent Rule 3" row
      And I should see the link "Behat Parent Rule 1" before I see the link "Behat Parent Rule 2" in the "Investment Company Act Notices and Orders" view
      And I should see the link "Behat Parent Rule 2" before I see the link "Behat Parent Rule 3" in the "Investment Company Act Notices and Orders" view
      And I should see the link "bi-90-po" before I see the link "bi-91-po" in the "Investment Company Act Notices and Orders" view
      And I should not see the text "Behat Parent Rule 4"
      And I should see the text "Displaying 1 - 3 of 3"

  @api
  Scenario: Validating Investment Company Act View Search Filters
    Given I am on "/rules/icreleases"
    When I select "Behat-ica-1" from "Category"
      And I press "Apply"
    Then I should see "Behat Parent Rule 1"
      And I should not see "Behat Parent Rule 3"
      And I should not see "Behat Parent Rule 2"
    When I fill in "Investment Company" with "1"
      And I select "" from "Category"
      And I press "Apply"
    Then I should see "Behat Parent Rule 1"
      And I should see the text "01-11111"
      And I should see the text "02-22222"
      And I should see "Displaying 1 - 1 of 1"
    When I fill in "Investment Company" with "be"
      And I press "Apply"
    Then I should see "Behat Parent Rule 1"
      And I should see "Behat Parent Rule 2"
      And I should see "Behat Parent Rule 3"
      And I should see "Displaying 1 - 3 of 3"
    When I fill in "File Number" with "1"
      And I press "Apply"
    Then I should see "06-77777 (01/01/2000)"
      And I should see "Displaying 1 - 1 of 1"
    When I fill in "Investment Company" with ""
      And I fill in "File Number" with ""
    When I fill in "Investment Company" with "1"
      And I fill in "File Number" with "0"
      And I select "Behat-ica-1" from "Category"
      And I press "Apply"
    Then I should see "Behat Parent Rule 1"
      And I should not see "Behat Parent Rule 2"
      And I should not see "Behat Parent Rule 3"

  @api
  Scenario: Validate Investment Company Act Sorting of Investment Company
    Given I am on "/rules/icreleases"
    When I click "sort by Investment Company"
    Then "Behat-ica-3" should precede "Behat-ica-2" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[5]"
      And "Behat-ica-2" should precede "Behat-ica-1" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[5]"
    When I click "sort by Investment Company"
    Then "Behat-ica-1" should precede "Behat-ica-2" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[5]"
      And "Behat-ica-2" should precede "Behat-ica-3" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[5]"

  @api
  Scenario: Validate Investment Company Act Sorting of File Number
    Given I am on "/rules/icreleases"
    When I click "sort by File Number"
    Then "Behat-ica-1" should precede "Behat-ica-2" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[5]"
    When I click "sort by File Number"
    Then "Behat-ica-2" should precede "Behat-ica-1" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[5]"

  @api
  Scenario: Validate Investment Company Act Sorting of Category
    Given I am on "/rules/icreleases"
    When I click "sort by Category"
      Then "Behat-ica-1" should precede "Behat-ica-2" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[5]"
        And "Behat-ica-2" should precede "Behat-ica-3" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[5]"
    When I click "sort by Category"
      Then "Behat-ica-3" should precede "Behat-ica-2" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[5]"
        And "Behat-ica-2" should precede "Behat-ica-1" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[5]"
