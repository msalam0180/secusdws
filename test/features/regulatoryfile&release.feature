Feature: Regulatory File and Regulatory Release Content Type
  As a Content Creator
  I want to be able to create and edit Regulatory Rule content
  So that visitors to SEC.gov can learn more about the rules and rule releases (regulations) at secgov

  Background:
    Given "rulemaking_index" terms:
        | name     	 | status | field_ap_status |
        | ui-98-po 	 | 1      | Open            |
        | bi-99-po 	 | 1      | Open            |
        | ab-pl-12 	 | 1      | Open            |
		    | 77-SRO-987 | 1      | Open            |
        | 66-SRO-456 | 1      | Open            |
      And "division_office" terms:
        | name     |
        | office 1 |
        | office 2 |
        | office 3 |
      And "rule_type" terms:
        | name       |
        | behat rule |
        | Rule 1     |
        | Rule 2     |
        | Rule 3     |
      And "rulemaking_index" terms:
        | name   |
        | 11-123 |

  @api @javascript
  Scenario Outline: Create and View Regulatory File-Regulatory Release Content Type
    Given I am logged in as a user with the "<role>" role
      And I create "media" of type "static_file":
        | name                     | status | field_display_title | field_media_file |
        | Behat live static file 1 | 1      | behat f1            | behat-file.pdf   |
        | Behat live static file 2 | 1      | behat f2            | behat-file.pdf   |
        | Behat live static file 3 | 1      | behat f3            | behat-file.pdf   |
    When I am on "/node/add/rule"
    Then I should see the heading "Create Regulatory Files"
    #Creating a Rule
    When I fill in "Title" with "Behat Rule-Regulation 1"
      And I fill in "Display Title" with "Display Title"
      And I press "Add existing File Number"
      And I wait for ajax to finish
      And I select the first autocomplete option for "ui-98-po" on the "File Number" field
      And I press "Add File Number"
      And I type "This is an Overview of this Rule-Regulation" in the "Overview" WYSIWYG editor
      And I press "Add new Regulatory Release"
      And I fill in "field_related_rule[form][0][title][0][value]" with "Rule Release Title"
      And I fill in "field_related_rule[form][0][field_display_title][0][value]" with "Rule Release Display Title"
      And I select the first autocomplete option for "behat rule" on the "Rule Type" field
      And I fill in "Release Number (value 1)" with "xxx-abc"
      And I press "field_related_rule_form_0_field_release_number_add_more"
      And I fill in "Release Number (value 2)" with "yyy-abc"
      And I press "Add existing Release File"
      And I wait for ajax to finish
      And I select the first autocomplete option for "Behat live static file 1" on the "field_related_rule[form][0][field_release_file][form][0][entity_id]" field
      And I press "Add Release File"
      And I fill in "field_related_rule[form][0][field_publish_date][0][value][date]" with "01-01-2021"
      And I fill in "RIN" with "3325-0365"
      And I fill in "Document Citation" with "This Rule-Regulation citation is 87 FR 51812"
      And I press "Add existing Reference"
      And I wait for ajax to finish
      And I select the first autocomplete option for "Behat live static file 2" on the "field_related_rule[form][0][field_see_also][form][0][entity_id]" field
      And I press "Add Reference"
      And I press "Add existing Reference"
      And I wait for ajax to finish
      And I select the first autocomplete option for "Behat live static file 3" on the "field_related_rule[form][0][field_see_also][form][1][entity_id]" field
      And I fill in "field_related_rule[form][0][field_federal_register_publish_d][0][value][date]" with "04-22-2022"
      And I fill in "Federal Register Version" with "http://example.com"
      And I check the box "Conformed to Federal Register Version"
      And I type "Effective field" in the "Effective Date" WYSIWYG editor
      And I type "Compliance field" in the "Compliance Date" WYSIWYG editor
      And I type "Applicability field" in the "Applicability Date" WYSIWYG editor
      And I type "These are notes about this rule release" in the "Notes" WYSIWYG editor
      And I press "Create Regulatory Release"
      And I select the first autocomplete option for "office 1" on the "field_primary_division_office[0][target_id]" field
      And I press "edit-field-primary-division-office-add-more"
      And I select the first autocomplete option for "office 2" on the "field_primary_division_office[1][target_id]" field
      And I select the first autocomplete option for "Compliance - Investment Companies" on the "field_related_topics[0][target_id]" field
      And I press "edit-field-related-topics-add-more"
      And I select the first autocomplete option for "Business Development Companies" on the "field_related_topics[1][target_id]" field
      And I press "Save"
    #Viewing Rule as a site visitor
    When I am not logged in
      And I am on "/rules/2021/01/behat-rule-regulation-1"
    Then I should see the text "behat rule Rule" in the "rule_type_header" region
      And I should see the heading "Display Title"
      And I should not see the text "Behat Rule-Regulation 1"
      And I should see the text "Compliance - Investment Companies"
      And I should see the text "Business Development Companies"
      And I should see the text "Overview"
      And I should see the text "This is an Overview of this Rule-Regulation"
      And I should see the text "Details"
      And I should see the text "File Number"
      And I should see the link "ui-98-po"
      And I should see the text "Rule Type"
      And I should see the text "behat rule" in the "rule_view_detail" region
      And I should see the text "Release Number"
      And I should see the text "xxx-abc"
      And I should see the text "yyy-abc"
      And I should see the text "SEC Issue Date"
      And I should see the text "Jan. 1, 2021"
      And I should see the text "Effective Date"
      And I should see the text "Effective field"
      And I should see the text "Compliance Date"
      And I should see the text "Compliance field"
      And I should see the text "Applicability Date"
      And I should see the text "Applicability field"
      And I should see the text "Federal Register Publish Date"
      And I should see the text "April 22, 2022"
      And I should see the text "Document Citation"
      And I should see the text "This Rule-Regulation citation is 87 FR 51812"
      And I should see the text "RIN"
      And I should see the text "3325-0365"
      And I should see the text "Resources"
      And I should see the link "SEC Issued behat rule"
      And I should see the link "Federal Register Version"
      And I should see the link "Behat live static file 2"
      And I should see the link "Behat live static file 3"
    #Hidden fields
      And I should not see the text "office 1"
      And I should not see the text "office 2"

    Examples:
      | role             |
      | content_creator  |
      | content_approver |
      | sitebuilder      |

  @api @javascript
  Scenario: Add existing Regulatory Release to Regulatory File Content
    Given I am logged in as a user with the "content_creator" role
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date | moderation_state |
        | Rule Release A | Rule 3          | xxx-ghi              | 2021-01-01         | published        |
      And "rule" content:
        | title  | field_display_title | body | field_primary_division_office | moderation_state | field_file_number |
        | Rule A | R1 Parent           | bod3 | office 1                      | published        | 11-123            |
    When I am on "/rules/rule-a/edit"
      And I press "Add existing Regulatory Release"
      And I select the first autocomplete option for "Rule Release A" on the "Regulatory Release" field
      And I press "Add Regulatory Release"
      And I press "Save"
    #Viewing Rule as a site visitor
    When I am not logged in
      And I am on "/rules/rule-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Rule 3" in the "rule_view_detail" region
      And I should see the text "xxx-ghi" in the "rule_view_detail" region
      And I should see the text "Jan. 1, 2021" in the "rule_view_detail" region

  @api
  Scenario: Add New File Number For Regulatory File Content
    Given I am logged in as a user with the "content_creator" role
      And I create "media" of type "static_file":
        | name         | status |
        | Behat file 3 | 1      |
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date | moderation_state |
        | Rule Release A | Rule 3          | xxx-ghi              | 2021-01-01         | published        |
      And "rule" content:
        | title  | field_display_title | body | field_primary_division_office | moderation_state | field_related_rule |
        | Rule A | R1 Parent           | bod3 | office 1                      | published        | Rule Release A     |
    When I am on "/rules/2021/01/rule-a/edit"
      And I press "Add new File Number"
      And I fill in "Name" with "ZZ-95-P00"
      And I select "Open" from "Status"
      And I fill in "Respondents/Subject" with "There is always only a single File Number per rule that applies to all rule releases"
      And I press "Create File Number"
      And I press "Save"
    #Viewing Rule as a site visitor
    When I am not logged in
      And I am on "/rules/2021/01/rule-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Details"
      And I should see the text "File Number"
      And I should see the link "ZZ-95-P00"
      And I should see the text "Rule Type"
      And I should see the text "Rule 3"
      And I should see the text "Release Number"
      And I should see the text "xxx-ghi"
      And I should see the text "SEC Issue Date"
      And I should see the text "Jan. 1, 2021"
      And I should see the text "Federal Register Publish Date"

  @api
  Scenario: Add New Release File For Regulaotry Release Content
    Given I am logged in as a user with the "sitebuilder" role
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date | moderation_state |
        | Rule Release A | Rule 3          | xxx-ghi              | 2021-01-01         | published        |
      And "rule" content:
        | title  | field_display_title | body | field_primary_division_office | moderation_state | field_related_rule | field_file_number |
        | Rule A | R1 Parent           | bod3 | office 1                      | published        | Rule Release A     | 11-123            |
    When I am on "/rules/2021/01/rule-a/edit"
      And I click on the element with css selector "#edit-field-related-rule-entities-0-actions-ief-entity-edit"
      And I press "Add new Release File"
      And I fill in "Name" with "Behat Rule-Regulation Release File"
      And I fill in "field_related_rule[form][inline_entity_form][entities][0][form][field_release_file][form][0][field_display_title][0][value]" with "RF Display Title"
      And I attach the file "behat-file_data.pdf" to "File Upload"
      And I select "office 1" from "Primary Division/Office"
      And I check the box "Published"
      And I press "Create Release File"
      And I press "Update Regulatory Release"
      And I press "Save"
    #Viewing Rule as a site visitor
    When I am not logged in
      And I am on "/rules/2021/01/rule-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Details"
      And I should see the text "Rule Type"
      And I should see the text "Rule 3"
      And I should see the text "Release Number"
      And I should see the text "xxx-ghi"
      And I should see the text "SEC Issue Date"
      And I should see the text "Jan. 1, 2021"
      And I should see the text "Federal Register Publish Date"
      And I should see the text "Resources"
      And I should see the link "SEC Issued Rule 3"

  @api @javascript
  Scenario Outline: Site Visitor Can See All Rule Types For Regulatory Release Content
    Given I am not logged in
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date | moderation_state |
        | Rule Release A | <rule_type>     | xxx-ghi              | 2021-01-01         | published        |
      And "rule" content:
        | title  | field_display_title | body | field_primary_division_office | moderation_state | field_related_rule |
        | Rule A | R1 Parent           | bod3 | office 1                      | published        | Rule Release A     |
    When I am on "/rules/2021/01/rule-a"
    Then I should see the text "<rule_type>" in the "rule_type_header" region
      And I should see the heading "R1 Parent"

    Examples:
      | rule_type    |
      | Proposed     |
      | Final        |
      | Concept      |
      | Interpretive |

  @api
  Scenario: Linking Single Regulaotry Release to Regulaotry File Types
    Given I create "media" of type "static_file":
        | name         | status |
        | Behat file 3 | 1      |
      And "topics" terms:
        | name   |
        | topic1 |
      And "regulation" content:
        | title          | body | field_rule_type | field_release_number | field_publish_date | field_federal_register_publish_d | field_primary_division_office | moderation_state | field_applicability_date | field_document_citation | field_effective_date | field_rin | field_release_file | field_see_also |
        | Rule Release A | bod3 | Rule 3          | xxx-ghi              | 2021-01-01         | 2021-01-30                       | office 1                      | published        | App date a               | doc 3                   | eff a1               | r7        | behat file 3       | behat file 3   |
      And "rule" content:
        | title  | field_display_title | body | field_primary_division_office | field_related_topics | moderation_state | field_related_rule | field_file_number |
        | Rule A | R1 Parent           | bod3 | office 1                      | topic1               | published        | Rule Release A     | ab-pl-12          |
    When I am on "/rules/2021/01/rule-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Details" in the "rule_view_detail" region
      And I should see the text "Rule 3" in the "rule_view_detail" region
      And I should see the text "xxx-ghi" in the "rule_view_detail" region
      And I should see the text "Jan. 1, 2021" in the "rule_view_detail" region
      And I should see the text "eff a1" in the "rule_view_detail" region
      And I should see the text "App date a" in the "rule_view_detail" region
      And I should see the text "Jan. 30, 2021" in the "rule_view_detail" region
      And I should see the text "doc 3" in the "rule_view_detail" region
      And I should see the text "r7" in the "rule_view_detail" region
      And I should see the text "Resources" in the "rule_view_detail" region
      And I should see the link "Behat file 3" in the "rule_view_detail" region

  @api @javascript
  Scenario: Changing Order of Regulatory Release to Rule Types
    Given I am logged in as a user with the "Content Creator" role
      And I create "media" of type "static_file":
        | name         | status |
        | Behat file 1 | 1      |
        | Behat file 3 | 1      |
      And "topics" terms:
        | name   |
        | topic1 |
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date | field_federal_register_publish_d | field_primary_division_office | moderation_state | field_applicability_date | field_document_citation | field_effective_date | field_rin | field_release_file | field_see_also |
        | Rule Release B | Rule 1          | xxx-abc              | 2020-05-25         | 2021-05-25                       | office 2                      | published        | App date b               | doc 1                   | eff b2               | r5        | behat file 1       | behat file 1   |
        | Rule Release A | Rule 3          | xxx-ghi              | 2021-01-01         | 2021-01-30                       | office 1                      | published        | App date a               | doc 3                   | eff a1               | r7        | behat file 3       | behat file 3   |
      And "rule" content:
        | title  | field_display_title | body | field_primary_division_office | field_related_topics | moderation_state | field_related_rule             | field_file_number |
        | Rule A | R1 Parent           | bod3 | office 1                      | topic1               | published        | Rule Release A, Rule Release B | ui-98-po          |
    When I am on "/rules/2021/01/rule-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Details" in the "rule_view_detail" region
      And I should see the link "ui-98-po" in the "rule_view_detail" region
      And I should see the text "Rule 3" in the "rule_view_detail" region
      And I should see the text "xxx-ghi" in the "rule_view_detail" region
      And I should see the text "Jan. 1, 2021" in the "rule_view_detail" region
      And I should see the text "eff a1" in the "rule_view_detail" region
      And I should see the text "App date a" in the "rule_view_detail" region
      And I should see the text "Jan. 30, 2021" in the "rule_view_detail" region
      And I should see the text "doc 3" in the "rule_view_detail" region
      And I should see the text "r7" in the "rule_view_detail" region
      And I should see the text "Resources" in the "rule_view_detail" region
      And I should see the link "Behat file 3" in the "rule_view_detail" region
      And I should see the link "Rule 1 Rule (xxx-abc)"
      And I click "Rule 1 Rule (xxx-abc)"
      And I should see the text "May 25, 2020" in the "rule_detail_accordion_1" region
      And I should see the text "May 25, 2021" in the "rule_detail_accordion_1" region
      And I should see the text "doc 1" in the "rule_detail_accordion_1" region
      And I should see the text "r5" in the "rule_detail_accordion_1" region
      And I should see the text "Resources" in the "rule_detail_accordion_1" region
      And I should see the link "Behat file 1" in the "rule_detail_accordion_1" region
    When I am on "/rules/2021/01/rule-a/edit"
      And I press "Show row weights"
      And I select "-1" from "field_related_rule[entities][1][delta]"
      And I press "Save"
    Then I should see the text "Details" in the "rule_view_detail"
      And I should see the link "ui-98-po" in the "rule_view_detail" region
      And I should see the text "Rule 1" in the "rule_view_detail" region
      And I should see the text "xxx-abc" in the "rule_view_detail" region
      And I should see the text "May 25, 2020" in the "rule_view_detail" region
      And I should see the text "eff b2" in the "rule_view_detail" region
      And I should see the text "App date b" in the "rule_view_detail" region
      And I should see the text "May 25, 2021" in the "rule_view_detail" region
      And I should see the text "doc 1" in the "rule_view_detail" region
      And I should see the text "r5" in the "rule_view_detail" region
      And I should see the text "Resources" in the "rule_view_detail" region
      And I should see the link "Behat file 1" in the "rule_view_detail" region
      And I should see the link "Rule 3 Rule (xxx-ghi)"
      And I click "Rule 3 Rule (xxx-ghi)"
      And I should see the text "Jan. 1, 2021" in the "rule_detail_accordion_1" region
      And I should see the text "Jan. 30, 2021" in the "rule_detail_accordion_1" region
      And I should see the text "doc 3" in the "rule_detail_accordion_1" region
      And I should see the text "r7" in the "rule_detail_accordion_1" region
      And I should see the text "Resources" in the "rule_detail_accordion_1" region
      And I should see the link "Behat file 3" in the "rule_detail_accordion_1" region
    When I am on "/rules/2021/01/rule-a/edit"
      And I press "Hide row weights"
      And I press "Save"

  @api @javascript
  Scenario: Linking Multiple Regulatory Releases to Single Regulatory File
    Given I am logged in as a user with the "Content Creator" role
      And I create "media" of type "static_file":
        | name         | status |
        | Behat file 1 | 1      |
        | Behat file 2 | 1      |
        | Behat file 3 | 1      |
      And "topics" terms:
        | name   |
        | topic1 |
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date | field_federal_register_publish_d | field_federal_register_version      | field_conformed_to_federal_regis | field_primary_division_office | moderation_state | field_applicability_date | field_document_citation | field_effective_date | field_rin | field_release_file | field_see_also | field_notes |
        | Rule Release B | Rule 1          | xxx-abc              | 2020-05-25         | 2021-05-25                       | Go To SEC.gov - https://www.sec.gov | 1                                | office 2                      | published        |                          | doc 1                   |                      | r5        | behat file 1       | behat file 1   | Note 1a     |
        | Rule Release C | Rule 2          | xxx-def              | 2019-02-14         | 2021-02-14                       | Go To SEC.gov - https://www.sec.gov | 1                                | office 3                      | published        |                          | doc 2                   |                      | r6        | behat file 2       | behat file 2   | Note 2b     |
        | Rule Release A | Rule 3          | xxx-ghi              | 2021-01-01         | 2021-01-30                       | Go To SEC.gov - https://www.sec.gov | 1                                | office 1                      | published        | App date a               | doc 3                   | eff a1               | r7        | behat file 3       | behat file 3   | Note 3c     |
      And "rule" content:
        | title         | field_display_title | body | field_primary_division_office | field_related_topics | moderation_state | field_related_rule                             | field_file_number |
        | Rule Parent A | R1 Parent           | bod3 | office 1                      | topic1               | published        | Rule Release A, Rule Release B, Rule Release C | ui-98-po          |
    When I am on "/rules/2021/01/rule-parent-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Details" in the "rule_view_detail" region
      And I should see the link "ui-98-po" in the "rule_view_detail" region
      And I should see the text "Rule 3" in the "rule_view_detail" region
      And I should see the text "xxx-ghi" in the "rule_view_detail" region
      And I should see the text "Jan. 1, 2021" in the "rule_view_detail" region
      And I should see the text "eff a1" in the "rule_view_detail" region
      And I should see the text "App date a" in the "rule_view_detail" region
      And I should see the text "Jan. 30, 2021" in the "rule_view_detail" region
      And I should see the text "doc 3" in the "rule_view_detail" region
      And I should see the text "r7" in the "rule_view_detail" region
      And I should see the text "Note 3c" in the "rule_view_detail" region
      And I should see the text "Resources" in the "rule_view_detail" region
      And I should see the link "Behat file 3" in the "rule_view_detail" region
      And I should see the link "Rule 1 Rule (xxx-abc)"
      And I should not see the text "May 25, 2020"
      And I click "Rule 1 Rule (xxx-abc)"
      And I should see the text "May 25, 2020" in the "rule_detail_accordion_1" region
      And I should see the text "May 25, 2021" in the "rule_detail_accordion_1" region
      And I should see the text "doc 1" in the "rule_detail_accordion_1" region
      And I should see the text "r5" in the "rule_detail_accordion_1" region
      And I should see the text "Note 1a" in the "rule_detail_accordion_1" region
      And I should see the text "Resources" in the "rule_detail_accordion_1" region
      And I should see the link "Behat file 1" in the "rule_detail_accordion_1" region
      And I should see the link "Rule 2 Rule (xxx-def)"
      And I should not see the text "r6"
      And I click "Rule 2 Rule (xxx-def)"
      And I should see the text "Feb. 14, 2019" in the "rule_detail_accordion_2" region
      And I should see the text "Feb. 14, 2021" in the "rule_detail_accordion_2" region
      And I should see the text "doc 2" in the "rule_detail_accordion_2" region
      And I should see the text "r6" in the "rule_detail_accordion_2" region
      And I should see the text "Note 2b" in the "rule_detail_accordion_2" region
      And I should see the text "Resources" in the "rule_detail_accordion_2" region
      And I should see the link "Behat file 2" in the "rule_detail_accordion_2" region

  @api @javascript
  Scenario: Adding and Viewing Comments with Due Date Format of Date
    Given I am logged in as a user with the "sitebuilder" role
      And I create "media" of type "static_file":
        | name         | status |
        | Behat file 3 | 1      |
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date | moderation_state |
        | Rule Release A | Rule 3          | xxx-ghi              | 2021-01-01         | published        |
      And "rule" content:
        | title  | field_display_title | body | field_primary_division_office | moderation_state | field_related_rule | field_file_number |
        | Rule A | R1 Parent           | bod3 | office 1                      | published        | Rule Release A     | ui-98-po          |
    When I am on "/rules/2021/01/rule-a/edit"
      And I select "Date" from "Comments Due Date Format"
      And I fill in "10/25/2050" for "field_comments_due_date[0][value][date]"
      And I select the first autocomplete option for "Feedback Flier" on the "Submit Comments" field
      And I check the box "Show Submit Comments Button"
      And I select the first autocomplete option for "Reports and Publications" on the "field_comments_received[0][uri]" field
      And I check the box "Show Comments Received Button"
      And I press "Save"
    #Viewing Rule as a site visitor
    When I am not logged in
      And I am on "/rules/2021/01/rule-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Public Comments" in the "rule_detail_view_comment" region
      And I should see the link "Submit A Comment" in the "rule_detail_view_comment" region
      And I should see the link "View Received Comments" in the "rule_detail_view_comment" region
      And I should see the text "Details"
      And I should see the text "File Number"
      And I should see the link "ui-98-po"
      And I should see the text "Release Number"
      And I should see the text "SEC Issue Date"
      And I should see the text "Jan. 1, 2021"
      And I should see the text "Federal Register Publish Date"

