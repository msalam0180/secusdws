Feature: Administator View For Regulatory File Content Types
  As a creator of rule content types
  I want to be able to view a list of rule(s)
  So that I can search, filter, view and edit rule content types

@api
Scenario: Validate Regulatory Files Admin View and Pagination
  Given I am logged in as a user with the "administrator" role
  When "rulemaking_index" terms:
      | name     |
      | ui-98-po |
      | ab-12-cd |
      | 34-12345 |
    And "division_office" terms:
      | name     |
      | office 1 |
      | office 2 |
    And I create "media" of type "static_file":
      | name         | status |
      | Behat file 3 | 1      |
    And "rule_type" terms:
      | name   |
      | Rule 3 |
    And "topics" terms:
      | name    |
      | topic1  |
      | topic12 |
      | topic13 |
      | topic4  |
    And "regulation" content:
      | title          | body | field_release_file_number | field_publish_date | field_federal_register_publish_d | field_primary_division_office | moderation_state | field_release_file | field_rule_type |
      | Rule Release A | bod3 | ab-12-cd                  | 2021-01-01         | 2021-01-30                       | office 1                      | published        | behat file 3       | Rule 3          |
    And "rule" content:
      | title      | field_display_title | field_related_topics | field_primary_division_office | moderation_state | field_file_number | status | field_related_rule |
      | Andrew   1 |                     | topic1               | office 1                      | published        | ui-98-po          | 1      |                    |
      | Brent    2 | Brent    2DT        | topic1               | office 1                      | published        | ui-98-po          | 1      |                    |
      | Carl     3 | Carl     3DT        | topic1               | office 1                      | published        | 34-12345          | 1      |                    |
      | David    4 | David    4DT        | topic1               | office 1                      | published        | 34-12345          | 0      |                    |
      | Eric     5 | Eric     5DT        |                      | office 1                      | published        | ui-98-po          | 1      |                    |
      | Frank    6 | Frank    6DT        |                      | office 1                      | published        | 34-12345          | 1      |                    |
      | George   7 |                     |                      | office 1                      | published        | 34-12345          | 1      |                    |
      | Hana     8 |                     |                      | office 1                      | published        | ui-98-po          | 0      |                    |
      | Isaic    9 |                     |                      | office 1                      | published        | 34-12345          | 1      |                    |
      | James   10 |                     |                      | office 1                      | published        | ab-12-cd          | 1      |                    |
      | Kyle    11 |                     |                      | office 1                      | published        | 34-12345          | 1      |                    |
      | Laura   12 | Laura   12DT        |                      | office 1                      | published        | 34-12345          | 1      |                    |
      | Mason   13 | Mason   13DT        | topic12              | office 1                      | published        | ab-12-cd          | 1      |                    |
      | Nanci   14 | Nanci   14DT        | topic12              | office 1                      | published        | 34-12345          | 0      |                    |
      | Olga    15 | Olga    15DT        | topic12              | office 1                      | published        | ab-12-cd          | 1      |                    |
      | Pat     16 |                     | topic12              | office 1                      | published        | 34-12345          | 1      |                    |
      | Quincy  17 |                     |                      | office 1                      | published        | 34-12345          | 1      | Rule Release A     |
      | Robert  18 |                     |                      | office 1                      | published        | ab-12-cd          | 1      |                    |
      | Sam     19 |                     |                      | office 1                      | published        | 34-12345          | 1      |                    |
      | Tom     20 |                     |                      | office 1                      | published        | 34-12345          | 1      |                    |
      | Umar    21 | Umar    21DT        | topic4               | office 2                      | published        | ab-12-cd          | 1      | Rule Release A     |
      | Violet  22 | Violet  22DT        | topic13              | office 1                      | published        | 34-12345          | 1      |                    |
      | Will    23 | Will    23DT        | topic13              | office 1                      | published        | 34-12345          | 1      |                    |
      | Xixi    24 | Xixi    24DT        | topic13              | office 1                      | published        | ab-12-cd          | 1      |                    |
      | Yolanda 25 | Yolanda 25DT        | topic13              | office 1                      | published        | 34-12345          | 1      |                    |
      | Zack    26 |                     |                      | office 1                      | published        | ui-98-po          | 1      |                    |
      | Xixi    14 |                     |                      | office 1                      | published        | ab-12-cd          | 1      |                    |
      | Yolanda 15 |                     |                      | office 1                      | published        | 34-12345          | 1      |                    |
      | Zack    16 |                     |                      | office 1                      | published        | ab-12-cd          | 1      |                    |
      | Violet  12 |                     | topic4               | office 1                      | published        | 34-12345          | 1      |                    |
    And I visit "/admin/content/rules"
  Then I should see the heading "Regulatory Files"
    And I should see the text "Title" in the "Title" row
    And I should see the text "Display Title" in the "Title" row
    And I should see the text "File Number" in the "Title" row
    And I should see the text "Regulatory Releases" in the "Title" row
    And I should see the text "Division/Office" in the "Title" row
    And I should see the text "Related Topics" in the "Title" row
    And I should see the text "Updated" in the "Title" row
    And I should see the text "Operations" in the "Title" row
    And I should see the link "Yolanda 25"
    And I should see the text "Yolanda 25DT" in the "Yolanda 25" row
    And I should see the text "34-12345" in the "Yolanda 25" row
    And I should see the text "office 1" in the "Yolanda 25" row
    And I should see the text "topic13" in the "Yolanda 25" row
    And I should see the link "Umar 21"
    And I should see the text "Umar 21DT" in the "Umar 21" row
    And I should see the text "ab-12-cd" in the "Umar 21" row
    And I should see the text "office 2" in the "Umar 21" row
    And I should see the text "topic4" in the "Umar 21" row
    And I should see the text "Displaying 1 - 30 of 30"
  When I select "25" from "Items per page"
    And I press "Apply"
    And I click "Last"
  Then I should see the text "Displaying 26 - 30 of 30"
    And I should see the link "Frank 6"
    And I should see the text "Frank 6DT" in the "Frank 6" row
    And I should see the text "34-12345" in the "Frank 6" row
    And I should see the text "office 1" in the "Frank 6" row
  When I visit "/admin/content/rules"
    And I click "Edit" in the "Quincy 17" row
    And I fill in "Title" with "Quincy Update"
    And I press "Save"
  Then I should see the link "Quincy Update"
    And I should not see the link "Quincy 17"

