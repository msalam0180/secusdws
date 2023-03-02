Feature: Administator View For Regulatory Release Content Types
  As a creator of Regulatory Release content types
  I want to be able to view a list of Regulatory Release(s)
  So that I can search, filter, view and edit Regulatory Release content types

Background:
  Given "rule_type" terms:
    | name                |
    | Interim Final Rules |
    | Interpretive        |
    | Rule 3              |

@api
Scenario: Validate Regulatory Releases Admin View and Pagination
  Given I am logged in as a user with the "content_creator" role
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
      | name         | field_display_title | field_media_file        | field_description_abstract | field_link_text_override | status |
      | Behat file 1 | published media     | behat-file_data.pdf     | This is description abs    | Behat 1                  | 1      |
      | Behat file 2 | published media     | behat-file_invalert.pdf | This is description abs    |                          | 1      |
    And I create "media" of type "link":
      | name                | field_media_entity_link                                | status | mid |
      | Behat Page Link     | https://sec.lndo.site/page/enforcement-section-landing | 1      | 1   |
      | Behat External Link | http://google.com                                      | 1      | 2   |
    And "regulation" content:
      | title      | body         | field_rule_type     | field_release_number |field_primary_division_office | moderation_state | field_publish_date | field_release_file_number | field_see_also      | field_release_file | status |
      | Andrew   1 | detail body1 | Proposed            | ui-98-po             | office 1                     | published        | 01-01-2021         | ui-98-po                  | Behat Page Link     | Behat file 1       | 1      |
      | Brent    2 | detail body1 | Proposed            | ui-98-po             | office 1                     | published        | -1 days            | ui-98-po                  | Behat Page Link     |                    | 1      |
      | Carl     3 | detail body1 | Proposed            | 34-12345             | office 1                     | published        | -20 days           | 34-12345                  |                     | Behat file 2       | 1      |
      | David    4 | detail body1 | Proposed            | 34-12345             | office 1                     | published        | -30 days           | 34-12345                  | Behat Page Link     |                    | 0      |
      | Eric     5 | detail body1 | Interim Final Rules | ui-98-po             | office 1                     | published        | -15 days           | ui-98-po                  | Behat Page Link     | Behat file 1       | 1      |
      | Frank    6 | detail body1 | Interim Final Rules | 34-12345             | office 1                     | published        | -13 days           | 34-12345                  | Behat Page Link     |                    | 1      |
      | George   7 | detail body1 | Interim Final Rules | 34-12345             | office 1                     | published        | -11 days           | 34-12345                  |                     |                    | 1      |
      | Hana     8 | detail body1 | Interim Final Rules | ui-98-po             | office 1                     | published        | -1 days            | ui-98-po                  | Behat Page Link     | Behat file 2       | 0      |
      | Isaic    9 | detail body1 | Interim Final Rules | 34-12345             | office 1                     | published        | -11 days           | 34-12345                  | Behat Page Link     |                    | 1      |
      | James   10 | detail body1 | Interim Final Rules | ab-12-cd             | office 1                     | published        | -13 days           | ab-12-cd                  | Behat Page Link     |                    | 1      |
      | Kyle    11 | detail body1 | Interpretive        | 34-12345             | office 1                     | published        | -10 days           | 34-12345                  | Behat Page Link     |                    | 1      |
      | Laura   12 | detail body1 | Interpretive        | 34-12345             | office 1                     | published        | -1 days            | 34-12345                  | Behat Page Link     | Behat file 1       | 1      |
      | Mason   13 | detail body1 | Interpretive        | ab-12-cd             | office 1                     | published        | -2 days            | ab-12-cd                  | Behat Page Link     |                    | 1      |
      | Nanci   14 | detail body1 | Interpretive        | 34-12345             | office 1                     | published        | -22 days           | 34-12345                  | Behat Page Link     | Behat file 1       | 0      |
      | Olga    15 | detail body1 | Interpretive        | ab-12-cd             | office 1                     | published        | -10 days           | ab-12-cd                  | Behat Page Link     |                    | 1      |
      | Pat     16 | detail body1 | Interpretive        | 34-12345             | office 1                     | published        | -4 days            | 34-12345                  |                     | Behat file 1       | 1      |
      | Quincy  17 | detail body1 | Interpretive        | 34-12345             | office 1                     | published        | -5 days            | 34-12345                  |                     |                    | 1      |
      | Robert  18 | detail body1 | Interpretive        | ab-12-cd             | office 1                     | published        | -6 days            | ab-12-cd                  |                     |                    | 1      |
      | Sam     19 | detail body1 | Interpretive        | 34-12345             | office 1                     | published        | -10 days           | 34-12345                  | Behat Page Link     | Behat file 2       | 1      |
      | Tom     20 | detail body1 | Proposed            | 34-12345             | office 1                     | published        | -8 days            | 34-12345                  | Behat Page Link     |                    | 1      |
      | Umar    21 | detail body1 | Proposed            | ab-12-cd             | office 1                     | published        | -6 days            | ab-12-cd                  | Behat Page Link     | Behat file 1       | 0      |
      | Violet  22 | detail body1 | Proposed            | 34-12345             | office 1                     | published        | -31 days           | 34-12345                  | Behat Page Link     |                    | 1      |
      | Will    23 | detail body1 | Proposed            | 34-12345             | office 1                     | published        | -10 days           | 34-12345                  | Behat Page Link     | Behat file 1       | 1      |
      | Xixi    24 | detail body1 | Proposed            | ab-12-cd             | office 1                     | published        | +3 days            | ab-12-cd                  | Behat Page Link     |                    | 1      |
      | Yolanda 25 | detail body1 | Proposed            | 34-12345             | office 1                     | published        | -5 days            | 34-12345                  | Behat Page Link     |                    | 1      |
      | Zack    26 | detail body1 | Interpretive        | ui-98-po             | office 1                     | published        | -80 days           | ui-98-po                  | Behat External Link | Behat file 2       | 1      |
      | Xixi    14 | detail body1 | Proposed            | ab-12-cd             | office 1                     | published        | +3 days            | ab-12-cd                  | Behat Page Link     |                    | 1      |
      | Yolanda 15 | detail body1 | Proposed            | 34-12345             | office 1                     | published        | -5 days            | 34-12345                  | Behat Page Link     |                    | 1      |
      | Zack    16 | detail body1 | Proposed            | ab-12-cd             | office 1                     | published        | -80 days           | ab-12-cd                  | Behat Page Link     | Behat file 1       | 1      |
      | Violet  12 | detail body1 | Proposed            | 34-12345             | office 1                     | published        | -31 days           | 34-12345                  | Behat Page Link     |                    | 1      |
    And I visit "/admin/content/rule-releases"
  Then I should see the heading "Regulatory Releases"
    And I should see the text "Title" in the "Issue Date" row
    And I should see the text "Parent Rule" in the "Title" row
    And I should see the text "Issue Date" in the "Title" row
    And I should see the text "Rule Type" in the "Title" row
    And I should see the text "Release File" in the "Title" row
    And I should see the text "File Number" in the "Title" row
    And I should see the text "Release Number" in the "Title" row
    And I should see the text "See Also" in the "Title" row
    And I should see the text "Updated" in the "Title" row
    And I should see the text "Andrew 1"
    And I should see the text "2021-01-01" in the "Andrew 1" row
    And I should see the text "Proposed" in the "Andrew 1" row
    And I should see the link "behat-file_data.pdf"
    And I should see the text "Andrew" in the "Andrew 1" row
    And I should see the text "ui-98-po" in the "Andrew 1" row
    And I should see the link "https://sec.lndo.site/page/enforcement-section-landing"
    And I should see the text "David 4"
    And I should see the text "Interim Final Rules" in the "Eric 5" row
    And I should see the text "Interpretive" in the "Kyle 11" row
    And I should see the text "Displaying 1 - 30 of 30"
  When I select "25" from "Items per page"
    And I press "Apply"
    And I click "Last"
  Then I should see the text "Displaying 26 - 30 of 30"
    And I should see the text "Brent 2"
    And I should see the text "Proposed" in the "Brent 2" row
    And I should see the text "ui-98-po" in the "Brent 2" row
    And I should see the link "https://sec.lndo.site/page/enforcement-section-landing"
  When I visit "/admin/content/rule-releases"