@api @javascript
  Scenario: Adding and Viewing Comments with Due Date Format of Text
    Given I am logged in as a user with the "sitebuilder" role
      And I create "media" of type "static_file":
        | name         | status |
        | Behat file 3 | 1      |
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date | moderation_state |
        | Rule Release A | Rule 3          | xxx-ghi              | 2021-01-01         | published        |
      And "rule" content:
        | title  | field_display_title | body | field_primary_division_office | moderation_state | field_related_rule | field_file_number |
        | Rule A | R1 Parent           | bod3 | office 1                      | published        | Rule Release A     | ui-98-po          |
    When I am on "/rules/2021/01/rule-a/edit"
      And I select "Text" from "Comments Due Date Format"
      And I type "Due on October 25th, 2050" in the "Comments Due Text" WYSIWYG editor
      And I select the first autocomplete option for "Feedback Flier" on the "Submit Comments" field
      And I check the box "Show Submit Comments Button"
      And I select the first autocomplete option for "Reports and Publications" on the "field_comments_received[0][uri]" field
      And I check the box "Show Comments Received Button"
      And I press "Save"
    #Viewing Rule as a site visitor
    When I am not logged in
      And I am on "/rules/2021/01/rule-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Public Comments" in the "rule_detail_view_comment" region
      And I should see the link "Submit A Comment" in the "rule_detail_view_comment" region
      And I should see the link "View Received Comments" in the "rule_detail_view_comment" region
      And I should see the text "Details"
      And I should see the text "Public Comments Due"
      And I should see the text "Due on October 25th, 2050"
      And I should see the text "File Number"
      And I should see the link "ui-98-po"
      And I should see the text "Rule Type"
      And I should see the text "Rule 3"
      And I should see the text "Release Number"
      And I should see the text "xxx-ghi"
      And I should see the text "SEC Issue Date"
      And I should see the text "Jan. 1, 2021"
      And I should see the text "Federal Register Publish Date"

