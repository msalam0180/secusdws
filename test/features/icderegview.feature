Feature: Investment Company Act Deregistration Notices and Orders View
As a sec.gov site visitor, I should be able to view Investment Company Act Deregistration View

 Background:
    Given I create "media" of type "static_file":
        | name         | field_display_title | field_media_file | field_description_abstract | status |
        | Behat file 1 | published media     | behat-file.pdf   | This is description abs    | 1      |
        | Behat file 2 | published media     | behat-file.pdf   | This is description abs    | 1      |
        | Behat file 3 | published media     | behat-file.pdf   | This is description abs    | 1      |
      And "regulation" content:
        | title                      | body                | field_rule_type                | field_release_number | field_publish_date  | moderation_state | status | field_release_file | field_notes |
        | Behat Proposed Rule 1      | detail body 1       | Investment Company Act Release | 01-11111             | 2022-01-04 12:00:00 | published        | 1      | behat file 1       | Note a      |
        | Behat Final-Concept Rule 2 | detail body 2       | Investment Company Act Release | 02-22222             | 2021-07-01 12:00:00 | published        | 1      | behat file 2       |             |
        | Behat Interim Final Rule 3 | detail body 3       | Investment Company Act Release | 03-33333             | 2021-01-03 12:00:00 | published        | 1      | behat file 3       | Note B      |
        | Behat Concept Rule 4       | detail body 4       | Investment Company Act Release | 04-44444             | 2020-06-29 12:00:00 | published        | 1      |                    |             |
        | Behat Interpretive Rule 5  | detail body 5       | Investment Company Act Release | 05-55555             | 2020-01-01 12:00:00 | published        | 1      |                    |             |
        | Behat Final Rule 6         | detail body 6       | Investment Company Act Release | 05-66666             | 2023-01-01 12:00:00 | published        | 1      |                    | Note C      |
        | Behat Draft Rule-Release 7 | Draft will not show | Investment Company Act Release | 06-77777             | 2000-01-01 12:00:00 | draft            | 0      |                    |             |
      And "rule" content:
        | title               | field_display_title | body                             | field_related_rule         | moderation_state | status |
        | Behat Parent Rule 1 | Behat Parent Rule 1 | This is a parent rule overview 1 | Behat Proposed Rule 1      | published        | 1      |
        | Behat Parent Rule 2 | Behat Parent Rule 2 | This is a parent rule overview 2 | Behat Final-Concept Rule 2 | published        | 1      |
        | Behat Parent Rule 3 | Behat Parent Rule 3 | This is a parent rule overview 3 | Behat Interim Final Rule 3 | published        | 1      |
        | Behat Parent Rule 4 | Behat Parent Rule 4 | This is a parent rule overview 4 | Behat Final-Concept Rule 2 | published        | 0      |
        | Behat Parent Rule 5 | Behat Parent Rule 5 | This is a parent rule overview 5 | Behat Interpretive Rule 5  | published        | 1      |
        | Behat Parent Rule 6 | Behat Parent Rule 6 | This is a parent rule overview 6 | Behat Final Rule 6         | published        | 0      |

  @api
  Scenario: Validate Default Deregistration Page
    Given I am on "/rules/icdereg"
    Then I should see the heading "Investment Company Act Deregistration Notices and Orders"
      And I should see "See also Investment Company Act Notices and Orders."
      And "July 1, 2021" should precede "Jan. 3, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan. 3, 2021" should precede "Jan. 1, 2020" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And I should see the text "Release No." in the "NSE_header" region
      And I should see the text "Date" in the "NSE_header" region
      And I should see the text "Details" in the "NSE_header" region
      And I should see the text "01-11111" in the "Behat Proposed Rule 1" row
      And I should see the text "Jan. 4, 2022" in the "Behat Proposed Rule 1" row
      And I should see the text "This is a parent rule overview 1" in the "Behat Proposed Rule 1" row
      And I should see the text "02-22222" in the "Behat Final-Concept Rule 2" row
      And I should see the text "July 1, 2021" in the "Behat Final-Concept Rule 2" row
      And I should see the text "This is a parent rule overview 2" in the "Behat Final-Concept Rule 2" row
      And I should see the text "03-33333" in the "Behat Interim Final Rule 3" row
      And I should see the text "Jan. 3, 2021" in the "Behat Interim Final Rule 3" row
      And I should see the text "This is a parent rule overview 3" in the "Behat Interim Final Rule 3" row
      And I should see the text "Behat Interim Final Rule 3" in the "Behat Interim Final Rule 3" row
      And I should see the text "Displaying 1 - 4 of 4"
      And I should not see the text "Behat Final Rule 6"

  @api
  Scenario: Validate Deregistration Sorting of Date
    Given I am on "/rules/icdereg"
    When I click "sort by Date"
    Then "Jan. 1, 2020" should precede "Jan. 3, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan. 3, 2021" should precede "July 1, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "July 1, 2021" should precede "Jan. 4, 2022" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
    When I click "sort by Date"
    Then "Jan. 4, 2022" should precede "July 1, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "July 1, 2021" should precede "Jan. 3, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan. 3, 2021" should precede "Jan. 1, 2020" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"

  @api
  Scenario: Deregistration View Pagination
    Given "rule" content:
        | title               | field_related_rule         |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 6 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 1 | Behat Proposed Rule 1      |
        | Behat Parent Rule 2 | Behat Proposed Rule 1      |
        | Behat Parent Rule 3 | Behat Interim Final Rule 3 |
        | Behat Parent Rule 4 | Behat Final-Concept Rule 2 |
        | Behat Parent Rule 5 | Behat Interim Final Rule 3 |
    When I am on "/rules/icdereg"
    Then I should see the text "Displaying 1 - 100 of 101"
      And I should see the link "1"
      And I should see the link "2"
      And I should see the link "Go to next page"
      And I should see the link "Go to last page"
    When I click "Go to last page"
    Then I should see the text "Displaying 101 - 101 of 101"