@api
Scenario: Confirm Title Search on Regulatory Releases Admin Page
  Given I am logged in as a user with the "Content Creator" role
  When "regulation" content:
    | title      | body         | field_rule_type  | field_release_number | moderation_state | field_publish_date | status |
    | Andrew   1 | detail body1 | Proposed         | ui-98-po             | published        | 01-01-2021         | 1      |
    | Brent    2 | detail body1 | Proposed         | ui-98-po             | published        | -1 days            | 1      |
    | David  154 | detail body1 | Proposed         | 34-12345             | published        | -30 days           | 0      |
    | Nanci   14 | detail body1 | Interpretive     | 34-12345             | published        | -22 days           | 0      |
    | Yolanda 25 | detail body1 | Proposed         | 34-12345             | published        | -5 days            | 1      |
    | Yolanda 15 | detail body1 | Proposed         | 34-12345             | published        | -5 days            | 1      |
    | Zack    16 | detail body1 | Proposed         | ab-12-cd             | published        | -80 days           | 1      |
    | Violet  15 | detail body1 | Proposed         | 34-12345             | published        | -31 days           | 1      |
    And I visit "/admin/content/rule-releases"
  Then I should see the text "Andrew 1"
    And I should see the text "Brent 2"
    And I should see the text "Yolanda 25"
    And I should see the text "Yolanda 15"
    And I should see the text "Violet 15"
    And I should see the text "David 154"
  When I fill in "Title" with "aNd"
    And I press "Apply"
  Then I should see the text "Andrew 1"
    And I should see the text "Yolanda 25"
    And I should see the text "Yolanda 15"
    And I should not see the text "Brent 2"
    And I should not see the text "Violet 15"
    And I should not see the text "David 154"
  When I visit "rule-release/david-154/edit"
    And I check the box "edit-status-value"
    And I press "Save"
    And I visit "/admin/content/rule-releases"
    And I fill in "Title" with "15"
    And I press "Apply"
  Then I should see the text "Violet 15"
    And I should see the text "Yolanda 15"
    And I should see the text "David 154"
    And I should not see the text "Andrew 1"
    And I should not see the text "Brent 2"
    And I should not see the text "Yolanda 25"