@api @javascript
  Scenario: Show or Hide Submit Comments and Comments Received buttons from Regulatory File Details Page
    Given I am logged in as a user with the "sitebuilder" role
      And I create "media" of type "static_file":
        | name         | status |
        | Behat file 3 | 1      |
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date  | moderation_state |
        | Rule Release A | Rule 3          | xxx-ghi              | 2021-01-01          | published        |
      And "rule" content:
        | title  | field_display_title | body | field_primary_division_office | moderation_state | field_related_rule | field_file_number |
        | Rule A | R1 Parent           | bod3 | office 1                      | published        | Rule Release A     | ui-98-po          |
    When I am on "/rules/2021/01/rule-a/edit"
      And I select "Text" from "Comments Due Date Format"
      And I type "Due on October 25th, 2050" in the "Comments Due Text" WYSIWYG editor
      And I select the first autocomplete option for "Feedback Flier" on the "Submit Comments" field
    #With both buttons showing
      And I check the box "Show Submit Comments Button"
      And I select the first autocomplete option for "Reports and Publications" on the "field_comments_received[0][uri]" field
      And I should not see the button "edit-field-comments-received-add-more"
      And I check the box "Show Comments Received Button"
      And I press "Save"
    #Viewing as site visitor
    When I am not logged in
      And I am on "/rules/2021/01/rule-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Public Comments" in the "rule_detail_view_comment" region
      And I should see the link "Submit A Comment" in the "rule_detail_view_comment" region
      And I should see the link "View Received Comments" in the "rule_detail_view_comment" region
    #With both buttons hidden
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/rules/2021/01/rule-a/edit"
      And I uncheck the box "Show Submit Comments Button"
      And I uncheck the box "Show Comments Received Button"
      And I press "Save"
    #Viewing as a site visitor
    When I am not logged in
      And I am on "/rules/2021/01/rule-a"
    Then I should see the heading "R1 Parent"
      And I should not see the text "Public Comments" in the "rule_detail_view_comment" region
      And I should not see the link "Submit A Comment" in the "rule_detail_view_comment" region
      And I should not see the link "View Received Comments" in the "rule_detail_view_comment" region
    #With Submit Comments button showing & Comments Received button hidden
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/rules/2021/01/rule-a/edit"
      And I check the box "Show Submit Comments Button"
      And I press "Save"
    #Viewing as a site visitor
    When I am not logged in
      And I am on "/rules/2021/01/rule-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Public Comments" in the "rule_detail_view_comment" region
      And I should see the link "Submit A Comment" in the "rule_detail_view_comment" region
      And I should not see the link "View Received Comments" in the "rule_detail_view_comment" region
    #With Submit Comments button hidden & Comments Received button showing
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/rules/2021/01/rule-a/edit"
      And I uncheck the box "Show Submit Comments Button"
      And I check the box "Show Comments Received Button"
      And I press "Save"
    #Viewing as a site visitor
    When I am not logged in
      And I am on "/rules/2021/01/rule-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Public Comments" in the "rule_detail_view_comment" region
      And I should not see the link "Submit A Comment" in the "rule_detail_view_comment" region
      And I should see the link "View Received Comments" in the "rule_detail_view_comment" region

