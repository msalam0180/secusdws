Feature: Exemptive View
As a sec.gov site visitor, I should be able to view Exchange Act Exemtpive Orders.

  Background:
    Given "rulemaking_index" terms:
        | name      | status |
        | bi-90-po  | 1      |
        | bi-91-po  | 1      |
        | bi-92-po  | 1      |
        | bi-93-po  | 1      |
        | bi-94-po  | 1      |
        | ti-100-po | 1      |
      And "customized_comment_form" content:
        | title         | field_display_title | status | field_file_number | field_rule_path    | field_ruling |
        | Comment Form  | Display Title for 1 | 1      | bi-90-po          | /comments/bi-90-po | bi-90-po     |
      And I create "media" of type "static_file":
        | name         | field_display_title | field_media_file | field_description_abstract | status |
        | Behat file 1 | published media     | behat-file.pdf   | This is description abs    | 1      |
        | Behat file 2 | published media     | behat-file.pdf   | This is description abs    | 1      |
        | Behat file 3 | published media     | behat-file.pdf   | This is description abs    | 1      |
      And "regulation" content:
        | title                      | body                | field_rule_type     | field_release_number | field_publish_date  | moderation_state | status | field_release_file | field_see_also             |
        | Behat Proposed Rule 1      | detail body 1       | Exemptive           | 01-11111             | 2022-01-04 12:00:00 | published        | 1      | behat file 1       | behat file 1, Behat file 2 |
        | Behat Final-Concept Rule 2 | detail body 2       | Exemptive, Concept  | 02-22222             | 2021-07-01 12:00:00 | published        | 1      | behat file 2       | behat file 2               |
        | Behat Interim Final Rule 3 | detail body 3       | Exemptive           | 03-33333             | 2021-01-03 12:00:00 | published        | 1      | behat file 3       | behat file 3               |
        | Behat Concept Rule 4       | detail body 4       | Exemptive           | 04-44444             | 2020-06-29 12:00:00 | published        | 1      |                    |                            |
        | Behat Interpretive Rule 5  | detail body 5       | Exemptive           | 05-55555             | 2020-01-01 12:00:00 | published        | 1      |                    |                            |
        | Behat Final Rule 6         | detail body 6       | Exemptive           | 05-66666,01-11111    | 2023-01-01 12:00:00 | published        | 1      |                    |                            |
        | Behat Draft Rule-Release 7 | Draft will not show | Final               | 06-77777             | 2000-01-01 12:00:00 | draft            | 0      |                    |                            |
      And "rule" content:
        | title                     | field_display_title       | field_file_number | body                             | field_related_rule                          | moderation_state | status | field_show_comments_received | field_show_submit_comments | field_submit_comments | field_comments_received             | field_comments_date_format | field_comments_due_date | field_comments_notice |
        | Behat Proposed Rule 1     | Behat Proposed Rule 1     | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | published        | 1      | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov | date                       | 2018-12-05T17:00:00     |                       |
        | Behat Parent Rule 2       | Behat Parent Rule 2       | bi-91-po          | This is a parent rule overview 2 | Behat Draft Rule-Release 7                  | published        | 1      | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov |                            |                         |                       |
        | Behat Parent Rule 3       | Behat Parent Rule 3       |                   | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | published        | 1      |                              |                            |                       |                                     |                            |                         |                       |
        | Behat Parent Rule 4       | Behat Parent Rule 4       | bi-92-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | published        | 0      |                              |                            |                       |                                     |                            |                         |                       |
        | Behat Interpretive Rule 5 | Behat Interpretive Rule 5 | bi-93-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | published        | 1      |                              |                            |                       |                                     | text                       |                         | rebuttal              |
        | Behat Parent Rule 6       | Behat Parent Rule 6       | bi-94-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | published        | 1      |                              |                            |                       |                                     |                            |                         |                       |

  @api
  Scenario: Validate Default Exemptive Page
    Given I am on "/rules/exorders"
    When I click "Submit A Comment"
    Then I should see the heading "Submit Comments on bi-90-po Comment Form"
    When I visit "/rules/exorders"
      And I click "Behat Interpretive Rule 5"
    Then I should see the heading "Behat Interpretive Rule 5"
    When I visit "/rules/exorders"
    Then I should see the heading "Exchange Act Exemptive Orders"
      And I should see the text "Release Number" in the "NSE_header" region
      And I should see the text "SEC Issue Date" in the "NSE_header" region
      And I should see the text "File Number" in the "NSE_header" region
      And I should see the text "Details" in the "NSE_header" region
      And "01-11111" should precede "03-33333" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[1]"
      And "03-33333" should precede "04-44444" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[1]"
      And "04-44444" should precede "05-55555" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[1]"
      And "05-55555" should precede "05-66666, 01-11111" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[1]"
      And I should see the text "01-11111" in the "Behat Proposed Rule 1" row
      And I should see the text "Jan. 4, 2022" in the "Behat Proposed Rule 1" row
      And I should see the text "bi-90-po" in the "Behat Proposed Rule 1" row
      And I should see the text "Comments Due: December 5, 2018" in the "Behat Proposed Rule 1" row
      And I should see the text "Behat Proposed Rule 1" in the "Behat Proposed Rule 1" row
      And I should see "Go to SEC.gov" in the "Behat Proposed Rule 1" row
      And I should see "See Also - Behat file 1, Behat file 2" in the "Behat Proposed Rule 1" row
      And I should see the text "05-55555" in the "Behat Interpretive Rule 5" row
      And I should see the text "Jan. 1, 2020" in the "Behat Interpretive Rule 5" row
      And I should see the text "bi-93-po" in the "Behat Interpretive Rule 5" row
      And I should see the text "Behat Interpretive Rule 5" in the "Behat Interpretive Rule 5" row
      And I should see the text "Comments Due: rebuttal" in the "Behat Interpretive Rule 5" row
      And I should see the text "Displaying 1 - 5 of 5"
      And I should not see the text "Behat Parent Rule 2"

  @api
  Scenario: Validate Exemptive Page Sorting of SEC Date
    Given I am on "/rules/exorders"
    When I click "sort by SEC Issue Date"
    Then "Jan. 1, 2023" should precede "Jan. 4, 2022" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan. 4, 2022" should precede "Jan. 3, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan. 3, 2021" should precede "June 29, 2020" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "June 29, 2020" should precede "Jan. 1, 2020" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
    When I click "sort by SEC Issue Date"
    Then "Jan. 1, 2020" should precede "June 29, 2020" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "June 29, 2020" should precede "Jan. 3, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan. 3, 2021" should precede "Jan. 4, 2022" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"

  @api
  Scenario: Validate Exemptive Page Sorting of File Number
    Given I am on "/rules/exorders"
    When I click "sort by File Number"
    Then "bi-90-po" should precede "bi-93-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[3]"
      And "bi-93-po" should precede "bi-94-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[3]"
    When I click "sort by File Number"
    Then "bi-94-po" should precede "bi-93-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[3]"
      And "bi-93-po" should precede "bi-90-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[3]"