@api
Scenario: Confirm Title and Display Search on Regulatory Files Admin Page
  Given I am logged in as a user with the "Content Creator" role
  When "rule" content:
      | title      | field_display_title | moderation_state | status |
      | Andrew   1 |                     | published        | 1      |
      | Brent    2 | Brent    2DT        | published        | 1      |
      | Carl     3 | Carl     3DT        | published        | 1      |
      | David    4 | David    4DT        | published        | 0      |
      | Eric     5 | Eric     5DT        | published        | 1      |
      | Frank    6 | Frank    6DT        | published        | 1      |
    And I visit "/admin/content/rules"
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should see the link "Carl 3"
    And I should see the link "David 4"
    And I should see the link "Eric 5"
    And I should see the link "Frank 6"
  When I fill in "Search Title and Display Title" with "aNd"
    And I press "Apply"
  Then I should see the link "Andrew 1"
    And I should not see the link "Brent 2"
    And I should not see the link "Carl 3"
    And I should not see the link "David 4"
    And I should not see the link "Eric 5"
    And I should not see the link "Frank 6"
  When I fill in "Search Title and Display Title" with "6"
    And I press "Apply"
  Then I should see the link "Frank 6"
    And I should not see the link "Brent 2"
    And I should not see the link "Carl 3"
    And I should not see the link "David 4"
    And I should not see the link "Eric 5"
    And I should not see the link "Andrew 1"
  When I fill in "Search Title and Display Title" with "DT"
    And I press "Apply"
  Then I should see the link "Brent 2"
    And I should see the link "Carl 3"
    And I should see the link "David 4"
    And I should see the link "Eric 5"
    And I should see the link "Frank 6"
    And I should not see the link "Andrew 1"

@api
Scenario: Confirm File Number Search on Regulatory Files Admin Page
  Given I am logged in as a user with the "Content Creator" role
  When "rulemaking_index" terms:
      | name     |
      | ui-98-po |
      | ab-12-cd |
      | 34-12345 |
    And "rule" content:
      | title      | field_display_title | moderation_state | status | field_file_number |
      | Andrew   1 |                     | published        | 1      | ui-98-po          |
      | Brent    2 | Brent    2DT        | published        | 1      | ui-98-po          |
      | Carl     3 | Carl     3DT        | published        | 1      | 34-12345          |
      | David    4 | David    4DT        | published        | 0      | 34-12345          |
      | Eric     5 | Eric     5DT        | published        | 1      | ab-12-cd          |
      | Frank    6 | Frank    6DT        | published        | 1      | 34-12345          |
    And I visit "/admin/content/rules"
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should see the link "Carl 3"
    And I should see the link "David 4"
    And I should see the link "Eric 5"
    And I should see the link "Frank 6"
  When I fill in "File Number" with "34-12345 "
    And I press "Apply"
  Then I should see the link "Carl 3"
    And I should see the link "David 4"
    And I should see the link "Frank 6"
    And I should not see the link "Andrew 1"
    And I should not see the link "Brent 2"
    And I should not see the link "Eric 5"

