Feature: SRO Rule Release Content for WDIO
  As a Content Creator
  I want to be able to create and edit regulation content from Self Regulatory Organizations
  So that visitors to SEC.gov can learn more about the rules and regulations at secgov

  @api @javascript
  Scenario: Create and View Rule with multiple SRO Rule Releases for WDIO
    Given "sro_organization_category" terms:
        | name               | status |
        | Behat SRO Category | 1      |
      And "sro_organization" terms:
        | name                   | field_abbreviated |  status |
        | Behat SRO Organization | behatSROrg        | 1       |
      And "division_office" terms:
        | name     |
        | office 1 |
      And "sro_organization_category" terms:
        | name      |
        | SRO_ORG_1 |
        | SRO_ORG_2 |
      And "sro_organization" terms:
        | name        | field_abbreviated | field_category |
        | Behat-sro-1 | SRO1              | SRO_ORG_1      |
        | Behat-sro-2 | SRO2              | SRO_ORG_2      |
      And "rule_type" terms:
        | name   |
        | Rule 1 |
        | Rule 2 |
      And "rulemaking_index" terms:
        | name   |
        | ab-pl-12   |
        | 77-SRO-987 |
        | 66-SRO-456 |
      And "customized_comment_form" content:
        | title         | field_display_title | status | field_file_number | field_rule_path    | field_ruling |
        | Comment Form  | Display Title for 1 | 1      | ab-pl-12          | /comments/ab-pl-12 | ab-pl-12     |
      And I create "media" of type "static_file":
        | name         | field_display_title | field_media_file  | field_description_abstract | status |
        | Behat file 1 | published media     | behat-file.pdf    | This is description abs    | 1      |
        | Behat file 2 | published media     | behat-file.pdf    | This is description abs    | 1      |
        | Behat file 3 | published media     | behat-file.pdf    | This is description abs    | 1      |
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date  |field_federal_register_publish_d | moderation_state | field_applicability_date | field_document_citation | field_effective_date | field_rin | field_release_file | field_see_also | field_compliance_date | field_conformed_to_federal_regis | field_federal_register_version      |
        | Rule Release B | Rule 1          | xxx-abc              | 2020-05-25          | 2021-05-25                      | published        | App date b               | doc 1                   | eff b2               | r5        | behat file 1       | behat file 1   | compt date            | 1                                | Go To SEC.gov - https://www.sec.gov |
        | Rule Release C | Rule 1          | xxx-def              | 2019-02-14          | 2021-02-14                      | published        | App date c               | doc 2                   | eff c3               | r6        | behat file 2       | behat file 2   | compt date2           | 0                                |                                     |
        | Rule Release A | Rule 2          | xxx-ghi              | 2021-01-01          | 2021-01-30                      | published        | App date a               | doc 3                   | eff a1               | r7        | behat file 3       | behat file 3   | compt date3           | 1                                | Go To SEC.gov - https://www.sec.gov |
      And "rule" content:
        | title         | field_display_title | body | field_sro_organization | field_primary_division_office | moderation_state | field_related_rule             | field_show_comments_received | field_show_submit_comments | field_submit_comments | field_comments_received             | field_file_number | field_sro_organization |
        | Rule Parent A | R1 Parent           | bod3 | Behat SRO Organization | office 1                      | published        | Rule Release A                 | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov | 77-SRO-987        | Behat-sro-1            |
        | Rule Parent B | R1 Parent           | bod3 | Behat SRO Organization | office 1                      | published        | Rule Release B, Rule Release C | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov | 66-SRO-456        | Behat-sro-2            |
    Then I take a screenshot on "sec" using "srorules.feature" file with "@sro_rule_view" tag
      And I take a screenshot on "sec" using "srorules.feature" file with "@sro_rule_accordion" tag
      And I take a screenshot on "sec" using "views.feature" file with "@sro_universal" tag

  @api @javascript
  Scenario: Validate Comments Received Default and Custom Link Text on Rule Node
    When "rulemaking_index" terms:
      | name   |
      | ui-700 |
      | ui-987 |
      And "sro_organization" terms:
        | name                   | field_category                |
        | Behat 200 Organization | National Securities Exchanges |
      And "rule_type" terms:
        | name   |
        | Rule 2 |
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_publish_date  |field_federal_register_publish_d | moderation_state | field_applicability_date | status |
        | Rule Release A | Rule 2          | xxx-ghi              | 2021-01-01          | 2021-01-30                      | published        | App date a               | 1      |
      And "rule" content:
        | title  | field_display_title | body                  | field_sro_organization | field_primary_division_office | moderation_state | field_related_rule | field_file_number | field_comments_received             |field_show_comments_received | field_show_submit_comments | status | field_comments_date_format | field_comments_due_date | field_submit_comments |
        | Rule A | R1 Parent           | This is rule overview | Behat 200 Organization | office 1                      | published        | Rule Release A     | ui-987            | Go to SEC.gov - https://www.sec.gov |        1                    | 1                          | 1      | Date                       | 2030-01-30              | Comment Form          |
        | Rule B | R1 Parent           | This is rule overview | Behat 200 Organization | office 1                      | published        | Rule Release A     | ui-700            |                                     |        1                    | 1                          | 1      | Date                       | 2030-01-30              | Comment Form          |
    Then I take a screenshot on "sec" using "srorules.feature" file with "@sro_custom_comments_rec" tag
    When I am logged in as a user with the "Content Creator" role
      And I am on "/rules/sro/ui-700/edit"
      And I fill in "field_comments_received[0][uri]" with "https://www.sec.gov"
      And I press "Save"
    Then I take a screenshot on "sec" using "srorules.feature" file with "@sro_default_comments_rec" tag
