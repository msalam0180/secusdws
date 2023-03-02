Feature: Create Taxonomies In SEC.gov
As an admin, I want to add new taxonomies on drupal 9 home page

@api
Scenario: SEC Default Taxonomies
  Given I am logged in as a user with the "sitebuilder" role
  When I am on "/admin/structure/taxonomy"
  Then I should see the link "Add vocabulary"
    And I should see the text "Article Type"
    And I should see the text "Release Type"
    And I should see the text "Division/Office"
    And I should see the text "Target"
    And I should see the text "Regulation"
    And I should see the text "Page Type"
    And I should see the text "Position Category"
  When I click on the element with css selector "#block-adminimal-theme-local-actions > ul > li > a"
  Then I should be on "/admin/structure/taxonomy/add"

@api @javascript
Scenario: Create and Delete New Taxonomy Terms On SEC.gov
  Given I am logged in as a user with the "sitebuilder" role
  When I am on "/admin/structure/taxonomy/add"
    And I fill in "Name" with "BEHAT Taxonomy"
    And I wait 1 seconds
    And I press "Save"
  When I am on "/admin/structure/taxonomy/manage/behat_taxonomy/add"
    And I fill in "Name" with "New Taxonomy Term"
    And I press "Save"
  When I am on "/admin/structure/taxonomy"
  Then I should see the text "BEHAT Taxonomy"
  When I am on "/admin/structure/taxonomy/manage/behat_taxonomy/overview"
    And I click "Edit" in the "New Taxonomy Term" row
    And I click "edit-delete"
    And I press "edit-submit"
  Then I am on "/admin/structure/taxonomy/manage/behat_taxonomy/overview"
    And I should not see "New Taxonomy Term"
  When I am on "/admin/structure/taxonomy/manage/behat_taxonomy?destination=/admin/structure/taxonomy"
    And I click "edit-delete"
    And I press "edit-submit"
  Then I am on "/admin/structure/taxonomy"
    And I should not see "BEHAT Taxonomy"

@api @javascript
Scenario: Validate File Number Taxonomy Term Fields
  Given I am logged in as a user with the "sitebuilder" role
  When I am on "/admin/structure/taxonomy/manage/rulemaking_index/add"
    And I fill in "File Number" with "34-6666"
    And I select "Open" from "Status"
    And I fill in "Rulemaking" with "Behat Rule"
    And I fill in "Respondents/Subject" with "Behat Tax term"
    And I press "Save"
    And I should see the text "Created new term 34-6666."
  Then I click "34-6666"
    And I should see the heading "Administrative Proceeding File No. 34-6666"
  When I am on "/litigation/apdocuments/ap-open-fileno-asc"
  Then I should see the link "34-6666"
  When I am on "/litigation/apdocuments/34-6666/edit"
    And I wait 2 seconds
    And I click "edit-delete"
    And I press "Delete"
  Then I should see the text "Deleted term 34-6666."
  When I am on "/litigation/apdocuments/ap-open-fileno-asc"
  Then I should not see "34-6666"

@api @javascript
Scenario: Validate Release Are Showing On File Number Taxonomy Detail Page
  Given "rulemaking_index" terms:
    | name     | field_respondents | status | field_ap_status | field_rulemaking |
    | ui-98-po | Anthony           | 1      | Open            | BehatRule1       |
    | ab-12-cd | Mary              | 1      | Close           | BehatRule2       |
    And I create "media" of type "static_file":
    | name                     | field_display_title | field_media_file        | field_description_abstract | field_link_text_override | status |
    | Behat live static file 1 | published media     | behat-file_data.pdf     | Static Release file1       | Behat 1                  | 1      |
    | Behat live static file 2 | published media     | behat-file_invalert.pdf | Static Release file2       |                          | 1      |
    And "release" content:
    | title    | body         | field_release_type         | field_release_number | field_respondents | moderation_state | field_publish_date | field_release_file_number | status | field_release_file       |
    | Andrew 1 | detail body1 | Trading Suspensions        | ab-12-cd             | Andrew            | published        | 01-01-2021         | ab-12-cd                  | 1      |                          |
    | Brent 2  | detail body1 | Trading Suspensions        | ui-98-po             | Brent             | published        | 01-11-2022         | ui-98-po                  | 1      |                          |
    | David 4  | detail body1 | Administrative Proceedings | ui-98-po             | David             | published        | -1 days            | ui-98-po                  | 0      |                          |
    | Eric 5   | detail body1 | Administrative Proceedings | ui-98-po             | Eric              | published        | 01-08-2019         | ui-98-po                  | 1      | Behat live static file 1 |
    | Frank 6  | detail body1 | Administrative Proceedings | ui-98-po             | Frank             | published        | -13 days           | ui-98-po                  | 0      |                          |
    And I am logged in as a user with the "authenticated" role
  When I am on "/litigation/apdocuments/ui-98-po"
  Then I should see the heading "Administrative Proceeding File No. ui-98-po"
    And I should see the text "Anthony" in the "file_num_respondent" region
    And I should see the text "Brent 2" in the "Nov. 1, 2022" row
    And I should see the text "Static Release file1" in the "Aug. 1, 2019" row
    And I should not see "Andrew 1"
    And I should not see "Frank 6"
    And I should not see "David 4"
  When I click "Brent 2" in the "file_num_documents" region
  Then I should be on "/litigation/suspensions/brent-2"
  When I am on "/litigation/apdocuments/ui-98-po"
    And I click "Static Release file1" in the "file_num_documents" region
  Then I should be on "/files/behat-file_data.pdf"
  When I am logged in as a user with the "Content Creator" role
    And I am on "/litigation/admin/eric-5/edit"
    And I press "edit-field-release-file-entities-0-actions-ief-entity-remove"
    And I press "ief-remove-confirm-field_release_file-form-0"
    And I press "Save"
  Then I am on "/litigation/apdocuments/ui-98-po"
    And I should see the text "Eric 5" in the "Aug. 1, 2019" row
    And I should not see the text "Static Release file1" in the "Aug. 1, 2019" row
  When I click "Eric 5" in the "file_num_documents" region
  Then I should be on "/litigation/admin/eric-5"
  When I am on "/litigation/admin/eric-5/edit"
    And I press "ief-field_release_file_number-form-entity-remove-0"
    And I press "Remove"
    And I press "Save"
  Then I am on "/litigation/apdocuments/ui-98-po"
    And I should not see "Eric 5"

@api @javascript
  Scenario: Validate Nesting of SRO Orgnization Taxonomy Terms
    Given "sro_organization_category" terms:
        | name                      | status |
        | Behat Parent SRO Category | 1      |
      And "rulemaking_index" terms:
        | name     	 |
        | 77-SRO-987 |
    When I am logged in as a user with the "sitebuilder" role
      And I visit "/admin/structure/taxonomy/manage/sro_organization_category/add"
      And I fill in "Name" with "Behat Child SRO Category"
      And I press "Relations"
      And I select "Behat Parent SRO Category" from "Parent terms"
      And I press "Save"
    Then I should see the text "Created new term Behat Child SRO Category."
    When I visit "/admin/structure/taxonomy/manage/sro_organization/add"
      And I fill in "Name" with "Behat SRO Organization"
      And I fill in "Short Name" with "behatSROOrg"
      And I select "Behat Parent SRO Category" from "edit-field-category-0-target-id--level-0"
      And I select "Behat Child SRO Category" from "edit-field-category-0-target-id--level-1"
      And I press "Save"
#cannot validate nesting of organization in node as this needs further work/bug fixes
