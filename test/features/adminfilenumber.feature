Feature: Administator view for File Number
  As a creator of Release content types
  I want to be able to view a list of File Numbers
  So that I can search, filter, view and edit Release content types base on File Number

@api
Scenario: Validate File Number Admin View and Pagination
  Given I am logged in as a user with the "sitebuilder" role
  When "rulemaking_index" terms:
    | name       | field_respondents | status | field_ap_status |
    | ui-98-po   | Anthony           | 0      | Open            |
    | ab-12-cd   | Mary              | 1      | Close           |
    | 34-12345   | Juan              | 1      | Close           |
    | Andrew   1 | A1                |        |                 |
    | Brent    2 | B2                |        |                 |
    | Carl     3 | C3                |        |                 |
    | David    4 | D4                |        |                 |
    | Eric     5 | E5                |        |                 |
    | Frank    6 | F6                |        |                 |
    | George   7 | G7                |        |                 |
    | Hana     8 | H8                |        |                 |
    | Isaic    9 | I9                |        |                 |
    | James   10 | J10               |        |                 |
    | Kyle    11 | K11               |        |                 |
    | Laura   12 | L12               |        |                 |
    | Mason   13 | M13               |        |                 |
    | Nanci   14 | N14               |        |                 |
    | Olga    15 | O15               |        |                 |
    | Pat     16 | P16               |        |                 |
    | Quincy  17 | Q17               |        |                 |
    | Robert  18 | R18               |        |                 |
    | Sam     19 | S19               |        |                 |
    | Tom     20 | T20               |        |                 |
    | Umar    21 | U21               |        |                 |
    | Violet  22 | V22               |        |                 |
    | Will    23 | W23               |        |                 |
    | Xixi    24 | X24               |        |                 |
    | Yolanda 25 | Y25               |        |                 |
    | Zack    26 | Z26               |        |                 |
    And "release" content:
      | title      | body         | field_release_type         | field_release_number | field_respondents | moderation_state | field_publish_date | field_release_file_number | status |
      | Andrew   1 | detail body1 | Trading Suspensions        | ab-12-cd             | Andrew            | published        | 01-01-2021         | ab-12-cd                  | 1      |
      | Brent    2 | detail body1 | Trading Suspensions        | ui-98-po             | Brent             | published        | -1 days            | ui-98-po                  | 1      |
      | Carl     3 | detail body1 | Trading Suspensions        | 34-12345             | Carl              | published        | -20 days           | 34-12345                  | 1      |
      | David    4 | detail body1 | Trading Suspensions        | 34-12345             | David             | published        | -30 days           | 34-12345                  | 0      |
      | Eric     5 | detail body1 | Administrative Proceedings | ui-98-po             | Eric              | published        | -15 days           | ui-98-po                  | 1      |
      | Frank    6 | detail body1 | Administrative Proceedings | 34-12345             | Frank             | published        | -13 days           | 34-12345                  | 1      |
      | George   7 | detail body1 | Administrative Proceedings | 34-12345             | George            | published        | -11 days           | 34-12345                  | 1      |
      | Hana     8 | detail body1 | Administrative Proceedings | ui-98-po             | Hana              | published        | -1 days            | ui-98-po                  | 0      |
      | Isaic    9 | detail body1 | Administrative Proceedings | 34-12345             | Isaic             | published        | -11 days           | 34-12345                  | 1      |
      | James   10 | detail body1 | Administrative Proceedings | ab-12-cd             | James             | published        | -13 days           | ab-12-cd                  | 1      |
      | Kyle    11 | detail body1 | ALJ Orders                 | 34-12345             | Kyle              | published        | -10 days           | 34-12345                  | 1      |
      | Laura   12 | detail body1 | ALJ Orders                 | 34-12345             | Laura             | published        | -1 days            | 34-12345                  | 1      |
      | Mason   13 | detail body1 | ALJ Orders                 | ab-12-cd             | Mason             | published        | -2 days            | ab-12-cd                  | 1      |
      | Nanci   14 | detail body1 | ALJ Orders                 | 34-12345             | Nanci             | published        | -22 days           | 34-12345                  | 0      |
      | Olga    15 | detail body1 | ALJ Orders                 | ab-12-cd             | Olga              | published        | -10 days           | ab-12-cd                  | 1      |
      | Pat     16 | detail body1 | ALJ Orders                 | 34-12345             | Pat               | published        | -4 days            | 34-12345                  | 1      |
      | Quincy  17 | detail body1 | ALJ Orders                 | 34-12345             | Quincy            | published        | -5 days            | 34-12345                  | 1      |
      | Robert  18 | detail body1 | ALJ Orders                 | ab-12-cd             | Robert            | published        | -6 days            | ab-12-cd                  | 1      |
      | Sam     19 | detail body1 | ALJ Orders                 | 34-12345             | Sam               | published        | -10 days           | 34-12345                  | 1      |
      | Tom     20 | detail body1 | Trading Suspensions        | 34-12345             | Tom               | published        | -8 days            | 34-12345                  | 1      |
      | Umar    21 | detail body1 | Trading Suspensions        | ab-12-cd             | Umar              | published        | -6 days            | ab-12-cd                  | 0      |
      | Violet  22 | detail body1 | Trading Suspensions        | 34-12345             | Violet            | published        | -31 days           | 34-12345                  | 1      |
      | Will    23 | detail body1 | Trading Suspensions        | 34-12345             | Will              | published        | -10 days           | 34-12345                  | 1      |
      | Xixi    24 | detail body1 | Trading Suspensions        | ab-12-cd             | Xixi              | published        | +3 days            | ab-12-cd                  | 1      |
      | Yolanda 25 | detail body1 | Trading Suspensions        | 34-12345             | Yolanda           | published        | -5 days            | 34-12345                  | 1      |
      | Zack    26 | detail body1 | ALJ Orders                 | ui-98-po             | Zack              | published        | -80 days           | ui-98-po                  | 1      |
      | Xixi    14 | detail body1 | Trading Suspensions        | ab-12-cd             | Xixi              | published        | +3 days            | ab-12-cd                  | 1      |
      | Yolanda 15 | detail body1 | Trading Suspensions        | 34-12345             | Yolanda           | published        | -5 days            | 34-12345                  | 1      |
      | Zack    16 | detail body1 | Trading Suspensions        | ab-12-cd             | Zack              | published        | -80 days           | ab-12-cd                  | 1      |
      | Violet  12 | detail body1 | Trading Suspensions        | 34-12345             | Violet            | published        | -31 days           | 34-12345                  | 1      |
    And I visit "/admin/content/file-number"
  Then I should see the link "ui-98-po"
    And I should see the text "Open" in the "ui-98-po" row
    And I should see the text "Anthony" in the "ui-98-po" row
    And I should see the text "No" in the "ui-98-po" row
    And I should see the text "Brent 2, Eric 5, Hana 8, Zack 26" in the "ui-98-po" row
    And I should see the link "34-12345"
    And I should see the text "Close" in the "34-12345" row
    And I should see the text "Juan" in the "34-12345" row
    And I should see the text "Yes" in the "34-12345" row
    And I should see the text "Carl 3, David 4, Frank 6, George 7, Isaic 9, Kyle 11, Laura 12, Nanci 14, Pat 16, Quincy 17, Sam 19, Tom 20, Violet 12, Violet 22, Will 23, Yolanda 15, Yolanda 25" in the "34-12345" row
    And I should see the text "Displaying 1 - 29 of 29"
  When I select "25" from "Items per page"
    And I press "Apply"
    And I click "Last"
  Then I should see the text "Displaying 26 - 29 of 29"
  When I click "First"
    And I click "Robert 18"
  Then I should see the heading "Mary"
  When I visit "/admin/content/file-number"
    And I click "Tom 20"
  Then I should see the heading "Juan"
  When I visit "/admin/content/file-number"
    And I click "ab-12-cd"
  Then I should see the heading "Administrative Proceeding File No. ab-12-cd"
    And I should see the heading "Respondents"
    And I should see the heading "Documents"
    And I should see the text "Mary"
    And I should see the text "Jan. 1, 2021"
    And I should see "Zack 16"
    And I should see "Robert 18"
    And I should see "Mason 13"
  When I visit "/litigation/apdocuments/ui-98-po/edit"
    And I fill in "File Number" with "Update ui"
    And I press "Save"
    And I visit "/admin/content/file-number"
  Then I should see the link "Update ui"
    And I should not see the link "ui-98-po"