@api @javascript
Scenario: Confirm Release Number Search on Regulatory Releases Admin Page
  Given I am logged in as a user with the "Content Creator" role
  When "regulation" content:
    | title      | body         | field_rule_type  | field_release_number | moderation_state | field_publish_date | status |
    | Andrew   1 | detail body1 | Proposed         | ui-98-po             | published        | 01-01-2021         | 1      |
    | Brent    2 | detail body1 | Proposed         | ui-98-po             | published        | -1 days            | 1      |
    | David  154 | detail body1 | Proposed         | 34-12345             | published        | -30 days           | 0      |
    | Nanci   14 | detail body1 | Interpretive     | 34-12345             | published        | -22 days           | 0      |
    | Yolanda 25 | detail body1 | Proposed         | 34-12345             | published        | -5 days            | 1      |
    | Yolanda 15 | detail body1 | Proposed         | 34-12345             | published        | -5 days            | 1      |
    | Zack    16 | detail body1 | Proposed         | ab-12-cd             | published        | -80 days           | 1      |
    | Violet  15 | detail body1 | Proposed         | 34-12345             | published        | -31 days           | 1      |
    And I visit "/admin/content/rule-releases"
  Then I should see the text "Andrew 1"
    And I should see the text "Brent 2"
    And I should see the text "David 154"
    And I should see the text "Nanci 14"
    And I should see the text "Yolanda 25"
    And I should see the text "Yolanda 15"
    And I should see the text "Zack 16"
    And I should see the text "Violet 15"
  #Full search
  When I fill in "Release Number" with "34-12345"
    And I press "Apply"
  Then I should not see the text "Andrew 1"
    And I should not see the text "Brent 2"
    And I should see the text "David 154"
    And I should see the text "Nanci 14"
    And I should see the text "Yolanda 25"
    And I should see the text "Yolanda 15"
    And I should not see the text "Zack 16"
    And I should see the text "Violet 15"
    And I press "Reset"
  #Partial search alpha chars
  When I fill in "Release Number" with "-pO"
    And I press "Apply"
  Then I should see the text "Andrew 1"
    And I should see the text "Brent 2"
    And I should not see the text "David 154"
    And I should not see the text "Nanci 14"
    And I should not see the text "Yolanda 25"
    And I should not see the text "Yolanda 15"
    And I should not see the text "Zack 16"
    And I should not see the text "Violet 15"
    And I press "Reset"
  #Partial search numeric chars
  When I fill in "Release Number" with "123"
    And I press "Apply"
  Then I should not see the text "Andrew 1"
    And I should not see the text "Brent 2"
    And I should see the text "David 154"
    And I should see the text "Nanci 14"
    And I should see the text "Yolanda 25"
    And I should see the text "Yolanda 15"
    And I should not see the text "Zack 16"
    And I should see the text "Violet 15"