@api @javascript
Scenario: Confirm Divison Search on Regulatory Files Admin Page
  Given I am logged in as a user with the "Content Creator" role
   When "division_office" terms:
      | name     |
      | office 1 |
      | office 2 |
      | office 3 |
    And "rule" content:
      | title    | moderation_state | status | field_primary_division_office |
      | Andrew 1 | published        | 1      | office 1                      |
      | Brent 2  | published        | 1      | office 2                      |
      | Carl 3   | published        | 1      | office 3                      |
   And I visit "/admin/content/rules"
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should see the link "Carl 3"
  When I fill in "Division/Office" with "office 1"
    And I press "Apply"
  Then I should see the link "Andrew 1"
    And I should not see the link "Brent 2"
    And I should not see the link "Carl 3"
    And I press "Reset"
  When I fill in "Division/Office" with "office 2"
    And I press "Apply"
  Then I should see the link "Brent 2"
    And I should not see the link "Andrew 1"
    And I should not see the link "Carl 3"
    And I press "Reset"
  When I fill in "Division/Office" with "office 3"
    And I press "Apply"
  Then I should see the link "Carl 3"
    And I should not see the link "Andrew 1"
    And I should not see the link "Brent 2"

@api
Scenario: Confirm Related Topic Search on Regulatory Files Admin Page
  Given I am logged in as a user with the "Content Creator" role
   When "topics" terms:
      | name    |
      | topic 1 |
      | topic 2 |
      | topic 3 |
    And "rule" content:
      | title      | moderation_state | status | field_related_topics |
      | Andrew   1 | published        | 1      | topic 1              |
      | Brent    2 | published        | 1      | topic 2              |
      | Carl     3 | published        | 1      | topic 3              |
   And I visit "/admin/content/rules"
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should see the link "Carl 3"
  When I fill in "Related Topics" with "topic 1"
    And I press "Apply"
  Then I should see the link "Andrew 1"
    And I should not see the link "Brent 2"
    And I should not see the link "Carl 3"
    And I press "Reset"
  When I fill in "Related Topics" with "topic 2"
    And I press "Apply"
  Then I should see the link "Brent 2"
    And I should not see the link "Andrew 1"
    And I should not see the link "Carl 3"
    And I press "Reset"
  When I fill in "Related Topics" with "topic 3"
    And I press "Apply"
  Then I should see the link "Carl 3"
    And I should not see the link "Andrew 1"
    And I should not see the link "Brent 2"

@api
Scenario: Confirm Published Filter on Regulatory Files Admin Page
  Given I am logged in as a user with the "Content Creator" role
   When "rule" content:
      | title      | moderation_state | status |
      | Andrew   1 | published        | 1      |
      | Brent    2 | draft            | 0      |
      | Carl     3 | published        | 1      |
   And I visit "/admin/content/rules"
  Then I should see the link "Andrew 1"
    And I should see the link "Brent 2"
    And I should see the link "Carl 3"
  When I select "No" from "Published"
    And I press "Apply"
  Then I should see the link "Brent 2"
    And I should not see the link "Andrew 1"
    And I should not see the link "Carl 3"
    And I press "Reset"
  When I select "Yes" from "Published"
    And I press "Apply"
  Then I should see the link "Andrew 1"
    And I should see the link "Carl 3"
    And I should not see the link "Brent 2"

@api @javascript
Scenario: Sorting Title on Regulatory Files Admin Page
  Given I am logged in as a user with the "content_creator" role
  When "rule" content:
    | title      | field_display_title | moderation_state | status |
    | Andrew   1 | Andrew 1            | published        | 1      |
    | Brent    2 | Brent 2             | published        | 1      |
    | Carl     3 | Carl 3              | published        | 1      |
    | David    4 | David 4             | published        | 1      |
    And I visit "/admin/content/rules"
  When I click the sort filter "Title"
  Then "Andrew 1" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Brent 2" should precede "Carl 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Carl 3" should precede "David 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Title"
  Then "David 4" should precede "Carl 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Carl 3" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Brent 2" should precede "Andrew 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"

@api @javascript
Scenario: Sorting Updated date on Regulatory Files Admin Page
  Given I am logged in as a user with the "content_creator" role
  When "rule" content:
    | title      |  field_display_title | moderation_state | status | changed   |
    | Andrew   1 |  Andrew 1            | published        | 1      | -1 days   |
    | Brent    2 |  Brent 2             | published        | 1      | -14 days  |
    | Carl     3 |  Carl 3              | published        | 1      | -30 days  |
    | David    4 |  David 4             | published        | 1      | -222 days |
    And I visit "/admin/content/rules"
  Then "Andrew 1" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Brent 2" should precede "Carl 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Carl 3" should precede "David 4" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
  When I click the sort filter "Updated"
  Then "David 4" should precede "Carl 3" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Carl 3" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
    And "Brent 2" should precede "Andrew 1" for the query "//td[contains(@class, 'views-field views-field-field-display-title')]"
