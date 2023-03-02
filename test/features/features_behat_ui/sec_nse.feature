Feature: National Security Exchange Content for WDIO
  As a site visitor
  I want to be able to view national security exchanges SRO items
  So that visitors to SEC.gov can learn more about the rules and regulations at secgov

  @api @javascript
  Scenario: View Rules with SRO Organizations NSE
    Given "rulemaking_index" terms:
        | name     | status |
        | ui-98-po | 1      |
        | bi-99-po | 1      |
        | ab-pl-12 | 1      |
      And "rule_type" terms:
        | name   |
        | Rule 1 |
        | Rule 2 |
        | Rule 3 |
      And "topics" terms:
        | name   |
        | topic1 |
      And "division_office" terms:
        | name     |
        | office 1 |
      And "rulemaking_index" terms:
        | name   |
        | 77-987 |
      And "sro_organization" terms:
        | name      | field_category                |
        | behat NSE | National Securities Exchanges |
      And "customized_comment_form" content:
        | title         | field_display_title | status | field_file_number | field_rule_path    | field_ruling |
        | Comment Form  | Display Title for 1 | 1      | ab-pl-12          | /comments/ab-pl-12 | ab-pl-12     |
      And I create "media" of type "static_file":
        | name         | field_display_title | field_media_file  | field_description_abstract | status |
        | Behat file 1 | published media     | behat-file.pdf    | This is description abs    | 1      |
        | Behat file 2 | published media     | behat-file.pdf    | This is description abs    | 1      |
        | Behat file 3 | published media     | behat-file.pdf    | This is description abs    | 1      |
      And "regulation" content:
        | title          | field_rule_type | field_release_number | field_release_file_number | field_publish_date  |field_federal_register_publish_d | moderation_state | field_applicability_date | field_document_citation | field_effective_date | field_rin | field_release_file | field_see_also | field_compliance_date | field_conformed_to_federal_regis | field_federal_register_version      |
        | Rule Release B | Rule 1          | xxx-abc              | ui-98-po                  | 2020-05-25          | 2021-05-25                      | published        | App date b               | doc 1                   | eff b2               | r5        | behat file 1       | behat file 1   | compt date            | 1                                | Go To SEC.gov - https://www.sec.gov |
        | Rule Release C | Rule 2          | xxx-def              | bi-99-po                  | 2019-02-14          | 2021-02-14                      | published        | App date c               | doc 2                   | eff c3               | r6        | behat file 2       | behat file 2   | compt date2           | 0                                |                                     |
        | Rule Release A | Rule 3          | xxx-ghi              | ab-pl-12                  | 2021-01-01          | 2021-01-30                      | published        | App date a               | doc 3                   | eff a1               | r7        | behat file 3       | behat file 3   | compt date3           | 1                                | Go To SEC.gov - https://www.sec.gov |
      And "rule" content:
        | title         | field_display_title | body | field_primary_division_office | field_related_topics | moderation_state | field_related_rule                             | field_show_comments_received | field_show_submit_comments | field_submit_comments | field_comments_received             | field_file_number | field_sro_organization |
        | Rule Parent A | R1 Parent           | bod3 | office 1                      | topic1               | published        | Rule Release A, Rule Release B, Rule Release C | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov | 77-987            | behat NSE              |
        | Rule Parent B | R2 Parent           | bod3 | office 1                      | topic1               | published        | Rule Release C                                 | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov | 77-987            | behat NSE              |
    Then I take a screenshot on "sec" using "rule.feature" file with "@nse_view" tag