@api
Scenario: Confirm Issue Date Search on Regulatory Releases Admin Page
  Given I am logged in as a user with the "Content Creator" role
  When "regulation" content:
    | title      | body         | field_rule_type  | field_release_number | moderation_state | field_publish_date  | status |
    | Andrew   1 | detail body1 | Proposed         | ui-98-po             | published        | 2021-01-01T17:00:00 | 1      |
    | Brent    2 | detail body1 | Proposed         | ui-98-po             | published        | 2022-08-22T17:00:00 | 1      |
    | David  154 | detail body1 | Proposed         | 34-12345             | published        | 2022-07-24T17:00:00 | 0      |
    | Nanci   14 | detail body1 | Interpretive     | 34-12345             | published        | 2022-08-01T17:00:00 | 0      |
    | Yolanda 25 | detail body1 | Proposed         | 34-12345             | published        | 2022-08-18T17:00:00 | 1      |
    | Yolanda 15 | detail body1 | Proposed         | 34-12345             | published        | 2022-08-18T17:00:00 | 1      |
    | Zack    16 | detail body1 | Proposed         | ab-12-cd             | published        | 2022-06-04T17:00:00 | 1      |
    | Violet  15 | detail body1 | Proposed         | 34-12345             | published        | 2022-07-23T17:00:00 | 1      |
    And I visit "/admin/content/rule-releases"
  Then I should see the text "Andrew 1"
    And I should see the text "Brent 2"
    And I should see the text "David 154"
    And I should see the text "Nanci 14"
    And I should see the text "Yolanda 25"
    And I should see the text "Yolanda 15"
    And I should see the text "Zack 16"
    And I should see the text "Violet 15"
  #Search results in single item
  When I fill in "Issue Date Start" with "2021-01-01"
    And I fill in "Issue Date End" with "2021-01-02"
    And I press "Apply"
  Then I should see the text "Andrew 1"
    And I should not see the text "Brent 2"
    And I should not see the text "David 154"
    And I should not see the text "Nanci 14"
    And I should not see the text "Yolanda 25"
    And I should not see the text "Yolanda 15"
    And I should not see the text "Zack 16"
    And I should not see the text "Violet 15"
    And I press "Reset"
  #Search results in multiple items
  When I fill in "Issue Date Start" with "2022-08-18"
    And I fill in "Issue Date End" with "2022-08-19"
    And I press "Apply"
  Then I should not see the text "Andrew 1"
    And I should not see the text "Brent 2"
    And I should not see the text "David 154"
    And I should not see the text "Nanci 14"
    And I should see the text "Yolanda 25"
    And I should see the text "Yolanda 15"
    And I should not see the text "Zack 16"
    And I should not see the text "Violet 15"
    And I press "Reset"
  #Search is not end date inclusive (no search results)
  When I fill in "Issue Date Start" with "2022-08-18"
    And I fill in "Issue Date End" with "2022-08-18"
    And I press "Apply"
  Then I should not see the text "Andrew 1"
    And I should not see the text "Brent 2"
    And I should not see the text "David 154"
    And I should not see the text "Nanci 14"
    And I should not see the text "Yolanda 25"
    And I should not see the text "Yolanda 15"
    And I should not see the text "Zack 16"
    And I should not see the text "Violet 15"
    And I press "Reset"
  #Search with Start Date only
  When I fill in "Issue Date Start" with "2022-08-22"
    And I press "Apply"
  Then I should not see the text "Andrew 1"
    And I should see the text "Brent 2"
    And I should not see the text "David 154"
    And I should not see the text "Nanci 14"
    And I should not see the text "Yolanda 25"
    And I should not see the text "Yolanda 15"
    And I should not see the text "Zack 16"
    And I should not see the text "Violet 15"
    And I press "Reset"
  #Search with End Date only
  When I fill in "Issue Date End" with "2021-01-02"
    And I press "Apply"
  Then I should see the text "Andrew 1"
    And I should not see the text "Brent 2"
    And I should not see the text "David 154"
    And I should not see the text "Nanci 14"
    And I should not see the text "Yolanda 25"
    And I should not see the text "Yolanda 15"
    And I should not see the text "Zack 16"
    And I should not see the text "Violet 15"