@api
Scenario: Confirm File Number Search on File Number Admin Page
  Given I am logged in as a user with the "Content Creator" role
  When "rulemaking_index" terms:
    | name       | field_respondents | status |
    | Andrew   1 | ui-98-po          | 1      |
    | Brent    2 | ui-98-po          | 1      |
    | David  154 | 34-12345          | 0      |
    | Nanci   14 | 34-12345          | 0      |
    | Yolanda 25 | 34-12345          | 1      |
    | Yolanda 15 | 34-12345          | 1      |
    | Zack    16 | ab-12-cd          | 1      |
    | Violet  15 | 34-12345          | 1      |
    And I visit "/admin/content/file-number"
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should see the link "Yolanda 25"
    And I should see the link "Yolanda 15"
    And I should see the link "Violet 15"
    And I should see the link "David 154"
  When I fill in "File Number" with "aNd"
    And I press "Apply"
  Then I should see the link "Andrew 1"
    And I should see the link "Yolanda 25"
    And I should see the link "Yolanda 15"
    And I should not see the link "Brent 2"
    And I should not see the link "Violet 15"
    And I should not see the link "David 154"
  When I fill in "File Number" with "david"
    And I press "Apply"
  Then I should see the link "David 154"
    And I should not see the link "Violet 15"
    And I should not see the link "Yolanda 15"
    And I should not see the link "Andrew 1"
    And I should not see the link "Brent 2"
    And I should not see the link "Yolanda 25"
  When I fill in "File Number" with "15"
    And I press "Apply"
  Then I should see the link "David 154"
    And I should see the link "Violet 15"
    And I should see the link "Yolanda 15"
    And I should not see the link "Andrew 1"
    And I should not see the link "Brent 2"
    And I should not see the link "Yolanda 25"
  When I press "Reset"
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should see the link "Yolanda 25"
    And I should see the link "Yolanda 15"
    And I should see the link "Violet 15"
    And I should see the link "David 154"

