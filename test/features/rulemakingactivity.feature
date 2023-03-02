Feature: Rulemaking Activity List View
  As a Content Creator
  I want to be able to create and edit regulation content
  So that visitors to SEC.gov can learn more about the rules and regulations at secgov

  Background:
    Given "rulemaking_index" terms:
        | name      | field_respondents | status | field_ap_status | field_rulemaking |
        | bi-90-po  | Anthony           | 1      | Open            | Behat Accounting |
        | bi-91-po  | Harry             | 1      | Open            | Behat Finance    |
        | bi-92-po  | Larry             | 1      | Open            | Behat Billing    |
        | bi-93-po  | Curly             | 1      | Open            | Behat Operations |
        | bi-94-po  | Moe               | 1      | Open            | Behat Shipping   |
        | ti-100-po | Joe               | 1      | Open            | Behat Customer   |
      And "division_office" terms:
        | name           |
        | Behat-office 1 |
        | Behat-office 2 |
        | Behat-office 3 |
        | Behat-office 4 |
        | Behat-office 5 |
        | Behat-office 6 |
        | Behat-office 7 |
      And "regulation" content:
        | field_display_title   | title                      | body                | field_rule_type | field_release_number | field_publish_date  | moderation_state | status |
        | Child1 Rule Release 1 | Behat Proposed Rule 1      | detail body 1       | Proposed        | 01-11111             | 2022-01-04 12:00:00 | published        | 1      |
        | Child1 Rule Release 2 | Behat Final-Concept Rule 2 | detail body 2       | Final, Concept  | 02-22222             | 2021-07-01 12:00:00 | published        | 1      |
        | Child1 Rule Release 3 | Behat Interim Final Rule 3 | detail body 3       | Interim Final   | 03-33333             | 2021-01-03 12:00:00 | published        | 1      |
        | Child2 Rule Release 4 | Behat Concept Rule 4       | detail body 4       | Concept         | 04-44444             | 2020-06-29 12:00:00 | published        | 1      |
        | Child2 Rule Release 5 | Behat Interpretive Rule 5  | detail body 5       | Interpretive    | 05-55555             | 2020-01-01 12:00:00 | published        | 1      |
        | Child2 Rule Release 6 | Behat Final Rule 6         | detail body 6       | Final           | 05-66666             | 2021-01-01 12:00:00 | published        | 1      |
        | Child3 Rule Release 7 | Behat Draft Rule-Release 7 | Draft will not show | Final           | 06-77777             | 2000-01-01 12:00:00 | draft            | 0      |
      And "rule" content:
        | title           | field_display_title         | field_file_number | body                             | field_related_rule                          | field_primary_division_office | moderation_state | status |
        | Behat1 Parent 1 | Behat Rule Display8 Title 1 | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
        | Behat1 Parent 3 | Behat Rule Display8 Title 3 | bi-91-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
        | Behat1 Parent 4 | Behat Rule Display8 Title 4 | bi-92-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
        | Behat2 Parent 5 | Behat Rule Display9 Title 5 | ti-100-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
        | Behat2 Parent 6 | Behat Rule Display9 Title 6 | bi-94-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
        | Behat2 Parent 7 | Behat Rule Display9 Title 7 | bi-93-po          | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |

  @api @javascript
  Scenario: Validate Rulemaking Activity Page
    Given I am not logged in
    When I am on "/rules/rulemaking-activity"
    Then I should see the heading "Rulemaking Activity"
      And I should see the text "Last Action Date" in the "rulemaking_table" region
      And I should see the text "File Number" in the "rulemaking_table" region
      And I should see the text "Rulemaking" in the "rulemaking_table" region
      And I should see the text "Status" in the "rulemaking_table" region
      And I should see "Displaying 1 - 6 of 6"
      And I should see the text "Behat Interim Final Rule 3" in the "01/03/2021" row
      And I should see the text "Behat Interpretive Rule 5" in the "01/01/2020" row
      And I should see the text "Behat Final Rule 6" in the "01/01/2021" row
      And I should see the text "Behat Proposed Rule 1" in the "01/04/2022" row
      And I should see the text "bi-90-po" in the "01/04/2022" row
      And I should see the text "Behat Accounting" in the "01/04/2022" row
      And I should see the text "01-11111" in the "01/04/2022" row
      And I should see the text "Proposed Rule" in the "01/04/2022" row
      And I should see the text "Behat Final-Concept Rule 2" in the "07/01/2021" row
      And I should see the text "Final Rule" in the "07/01/2021" row
      And I should see the text "Concept Rule" in the "07/01/2021" row
      And I should not see the text "bi-90-po" in the "07/01/2021" row
      And I should not see the text "Behat Accounting" in the "07/01/2021" row
      And I should not see the text "01-11111" in the "07/01/2021" row
      And I should not see the text "Behat Concept Rule 4" in the "01/04/2022" row
      And I should not see the text "Behat Draft Rule-Release 7" in the "rulemaking_table" region
      And I should see the link "Behat Final Rule 6" before I see the link "Behat Concept Rule 4" in the "Rulemaking Activity" view
      And I should see the link "Behat Proposed Rule 1" before I see the link "Behat Interpretive Rule 5" in the "Rulemaking Activity" view
      And I should see the link "Behat Final-Concept Rule 2" before I see the link "Behat Interim Final Rule 3" in the "Rulemaking Activity" view
      And I should see the link "Behat Concept Rule 4" before I see the link "Behat Interpretive Rule 5" in the "Rulemaking Activity" view
      And I should see the link "Behat Interim Final Rule 3" before I see the link "Behat Final Rule 6" in the "Rulemaking Activity" view
    When I click "Behat Proposed Rule 1"
    Then I should be on "/rules/behat1-parent-1"
      And I should see the heading "Behat Rule Display8 Title 1"
    #^bug here. will fail till its fixed
      And I should see "Concept Rule (04-44444)"

  @api
  Scenario: Validating Rulemaking Activity View Search Filters
    Given I am not logged in
    When I am on "/rules/rulemaking-activity"
      And I fill in "Search" with "Operations"
      And I press "Apply"
    Then I should see "Behat Concept Rule 4"
      And I should see "Displaying 1 - 1 of 1"
      And I should not see "Behat Final Rule 6"
    When I fill in "Search" with "bi-9"
      And I press "Apply"
    Then I should see "Displaying 1 - 5 of 5"
      And I should see "Behat Final Rule 6"
      And I should see "Behat Proposed Rule 1"
      And I should not see "Behat Interpretive Rule 5"
    When I fill in "Search" with "ti-100-po"
      And I press "Apply"
    Then I should see "Displaying 1 - 1 of 1"
      And I should see "Behat Interpretive Rule 5"
      And I should not see "Behat Proposed Rule 1"
    When I fill in "Search" with "Behat1 Parent"
      And I press "Apply"
    Then I should see "Displaying 1 - 3 of 3"
      And I should see "Behat Proposed Rule 1"
      And I should see "Behat Interim Final Rule 3"
      And I should not see "Behat Concept Rule 4"
    When I fill in "Search" with "Rule Display9"
      And I press "Apply"
    Then I should see "Displaying 1 - 3 of 3"
      And I should see "Behat Concept Rule 4"
      And I should not see "Behat Interim Final Rule 3"
    When I fill in "Search" with "Behat Proposed"
      And I press "Apply"
    Then I should see "Displaying 1 - 1 of 1"
      And I should see "Behat Proposed Rule 1"
      And I should not see "Behat Concept Rule 4"
    When I fill in "Search" with "Child1 Rule"
      And I press "Apply"
    Then I should see "Displaying 1 - 3 of 3"
      And I should see "Behat Final-Concept Rule 2"
      And I should not see "Behat Final Rule 6"
    When I fill in "Search" with " "
      And I press "Apply"
    Then I should see "Behat Final Rule 6"
      And I should see "Behat Proposed Rule 1"
      And I should see "Behat Final-Concept Rule 2"
      And I should see "Behat Interim Final Rule 3"
      And I should see "Behat Interpretive Rule 5"
      And I should see "Behat Concept Rule 4"
      And I should not see "Behat Draft Rule-Release 7"
      And I should see "Displaying 1 - 6 of 6"

  @api
  Scenario: Rulemaking Activity View Status Filter
    Given I am not logged in
    When I am on "/rules/rulemaking-activity"
    Then I should see the text "Behat Proposed Rule 1" in the "01/04/2022" row
      And I should see the text "Behat Final Rule 6" in the "01/01/2021" row
      And I should see the text "Behat Concept Rule 4" in the "06/29/2020" row
      And I should not see the text "Behat Draft Rule-Release 7" in the "rulemaking_table" region
      And I should see "Displaying 1 - 6 of 6"
    When I select "Complete" from "Status"
      And I press "Apply"
    Then I should see "Displaying 1 - 2 of 2"
      And I should see the text "Behat Final Rule 6" in the "01/01/2021" row
      And I should see the text "Behat Final-Concept Rule 2" in the "07/01/2021" row
      And I should not see the text "Behat Proposed Rule 1" in the "rulemaking_table" region
      And I select "Proposed" from "Status"
      And I press "Apply"
      And I should see "Displaying 1 - 4 of 4"
      And I should see the text "Behat Proposed Rule 1" in the "01/04/2022" row
      And I should see the text "Behat Interim Final Rule 3" in the "01/03/2021" row
      And I should see the text "Behat Concept Rule 4" in the "06/29/2020" row
      And I should see the text "Behat Interpretive Rule 5" in the "01/01/2020" row
      And I should not see the text "Behat Final Rule 6" in the "rulemaking_table" region
    When I select "- Any -" from "Status"
      And I press "Apply"
    Then I should see the text "Behat Final Rule 6" in the "01/01/2021" row
      And I should see the text "Behat Proposed Rule 1" in the "01/04/2022" row
      And I should see "Behat Final-Concept Rule 2"
      And I should see "Behat Interim Final Rule 3"
      And I should see "Behat Interpretive Rule 5"
      And I should see "Behat Concept Rule 4"
      And I should not see "Behat Draft Rule-Release 7"
      And I should see "Displaying 1 - 6 of 6"
    #Status + last action date
    When I select "Proposed" from "Status"
      And I select "2020" from "Last Action Date"
      And I press "Apply"
      And I should see "Displaying 1 - 2 of 2"
    Then I should see the text "Behat Concept Rule 4" in the "06/29/2020" row
      And I should see the text "Behat Interpretive Rule 5" in the "01/01/2020" row
      And I should not see the text "Behat Proposed Rule 1" in the "rulemaking_table" region
    #Status + last action date + search
    When I fill in "Search" with "Concept"
      And I press "Apply"
    Then I should see "Displaying 1 - 1 of 1"
      And I should see the text "Behat Concept Rule 4" in the "06/29/2020" row
      And I should not see the text "Behat Interpretive Rule 5" in the "rulemaking_table" region
    #Status + last action date + search + Division can be added when bug is fixed
    When I select "Behat-office 1" from "Division"
    #^bug:(OSSS-21392) will fail till its fixed
    #TODO complete remaining validation steps once OSSS-21392 is fixed

  @api
  Scenario Outline: Division/Office Filter
    Given "regulation" content:
      | title                 | body          | field_rule_type | field_release_number | field_publish_date  | moderation_state | status |
      | Behat Proposed Rule 1 | detail body 1 | Proposed        | 01-11111             | 2022-01-04 12:00:00 | published        | 1      |
       And "rule" content:
        | title               | field_display_title | field_file_number | body                             | field_related_rule    | field_primary_division_office | moderation_state | status |
        | Behat Parent Rule 1 | Behat Parent Rule 1 | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1 | Behat-office 1                | published        | 1      |
    When I am on "/rules/rulemaking-activity"
    Then I select "<office>" from "Division"
    #TODO complete remaining validation steps once OSSS-21392 is fixed

    Examples:
      | office                     |
      | Investment Management      |
      | Trading and Markets        |
      | Corporation Finance        |
      | Economic and Risk Analysis |
      | FOIA Services              |
      | Chief Accountant           |
      | General Counsel            |
      | Information Technology     |
      | Municipal Securities       |
    #functionality of the Division filter will be tested when the bug (OSSS-21392) is fixed

  @api
  Scenario: Last Action Date (Year) Filter
    #Last Action Date filter
    Given I am not logged in
    When I am on "/rules/rulemaking-activity"
    Then I should see the text "Behat Proposed Rule 1" in the "01/04/2022" row
      And I should see the text "Behat Final-Concept Rule 2" in the "07/01/2021" row
      And I should see the text "Behat Interim Final Rule 3" in the "01/03/2021" row
      And I should see the text "Behat Interpretive Rule 5" in the "01/01/2020" row
      And I should see the text "Behat Final Rule 6" in the "01/01/2021" row
      And I should see the text "Behat Concept Rule 4" in the "06/29/2020" row
      And I should not see the text "Behat Draft Rule-Release 7" in the "rulemaking_table" region
      And I should see "Displaying 1 - 6 of 6"
    When I select "2020" from "Last Action Date"
      And I press "Apply"
    Then I should see "Displaying 1 - 2 of 2"
      And I should see the text "Behat Concept Rule 4" in the "06/29/2020" row
      And I should see the text "Behat Interpretive Rule 5" in the "01/01/2020" row
      And I should not see the text "Behat Proposed Rule 1" in the "rulemaking_table" region
      And I should not see the text "Behat Final-Concept Rule 2" in the "rulemaking_table" region
      And I select "2021" from "Last Action Date"
      And I press "Apply"
      And I should see "Displaying 1 - 3 of 3"
      And I should see the text "Behat Final-Concept Rule 2" in the "07/01/2021" row
      And I should see the text "Behat Interim Final Rule 3" in the "01/03/2021" row
      And I should not see the text "Behat Interpretive Rule 5" in the "rulemaking_table" region
    When I select "- Any -" from "Last Action Date"
      And I press "Apply"
    Then I should see the text "Behat Proposed Rule 1" in the "01/04/2022" row
      And I should see the text "Behat Final-Concept Rule 2" in the "07/01/2021" row
      And I should see the text "Behat Interim Final Rule 3" in the "01/03/2021" row
      And I should see the text "Behat Interpretive Rule 5" in the "01/01/2020" row
      And I should see the text "Behat Final Rule 6" in the "01/01/2021" row
      And I should see the text "Behat Concept Rule 4" in the "06/29/2020" row
      And I should not see the text "Behat Draft Rule-Release 7" in the "rulemaking_table" region
      And I should see "Displaying 1 - 6 of 6"
    #last action date + status
    When I select "2021" from "Last Action Date"
      And I select "Proposed" from "Status"
      And I press "Apply"
    Then I should see the text "Behat Interim Final Rule 3" in the "01/03/2021" row
      And I should not see the text "Behat Final Rule 6" in the "rulemaking_table" region
      And I select "Complete" from "Status"
      And I press "Apply"
      And I should see "Displaying 1 - 2 of 2"
      And I should see the text "Behat Final-Concept Rule 2" in the "07/01/2021" row
      And I should see the text "Behat Final Rule 6" in the "01/01/2021" row
      And I should not see the text "Behat Interim Final Rule 3" in the "rulemaking_table" region
    #last action date + status + search
    When I fill in "Search" with "Concept"
      And I press "Apply"
      And I should not see the text "Behat Final Rule 6" in the "rulemaking_table" region
    Then I should see the text "Behat Final-Concept Rule 2" in the "07/01/2021" row

  @api
  Scenario: Filters With No Results Found
    Given I am not logged in
    When I am on "/rules/rulemaking-activity"
      And I fill in "Search" with "bi-9"
      And I select "Proposed" from "Status"
      And I select "2019" from "Last Action Date"
      And I press "Apply"
    Then I should see the text "No results."

  @api
  Scenario: Rule Making Activities Pagination
    Given "rulemaking_index" terms:
      | name      | field_respondents | status | field_ap_status |
      | bi-95-po  | Anthony           | 1      | Open            |
      | bi-96-po  | Harry             | 1      | Open            |
      | bi-97-po  | Larry             | 1      | Open            |
      | bi-98-po  | Curly             | 1      | Open            |
      | bi-99-po  | Moe               | 1      | Open            |
      | bi-101-po | Dan               | 1      | Open            |
      | bi-102-po | Jon               | 1      | Open            |
      | bi-103-po | Jae               | 1      | Open            |
      | bi-104-po | Jim               | 1      | Open            |
      | bi-105-po | Doe               | 1      | Open            |
      | bi-106-po | Koe               | 1      | Open            |
      | bi-107-po | Roe               | 1      | Open            |
      | bi-108-po | Poe               | 1      | Open            |
      | bi-109-po | Toe               | 1      | Open            |
      | bi-110-po | Soe               | 1      | Open            |
      | bi-111-po | Xoe               | 1      | Open            |
      | bi-112-po | Zoe               | 1      | Open            |
      | bi-113-po | Xoe               | 1      | Open            |
      | bi-114-po | Yoe               | 1      | Open            |
      | bi-115-po | Aoe               | 1      | Open            |
      | bi-116-po | Boe               | 1      | Open            |
      | bi-117-po | Coe               | 1      | Open            |
      | bi-118-po | Foe               | 1      | Open            |
      | bi-119-po | Ioe               | 1      | Open            |
      And "rule" content:
      | title             | field_display_title          | field_file_number | body                             | field_related_rule                          | field_primary_division_office | moderation_state | status |
      | Behat1 Parent 8   | Behat Rule Display8 Title 1  | bi-95-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 9   | Behat Rule Display8 Title 3  | bi-95-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 10  | Behat Rule Display8 Title 4  | bi-97-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 11  | Behat Rule Display9 Title 5  | bi-98-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 12  | Behat Rule Display9 Title 6  | bi-99-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 13  | Behat Rule Display9 Title 7  | bi-101-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 14  | Behat Rule Display8 Title 8  | bi-102-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 15  | Behat Rule Display8 Title 9  | bi-103-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 16  | Behat Rule Display8 Title 10 | bi-104-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 17  | Behat Rule Display9 Title 11 | bi-105-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 18  | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 19  | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 20  | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 21  | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 22  | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 23  | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 24  | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 25  | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 26  | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 27  | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 28  | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 29  | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 30  | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 31  | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 32  | Behat Rule Display8 Title 1  | bi-95-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 33  | Behat Rule Display8 Title 3  | bi-95-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 34  | Behat Rule Display8 Title 4  | bi-97-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 35  | Behat Rule Display9 Title 5  | bi-98-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 36  | Behat Rule Display9 Title 6  | bi-99-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 37  | Behat Rule Display9 Title 7  | bi-101-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 38  | Behat Rule Display8 Title 8  | bi-102-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 39  | Behat Rule Display8 Title 9  | bi-103-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 40  | Behat Rule Display8 Title 10 | bi-104-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 41  | Behat Rule Display9 Title 11 | bi-105-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 42  | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 43  | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 44  | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 45  | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 46  | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 47  | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 48  | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 49  | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 50  | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 51  | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 52  | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 53  | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 54  | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 55  | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 56  | Behat Rule Display8 Title 1  | bi-95-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 57  | Behat Rule Display8 Title 3  | bi-95-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 58  | Behat Rule Display8 Title 4  | bi-97-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 59  | Behat Rule Display9 Title 5  | bi-98-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 60  | Behat Rule Display9 Title 6  | bi-99-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 61  | Behat Rule Display9 Title 7  | bi-101-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 62  | Behat Rule Display8 Title 8  | bi-102-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 63  | Behat Rule Display8 Title 9  | bi-103-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 64  | Behat Rule Display8 Title 10 | bi-104-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 65  | Behat Rule Display9 Title 11 | bi-105-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 66  | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 67  | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 68  | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 69  | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 70  | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 71  | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 72  | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 73  | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 74  | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 75  | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 76  | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 77  | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 78  | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 79  | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 80  | Behat Rule Display8 Title 1  | bi-95-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 81  | Behat Rule Display8 Title 3  | bi-95-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 82  | Behat Rule Display8 Title 4  | bi-97-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 83  | Behat Rule Display9 Title 5  | bi-98-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 84  | Behat Rule Display9 Title 6  | bi-99-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 85  | Behat Rule Display9 Title 7  | bi-101-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 86  | Behat Rule Display8 Title 8  | bi-102-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 87  | Behat Rule Display8 Title 9  | bi-103-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 88  | Behat Rule Display8 Title 10 | bi-104-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 89  | Behat Rule Display9 Title 11 | bi-105-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 90  | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 91  | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 92  | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 93  | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 94  | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 95  | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 96  | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 97  | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 98  | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 99  | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 100 | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 101 | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 102 | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 103 | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 104 | Behat Rule Display8 Title 1  | bi-95-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 105 | Behat Rule Display8 Title 3  | bi-95-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 106 | Behat Rule Display8 Title 4  | bi-97-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 107 | Behat Rule Display9 Title 5  | bi-98-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 108 | Behat Rule Display9 Title 6  | bi-99-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 109 | Behat Rule Display9 Title 7  | bi-101-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 110 | Behat Rule Display8 Title 8  | bi-102-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 111 | Behat Rule Display8 Title 9  | bi-103-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 112 | Behat Rule Display8 Title 10 | bi-104-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 113 | Behat Rule Display9 Title 11 | bi-105-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 114 | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 115 | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 116 | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 117 | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 118 | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 119 | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 120 | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 121 | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 122 | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 123 | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 124 | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 125 | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 125 | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 126 | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 127 | Behat Rule Display8 Title 1  | bi-95-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 128 | Behat Rule Display8 Title 3  | bi-95-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 129 | Behat Rule Display8 Title 4  | bi-97-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 130 | Behat Rule Display9 Title 5  | bi-98-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 131 | Behat Rule Display9 Title 6  | bi-99-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 132 | Behat Rule Display9 Title 7  | bi-101-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 133 | Behat Rule Display8 Title 8  | bi-102-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 134 | Behat Rule Display8 Title 9  | bi-103-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 135 | Behat Rule Display8 Title 10 | bi-104-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 136 | Behat Rule Display9 Title 11 | bi-105-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 137 | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 138 | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 139 | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 140 | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 141 | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 142 | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 143 | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 144 | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 145 | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 146 | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 147 | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 148 | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 149 | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 150 | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 151 | Behat Rule Display8 Title 1  | bi-95-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 152 | Behat Rule Display8 Title 3  | bi-95-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 153 | Behat Rule Display8 Title 4  | bi-97-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 154 | Behat Rule Display9 Title 5  | bi-98-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 155 | Behat Rule Display9 Title 6  | bi-99-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 156 | Behat Rule Display9 Title 7  | bi-101-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 157 | Behat Rule Display8 Title 8  | bi-102-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 158 | Behat Rule Display8 Title 9  | bi-103-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 159 | Behat Rule Display8 Title 10 | bi-104-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 160 | Behat Rule Display9 Title 11 | bi-105-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 161 | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 162 | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 163 | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 164 | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 165 | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 166 | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 167 | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 168 | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 169 | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 170 | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 171 | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 172 | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 173 | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 174 | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 175 | Behat Rule Display8 Title 1  | bi-95-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 176 | Behat Rule Display8 Title 3  | bi-95-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 177 | Behat Rule Display8 Title 4  | bi-97-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 178 | Behat Rule Display9 Title 5  | bi-98-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 179 | Behat Rule Display9 Title 6  | bi-99-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 180 | Behat Rule Display9 Title 7  | bi-101-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 181 | Behat Rule Display8 Title 8  | bi-102-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 182 | Behat Rule Display8 Title 9  | bi-103-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 183 | Behat Rule Display8 Title 10 | bi-104-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 184 | Behat Rule Display9 Title 11 | bi-105-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 185 | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 186 | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 187 | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 188 | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 189 | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 190 | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 191 | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 192 | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 193 | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 194 | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 195 | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 196 | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 197 | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 198 | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 199 | Behat Rule Display8 Title 1  | bi-95-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 200 | Behat Rule Display8 Title 3  | bi-95-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 201 | Behat Rule Display8 Title 4  | bi-97-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 202 | Behat Rule Display9 Title 5  | bi-98-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 203 | Behat Rule Display9 Title 6  | bi-99-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 204 | Behat Rule Display9 Title 7  | bi-101-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 205 | Behat Rule Display8 Title 8  | bi-102-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 206 | Behat Rule Display8 Title 9  | bi-103-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 207 | Behat Rule Display8 Title 10 | bi-104-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 208 | Behat Rule Display9 Title 11 | bi-105-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 209 | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 210 | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 211 | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 212 | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 213 | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 214 | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 215 | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 216 | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 217 | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 218 | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 219 | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 220 | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 221 | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 222 | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 223 | Behat Rule Display8 Title 1  | bi-95-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 224 | Behat Rule Display8 Title 3  | bi-95-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 225 | Behat Rule Display8 Title 4  | bi-97-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 226 | Behat Rule Display9 Title 5  | bi-98-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 227 | Behat Rule Display9 Title 6  | bi-99-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 228 | Behat Rule Display9 Title 7  | bi-101-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 229 | Behat Rule Display8 Title 8  | bi-102-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 230 | Behat Rule Display8 Title 9  | bi-103-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 231 | Behat Rule Display8 Title 10 | bi-104-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 232 | Behat Rule Display9 Title 11 | bi-105-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 233 | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 234 | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 235 | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 236 | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 237 | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 238 | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 239 | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 240 | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 241 | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 242 | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 243 | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 244 | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 245 | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 246 | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 247 | Behat Rule Display8 Title 1  | bi-95-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 248 | Behat Rule Display8 Title 3  | bi-95-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 249 | Behat Rule Display8 Title 4  | bi-97-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 250 | Behat Rule Display9 Title 5  | bi-98-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 251 | Behat Rule Display9 Title 6  | bi-99-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 252 | Behat Rule Display9 Title 7  | bi-101-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 253 | Behat Rule Display8 Title 8  | bi-102-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 254 | Behat Rule Display8 Title 9  | bi-103-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 255 | Behat Rule Display8 Title 10 | bi-104-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 256 | Behat Rule Display9 Title 11 | bi-105-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 257 | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 258 | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 259 | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 260 | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 261 | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 262 | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 263 | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 264 | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 265 | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 266 | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 267 | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 268 | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 269 | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 270 | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 271 | Behat Rule Display8 Title 1  | bi-95-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 272 | Behat Rule Display8 Title 3  | bi-95-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 273 | Behat Rule Display8 Title 4  | bi-97-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 274 | Behat Rule Display9 Title 5  | bi-98-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 275 | Behat Rule Display9 Title 6  | bi-99-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 276 | Behat Rule Display9 Title 7  | bi-101-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 277 | Behat Rule Display8 Title 8  | bi-102-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 278 | Behat Rule Display8 Title 9  | bi-103-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 279 | Behat Rule Display8 Title 10 | bi-104-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 280 | Behat Rule Display9 Title 11 | bi-105-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 281 | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 282 | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 283 | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 284 | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 285 | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 286 | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 287 | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 288 | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 289 | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 290 | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 291 | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 292 | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 293 | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 294 | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat2 Parent 295 | Behat Rule Display9 Title 12 | bi-106-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 296 | Behat Rule Display9 Title 13 | bi-107-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 297 | Behat Rule Display8 Title 14 | bi-108-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 298 | Behat Rule Display8 Title 15 | bi-109-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 299 | Behat Rule Display8 Title 16 | bi-110-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 300 | Behat Rule Display9 Title 17 | bi-111-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 301 | Behat Rule Display9 Title 18 | bi-112-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 302 | Behat Rule Display9 Title 19 | bi-113-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
      | Behat1 Parent 303 | Behat Rule Display8 Title 20 | bi-114-po         | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      |
      | Behat1 Parent 304 | Behat Rule Display8 Title 21 | bi-115-po         | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      |
      | Behat1 Parent 305 | Behat Rule Display8 Title 22 | bi-116-po         | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 1      |
      | Behat2 Parent 306 | Behat Rule Display9 Title 23 | bi-117-po         | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      |
      | Behat2 Parent 307 | Behat Rule Display9 Title 24 | bi-118-po         | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      |
      | Behat2 Parent 308 | Behat Rule Display9 Title 25 | bi-119-po         | This is a parent rule overview 7 | Behat Concept Rule 4                        |                               | published        | 1      |
    When I am on "/rules/rulemaking-activity"
    Then I should see the text "Displaying 1 - 300 of 308"
      And I should see the link "1"
      And I should see the link "2"
      And I should see the link "Go to next page"
      And I should see the link "Go to last page"
    When I click "Go to last page"
    Then I should see the text "Displaying 301 - 308 of 308"
    When I click "Go to first page"
    Then I should see the text "Displaying 1 - 300 of 308"
    When I click "Go to next page"
    Then I should see the text "Displaying 301 - 308 of 308"
    When I click "Go to previous page"
    Then I should see the text "Displaying 1 - 300 of 308"
    When I click "Go to page 2"
    Then I should see the text "Displaying 301 - 308 of 308"
    When I click "Go to page 1"
    Then I should see the text "Displaying 1 - 300 of 308"