@api @javascript
Scenario: Validate Filters on Regulatory Releases Admin Page
  Given I am logged in as a user with the "Content Creator" role
  When "rulemaking_index" terms:
    | name     |
    | ui-98-po |
    | 34-12345 |
    | ab-12-cd |
    And "regulation" content:
      | title      | body         | field_rule_type     | field_release_number | field_release_file_number | moderation_state | field_publish_date | status |
      | Andrew   1 | detail body1 | Proposed            | ui-98-po             | ui-98-po                  | published        | 01-01-2021         | 1      |
      | Brent    2 | detail body1 | Interim Final Rules | ui-98-po             | ui-98-po                  | published        | -1 days            | 1      |
      | David  154 | detail body1 | Proposed            | 34-12345             | 34-12345                  | published        | -30 days           | 0      |
      | Nanci   14 | detail body1 | Interpretive        | 34-12345             | 34-12345                  | published        | -22 days           | 0      |
      | Yolanda 25 | detail body1 | Proposed            | 34-12345             | 34-12345                  | published        | -5 days            | 1      |
      | Yolanda 15 | detail body1 | Interpretive        | 34-12345             | 34-12345                  | published        | -5 days            | 1      |
      | Zack    16 | detail body1 | Proposed            | ab-12-cd             | ab-12-cd                  | published        | -80 days           | 1      |
      | Violet  15 | detail body1 | Proposed            | 34-12345             | 34-12345                  | published        | -31 days           | 1      |
    And I visit "/admin/content/rule-releases"
  Then I should see the text "Andrew 1"
    And I should see the text "Brent 2"
    And I should see the text "Zack 16"
    And I should see the text "Yolanda 25"
    And I should see the text "David 154"
    And I should see the text "Nanci 14"
  When I select "Proposed" from "edit-field-rule-type-target-id--level-0"
    And I press the "Apply" button
  Then I should see the text "Andrew 1"
    And I should see the text "Violet 15"
    And I should see the text "David 154"
    And I should not see the text "Brent 2"
    And I should not see the text "Nanci 14"
  When I select "Interim Final Rules" from "edit-field-rule-type-target-id--level-0"
    And I press the "Apply" button
  Then I should see the text "Brent 2"
    And I should not see the text "David 154"
    And I should not see the text "Violet 15"
    And I should not see the text "Andrew 1"
    And I should not see the text "Nanci 14"
  When I select "Interpretive" from "edit-field-rule-type-target-id--level-0"
    And I press the "Apply" button
  Then I should see the text "Yolanda 15"
    And I should see the text "Nanci 14"
    And I should not see the text "Violet 15"
    And I should not see the text "Brent 2"
   When I select "Yes" from "Published"
    And I press the "Apply" button
  Then I should not see the text "Andrew 1"
    And I should see the text "Yolanda 15"
    And I should not see the text "Violet 15"
    And I should not see the text "Brent 2"
    And I should not see the text "Nanci 14"
  When I select "- Please select -" from "edit-field-rule-type-target-id--level-0"
    And I press the "Apply" button
  Then I should see the text "Andrew 1"
    And I should see the text "Yolanda 15"
    And I should see the text "Violet 15"
    And I should see the text "Brent 2"
    And I should not see the text "Nanci 14"
  When I select "No" from "Published"
    And I press the "Apply" button
  Then I should see the text "Nanci 14"
    And I should see the text "David 154"
    And I should not see the text "Violet 15"
    And I should not see the text "Brent 2"
  When I select "-View All-" from "Published"
    And I select the first autocomplete option for "ui-98-po" on the "File Number" field
    And I press the "Apply" button
  Then I should see the text "Andrew 1"
    And I should see the text "Brent 2"
    And I should not see the text "David 154"
    And I should not see the text "Nanci 14"
  When I select the first autocomplete option for "ab-12-cd" on the "File Number" field
    And I press the "Apply" button
  Then I should see the text "Zack 16"
    And I should not see the text "Brent 2"
    And I should not see the text "David 154"
    And I should not see the text "Nanci 14"