@api
Scenario: Validate Filters on File Number Admin Page
  Given I am logged in as a user with the "Content Creator" role
  When "rulemaking_index" terms:
    | name       | field_respondents | status | field_ap_status |
    | Andrew   1 | ui-98-po          | 1      | Open            |
    | Brent    2 | ui-98-po          | 1      | ALJ Pending     |
    | David  154 | 34-12345          | 0      | Close           |
    | Nanci   14 | 34-12345          | 0      | Open            |
    | Yolanda 25 | 34-12345          | 1      | SRO Pending     |
    | Yolanda 15 | 34-12345          | 1      | Open            |
    | Zack    16 | ab-12-cd          | 1      | Close           |
    | Violet  15 | 34-12345          | 1      | Close           |
    And I visit "/admin/content/file-number"
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should see the link "Zack 16"
    And I should see the link "Yolanda 25"
    And I should see the link "David 154"
    And I should see the link "Nanci 14"
  When I select "SRO Pending" from "Status"
    And I press the "Apply" button
  Then I should see the link "Yolanda 25"
    And I should not see the link "Brent 2"
    And I should not see the link "Violet 15"
    And I should not see the link "David 154"
    And I should not see the link "Nanci 14"
  When I additionally select "ALJ Pending" from "Status"
    And I press the "Apply" button
  Then I should see the link "Brent 2"
    And I should see the link "Yolanda 25"
    And I should not see the link "Violet 15"
    And I should not see the link "David 154"
    And I should not see the link "Nanci 14"

@api
Scenario: Validate Filtering on Start and End Date on File Number Administrative Page
  Given I am logged in as a user with the "Content Creator" role
  When "rulemaking_index" terms:
    | name       | field_respondents | status | field_ap_status | changed    |
    | Andrew   1 | ui-98-po          | 1      | Open            | 1661279901 |
    | Brent    2 | ui-98-po          | 1      | ALJ Pending     | 1656633600 |
    | David  154 | 34-12345          | 0      | Close           | 1585699200 |
    | Nanci   14 | 34-12345          | 0      | Open            | 922924800  |
    | Yolanda 25 | 34-12345          | 1      | SRO Pending     | 922924800  |
    | Yolanda 15 | 34-12345          | 1      | Open            | 922924800  |
    | Zack    16 | ab-12-cd          | 1      | Close           | 922924800  |
    | Violet  15 | 34-12345          | 1      | Close           | 922924800  |
    And I visit "/admin/content/file-number"
    And I fill in "Updated Date Start" with "2022-08-25"
    And I press "Apply"
  Then I should not see the link "Andrew 1"
    And I should not see the link "Brent 2"
    And I should not see the link "Zack 16"
    And I should not see the link "Yolanda 25"
    And I should not see the link "David 154"
    And I should not see the link "Nanci 14"
  When I fill in "Updated Date Start" with "2022-08-22"
    And I press the "Apply" button
  Then I should see the link "Andrew 1"
    And I should not see the link "Brent 2"
    And I should not see the link "Violet 15"
    And I should not see the link "David 154"
    And I should not see the link "Nanci 14"
  When I press the "Reset" button
    And I fill in "Updated Date Start" with "2021-01-01"
    And I press the "Apply" button
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should not see the link "Violet 15"
    And I should not see the link "David 154"
    And I should not see the link "Nanci 14"
  When I fill in "Updated Date Start" with "2020-01-01"
    And I fill in "Updated Date End" with "2022-08-08"
    And I press the "Apply" button
  Then I should see the link "Brent 2"
    And I should see the link "David 154"
    And I should not see the link "Andrew 1"
    And I should not see the link "Violet 15"
    And I should not see the link "Nanci 14"
  When I press the "Reset" button
    And I fill in "Updated Date End" with "2022-09-01"
    And I press the "Apply" button
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should see the link "David 154"
    And I should see the link "Violet 15"
    And I should see the link "Nanci 14"