@api @javascript
  Scenario: If the Final rule is ordered to top priority then submit comments button will be hidden automatically
    Given I am logged in as a user with the "Content Creator" role
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date | moderation_state |
        | Rule Release A | Proposed        | xxx-abc              | 2021-01-01         | published        |
        | Rule Release B | Final           | xxx-ghi              | 2021-01-01         | published        |
      And "rule" content:
        | title  | field_display_title | body                  | field_primary_division_office | moderation_state | field_related_rule             | field_file_number |
        | Rule A | R1 Parent           | This is rule overview | office 1                      | published        | Rule Release A, Rule Release B | ui-98-po          |
    When I am on "/rules/2021/01/rule-a/edit"
      And I select "Date" from "Comments Due Date Format"
      And I fill in "10/25/2050" for "field_comments_due_date[0][value][date]"
      And I select the first autocomplete option for "Feedback Flier" on the "Submit Comments" field
      And I check the box "Show Submit Comments Button"
      And I select the first autocomplete option for "Reports and Publications" on the "field_comments_received[0][uri]" field
      And I check the box "Show Comments Received Button"
      And I press "Save"
    #Viewing Rule as a site visitor with buttons still showing since Proposed rule is at top
    When I am not logged in
      And I am on "/rules/2021/01/rule-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Public Comments" in the "rule_detail_view_comment" region
      And I should see the link "Submit A Comment" in the "rule_detail_view_comment" region
      And I should see the link "View Received Comments" in the "rule_detail_view_comment" region
    When I am logged in as a user with the "Content Creator" role
      And I am on "/rules/2021/01/rule-a/edit"
      And I press "Show row weights" in the "rule_releases" region
      And I select "-1" from "field_related_rule[entities][1][delta]"
      And I press "Save"
    #Viewing Rule as a site visitor with submit comments button hidden since Final rule is at top
    When I am not logged in
      And I am on "/rules/2021/01/rule-a"
    Then I should see the heading "R1 Parent"
      And I should see the text "Public Comments" in the "rule_detail_view_comment" region
      And I should not see the link "Submit A Comment" in the "rule_detail_view_comment" region
      And I should see the link "View Received Comments" in the "rule_detail_view_comment" region