@api @javascript
Scenario: Sorting Title on Regulatory Releases Admin Page
  Given I am logged in as a user with the "content_creator" role
  When "regulation" content:
    | title      | body         | field_rule_type | field_release_number | moderation_state | status |
    | Andrew   1 | detail body1 | Proposed        | Andrew 1             | published        | 1      |
    | Brent    2 | detail body1 | Proposed        | Brent 2              | published        | 1      |
    | Carl     3 | detail body1 | Proposed        | Carl 3               | published        | 1      |
    | David    4 | detail body1 | Proposed        | David 4              | published        | 1      |
    And I visit "/admin/content/rule-releases"
  When I click the sort filter "Title"
  Then "Andrew 1" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Brent 2" should precede "Carl 3" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Carl 3" should precede "David 4" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
  When I click the sort filter "Title"
  Then "David 4" should precede "Carl 3" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Carl 3" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Brent 2" should precede "Andrew 1" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"

@api @javascript
Scenario: Sorting Release File on Regulatory Releases Admin Page
  Given I am logged in as a user with the "content_creator" role
  When I create "media" of type "static_file":
    | name         | field_display_title | field_media_file        | field_description_abstract | field_link_text_override | status |
    | Behat file 1 | published media     | behat-file_data.pdf     | This is description abs    | Behat 1                  | 1      |
    | Behat file 2 | published media     | behat-file_invalert.pdf | This is description abs    |                          | 1      |
    | Behat file 3 | published media     | behat-file_test.pdf     | This is description abs    |                          | 1      |
    And "regulation" content:
      | title      | body         | field_rule_type     | moderation_state | status | field_release_file | field_release_number |
      | Andrew   1 | detail body1 | Interim Final Rules | published        | 1      | Behat file 1       | Andrew 1             |
      | Brent    2 | detail body1 | Interpretive        | published        | 1      | Behat file 2       | Brent 2              |
      | Carl     3 | detail body1 | Proposed            | published        | 1      | Behat file 3       | Carl 3               |
    And I visit "/admin/content/rule-releases"
    And I click the sort filter "Release File"
  Then "Andrew 1" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Brent 2" should precede "Carl 3" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
  When I click the sort filter "Release File"
  Then "Carl 3" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Brent 2" should precede "Andrew 1" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"

@api @javascript
Scenario: Sorting Updated date on Regulatory Releases Admin Page
  Given I am logged in as a user with the "content_creator" role
  When "regulation" content:
    | title      | body         | field_rule_type | field_release_number | moderation_state | status | changed   |
    | Andrew   1 | detail body1 | Proposed        | Andrew 1             | published        | 1      | -1 days   |
    | Brent    2 | detail body1 | Proposed        | Brent 2              | published        | 1      | -14 days  |
    | Carl     3 | detail body1 | Proposed        | Carl 3               | published        | 1      | -30 days  |
    | David    4 | detail body1 | Proposed        | David 4              | published        | 1      | -222 days |
    And I visit "/admin/content/rule-releases"
  #Default Sorting is by Updated date with latest at the top - Descending order
  Then "Andrew 1" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Brent 2" should precede "Carl 3" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Carl 3" should precede "David 4" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
  #Sorting by Update date with oldest at the top - Ascending order
  When I click the sort filter "Updated"
  Then "David 4" should precede "Carl 3" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Carl 3" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Brent 2" should precede "Andrew 1" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"

@api @javascript
Scenario: Sorting Issue Date on Regulatory Releases Admin Page
  Given I am logged in as a user with the "content_creator" role
  When "regulation" content:
    | title      | body         | field_rule_type | field_release_number | moderation_state | status | field_publish_date | changed   |
    | Andrew   1 | detail body1 | Proposed        | Andrew 1             | published        | 1      | -1 days            | -30 days  |
    | Brent    2 | detail body1 | Proposed        | Brent 2              | published        | 1      | -14 days           | -222 days |
    | Carl     3 | detail body1 | Proposed        | Carl 3               | published        | 1      | -30 days           | -1 days   |
    | David    4 | detail body1 | Proposed        | David 4              | published        | 1      | -222 days          | -14 days  |
    And I visit "/admin/content/rule-releases"
  #Sorting Issue date with oldest at the top - Ascending order
    And I click the sort filter "Issue Date"
  Then "David 4" should precede "Carl 3" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Carl 3" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Brent 2" should precede "Andrew 1" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
  #Sorting Issue date with newest at the top - Descending order
  When I click the sort filter "Issue Date"
  Then "Andrew 1" should precede "Brent 2" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Brent 2" should precede "Carl 3" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"
    And "Carl 3" should precede "David 4" for the query "//td[contains(@class, 'views-field views-field-field-release-number')]"

#TODO Parent Rule sorting