@api @javascript
Scenario: Sorting File Number on File Number Page
  Given I am logged in as a user with the "content_creator" role
  When "rulemaking_index" terms:
    | name       | field_respondents | status | field_ap_status |
    | Andrew 1   | Andrew 1          | 1      | Open            |
    | Brent 2    | Brent 2           | 1      | ALJ Pending     |
    | David 154  | David 154         | 0      | Close           |
    | Nanci 14   | Nanci 14          | 0      | Open            |
    | Yolanda 25 | Yolanda 25        | 1      | SRO Pending     |
    | Yolanda 15 | Yolanda 15        | 1      | Open            |
    | Zack    16 | Zack    16        | 1      | Close           |
    | Violet  15 | Violet  15        | 1      | Close           |
    And I visit "/admin/content/file-number"
  When I click the sort filter "File Number"
  Then "Andrew 1" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent 2" should precede "David 154" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "David 154" should precede "Nanci 14" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
  When I click the sort filter "File Number"
  Then "Nanci 14" should precede "David 154" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "David 154" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent 2" should precede "Andrew 1" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"

@api @javascript
Scenario: Sorting Status on File Number Page
  Given I am logged in as a user with the "content_creator" role
  When "rulemaking_index" terms:
    | name       | field_respondents | status | field_ap_status           |
    | Andrew 1   | Andrew 1          | 1      | ALJ Pending               |
    | Brent 2    | Brent 2           | 1      | ALJ Remand Pending        |
    | David 154  | David 154         | 0      | Close                     |
    | Nanci 14   | Nanci 14          | 0      | Commission Disg Pending   |
    | Yolanda 25 | Yolanda 25        | 1      | Commission Pending        |
    | Yolanda 15 | Yolanda 15        | 1      | Commission Remand Pending |
    | Zack    16 | Zack    16        | 1      | Intentionally Omitted     |
    | Violet  15 | Violet  15        | 1      | SRO Pending               |
    | Eric  125  | Eric  125         | 1      | Open                      |
    And I visit "/admin/content/file-number"
    And I click the sort filter "Status"
  Then "Andrew 1" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent 2" should precede "David 154" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "David 154" should precede "Nanci 14" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
  When I click the sort filter "Status"
  Then "Nanci 14" should precede "David 154" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "David 154" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent 2" should precede "Andrew 1" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"

@api @javascript
Scenario: Sorting Respondents Type on File Number Page
  Given I am logged in as a user with the "content_creator" role
  When "rulemaking_index" terms:
    | name       | field_respondents |
    | Andrew 1   | Andrew 1          |
    | Brent 2    | Brent 2           |
    | David 154  | David 154         |
    | Nanci 14   | Nanci 14          |
    | Yolanda 25 | Yolanda 25        |
    | Yolanda 15 | Yolanda 15        |
    | Zack    16 | Zack    16        |
    | Violet  15 | Violet  15        |
    | Eric  125  | Eric  125         |
    And I visit "/admin/content/file-number"
    And I click the sort filter "Respondents"
  Then "Andrew 1" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent 2" should precede "David 154" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "David 154" should precede "Nanci 14" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
  When I click the sort filter "Respondents"
  Then "Nanci 14" should precede "David 154" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "David 154" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent 2" should precede "Andrew 1" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"

@api @javascript
Scenario: Sorting Published on File Number Page
  Given I am logged in as a user with the "content_creator" role
  When "rulemaking_index" terms:
    | name       | field_respondents | status |
    | Andrew 1   | Andrew 1          | 1      |
    | Brent 2    | Brent 2           | 0      |
    | David 154  | David 154         | 1      |
    And I visit "/admin/content/file-number"
    And I click the sort filter "Published"
  Then "Brent 2" should precede "Andrew 1" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Andrew 1" should precede "David 154" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
  When I click the sort filter "Published"
  Then "Andrew 1" should precede "David 154" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "David 154" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"

@api @javascript
Scenario: Sorting Updated on File Number Page
  Given I am logged in as a user with the "content_creator" role
  When "rulemaking_index" terms:
    | name       | field_respondents | status | changed    |
    | Andrew 1   | Andrew 1          | 1      | 1661279901 |
    | Brent 2    | Brent 2           | 0      | 1656633600 |
    | Carl 3     | Carl 3            | 0      | 1585699200 |
    And I visit "/admin/content/file-number"
  Then "Andrew 1" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent 2" should precede "Carl 3" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
  When I click the sort filter "Updated"
  Then "Carl 3" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
    And "Brent 2" should precede "Andrew 1" for the query "//td[contains(@class, 'views-field views-field-field-respondents')]"