@api @javascript
  Scenario: Validate SRO Node Page With Single and Multiple SRO Rule Releases
    Given "sro_organization_category" terms:
        | name               | status |
        | Behat SRO Category | 1      |
      And "sro_organization" terms:
        | name                   | field_abbreviated |  status |
        | Behat SRO Organization | behatSROrg        | 1       |
      And "rule_type" terms:
        | name   |
        | Rule 1 |
        | Rule 2 |
      And "customized_comment_form" content:
        | title         | field_display_title | status | field_file_number | field_rule_path    | field_ruling |
        | Comment Form  | Display Title for 1 | 1      | ab-pl-12          | /comments/ab-pl-12 | ab-pl-12     |
      And I create "media" of type "static_file":
        | name         | field_display_title | field_media_file  | field_description_abstract | status |
        | Behat file 1 | published media     | behat-file.pdf    | This is description abs    | 1      |
        | Behat file 2 | published media     | behat-file.pdf    | This is description abs    | 1      |
        | Behat file 3 | published media     | behat-file.pdf    | This is description abs    | 1      |
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date  |field_federal_register_publish_d | moderation_state | field_applicability_date | field_document_citation | field_effective_date | field_rin | field_release_file | field_see_also | field_compliance_date | field_notes | field_conformed_to_federal_regis | field_federal_register_version      |
        | Rule Release B | Rule 1          | xxx-abc              | 2020-05-25          | 2021-05-25                      | published        | App date b               | doc 1                   | eff b2               | r5        | behat file 1       | behat file 2   | compt date            | behat Notes | 1                                | Go To SEC.gov - https://www.sec.gov |
        | Rule Release C | Rule 2          | xxx-def              | 2019-02-14          | 2021-02-14                      | published        | App date c               | doc 2                   | eff c3               | r6        | behat file 2       | behat file 1   | compt date2           | behat Notes | 1                                | Go To SEC.gov - https://www.sec.gov |
        | Rule Release A | Rule 2          | xxx-ghi              | 2021-01-01          | 2021-01-30                      | published        | App date a               | doc 3                   | eff a1               | r7        | behat file 3       | behat file 2   | compt date3           | behat Notes | 1                                | Go To SEC.gov - https://www.sec.gov |
      And "rule" content:
        | title         | field_display_title | body | field_sro_organization | field_primary_division_office | moderation_state | field_related_rule             | field_show_comments_received | field_show_submit_comments | field_submit_comments | field_comments_received             | field_file_number |
        | Rule Parent A | R1 Parent           | bod3 | Behat SRO Organization | office 1                      | published        | Rule Release A                 | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov | 77-SRO-987        |
        | Rule Parent B | R1 Parent           | bod3 | Behat SRO Organization | office 1                      | published        | Rule Release B, Rule Release C | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov | 66-SRO-456        |
    #single rule release - no accordion
    When I visit "/rules/sro/77-sro-987"
    Then I should see the heading "77-SRO-987"
      And I should see "RULE 2" in the "SRO_node_heading" region
      And I should see the link "Submit A Comment"
      And I should see the link "View Received Comments"
      And I should see the text "Overview"
      And I should see the text "Rule 2" in the "SRO_rule_detail" region
      And I should see the text "Release Number" in the "SRO_rule_detail" region
      And I should see the text "xxx-ghi" in the "SRO_rule_detail" region
      And I should see the text "SEC Issue Date" in the "SRO_rule_detail" region
      And I should see the text "Jan. 1, 2021" in the "SRO_rule_detail" region
      And I should see the text "Effective Date" in the "SRO_rule_detail" region
      And I should see the text "eff a1" in the "SRO_rule_detail" region
      And I should see the text "Compliance Date" in the "SRO_rule_detail" region
      And I should see the text "compt date3" in the "SRO_rule_detail" region
      And I should see the text "Applicability Date" in the "SRO_rule_detail" region
      And I should see the text "App date a" in the "SRO_rule_detail" region
      And I should see the text "Federal Register Publish Date" in the "SRO_rule_detail" region
      And I should see the text "Jan. 30, 2021" in the "SRO_rule_detail" region
      And I should see the text "Document Citation" in the "SRO_rule_detail" region
      And I should see the text "doc 3" in the "SRO_rule_detail" region
      And I should see the text "RIN" in the "SRO_rule_detail" region
      And I should see the text "r7" in the "SRO_rule_detail" region
      And I should see the text "Resources" in the "SRO_rule_detail" region
      And I should see the link "SEC Issued Rule 2" in the "SRO_rule_detail" region
      And I should see the link "Federal Register Version" in the "SRO_rule_detail" region
      And I should see the link "Behat file 2" in the "SRO_rule_detail" region
    #more than 1 release - accordion
    #accordion1
    When I visit "/rules/sro/66-SRO-456"
    Then I should see the heading "66-SRO-456"
      And I should see "RULE 1" in the "SRO_node_heading" region
      And I should see the link "Submit A Comment"
      And I should see the link "View Received Comments"
      And I should see the text "Overview"
      And I click "Rule 1 (xxx-abc)"
      And I should see the text "SEC Issue Date" in the "SRO_rule_accordion1_detail" region
      And I should see the text "May 25, 2020" in the "SRO_rule_accordion1_detail" region
      And I should see the text "Federal Register Publish Date" in the "SRO_rule_accordion1_detail" region
      And I should see the text "May 25, 2021" in the "SRO_rule_accordion1_detail" region
      And I should see the text "Document Citation" in the "SRO_rule_accordion1_detail" region
      And I should see the text "doc 1" in the "SRO_rule_accordion1_detail" region
      And I should see the text "r5" in the "SRO_rule_accordion1_detail" region
      And I should see the text "Notes" in the "SRO_rule_accordion1_detail" region
      And I should see the text "behat Notes" in the "SRO_rule_accordion1_detail" region
      And I should see the text "Resources" in the "SRO_rule_accordion1_detail" region
      #And I should see the link "SEC Issued Rule 1"
      #And I should see the link "behat file 2"
      #^bug here
      And I should see the link "Federal Register Version" in the "SRO_rule_accordion1_detail" region
    #accordion2
    Then I click "Rule 2 (xxx-def)"
      And I should see the text "SEC Issue Date" in the "SRO_rule_accordion2_detail" region
      And I should see the text "Feb. 14, 2019" in the "SRO_rule_accordion2_detail" region
      And I should see the text "Federal Register Publish Date" in the "SRO_rule_accordion2_detail" region
      And I should see the text "Feb. 14, 2021" in the "SRO_rule_accordion2_detail" region
      And I should see the text "Document Citation" in the "SRO_rule_accordion2_detail" region
      And I should see the text "doc 2" in the "SRO_rule_accordion2_detail" region
      And I should see the text "r6" in the "SRO_rule_accordion2_detail" region
      And I should see the text "Notes" in the "SRO_rule_accordion2_detail" region
      And I should see the text "behat Notes" in the "SRO_rule_accordion2_detail" region
      And I should see the text "Resources" in the "SRO_rule_accordion2_detail" region
      #And I should see the link "SEC Issued Rule 1"
      #And I should see the link "behat file 2"
      #^bug here
      And I should see the link "Federal Register Version" in the "SRO_rule_accordion2_detail" region
      #^we will most likely not have SRO node page. This scenario will continue to fail since the bugs arent fixed. Might need to be deleted in the

@api @javascript
  Scenario: Validate Comments Due Date and Comments Received Link Text on Rule Node Page and List Page
    Given "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date | moderation_state |
        | Rule Release A | Other        | xxx-abc              | 2021-01-01         | published        |
      And "rule" content:
        | title  | field_display_title | body                  | field_primary_division_office | moderation_state | field_related_rule | field_file_number | field_show_comments_received | status | field_comments_date_format | field_comments_due_date |
        | Rule A | R1 Parent           | This is rule overview | office 1                      | published        | Rule Release A     | ui-98-po          |         1                    | 1      | Date                       | 2030-01-30              |
    When I am logged in as a user with the "Content Creator" role
      And I visit "/rules/2021/01/rule-a/edit"
      And I fill in "edit-field-comments-received-0-uri" with "https://www.google.com"
      And I press "Save"
    Then I am not logged in
      And I visit "/rules/2021/01/rule-a"
      And I should see "Public Comments Due"
      And I should see "Jan. 30, 2030"
      And I should see the link "View Received Comments"
    When I visit "rules/other"
    Then I should see the text "View Received Comments" in the "xxx-abc" row
      And I should see the text "Comments Due: January 30, 2030" in the "xxx-abc" row
    When I am logged in as a user with the "Content Creator" role
      And I am on "/rules/2021/01/rule-a/edit"
      And I select "Text" from "Comments Due Date Format"
      And I type "Due on October 25th, 2050" in the "Comments Due Text" WYSIWYG editor
      And I select the first autocomplete option for "Feedback Flier" on the "Submit Comments" field
      And I check "Show Submit Comments Button"
      And I fill in "field_comments_received[0][title]" with "custon comments link text"
      And I should see the text 'The link text will be defaulted to "View Received Comments"'
      And I press "Save"
    Then I am not logged in
      And I visit "/rules/2021/01/rule-a"
      And I should see "Public Comments Due"
      And I should see "Due on October 25th, 2050"
      And I should see the link "custon comments link text"
      And I visit "rules/other"
      And I should see the text "Comments Due: Due on October 25th, 2050" in the "xxx-abc" row
      And I should see the text "custon comments link text" in the "xxx-abc" row
