Feature: SEC Views - Pages, Blocks, and Feeds
  As a Site Visitor, the user should be able to view information as available on SEC.gov

@ui @api @javascript @wdio
Scenario: Data List Page View With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title            | body | field_media_file_upload | field_description_abstract | field_contact_name | field_contact_email | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_act              |
      | Verify Data View | test | Behat Test File         | random text                | John Doe           | johndoe@gmail.com   | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Data                          | Corporation Finance           | 123-KO               | Securities Act of 1933 |
      | Verify Data View |      | Behat Test File         | random text                | John Doe           | johndoe@gmail.com   | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Data                          | Corporation Finance           | 123-KO               | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@data_list_page" tag

@ui @api @javascript @wdio
Scenario: Market Structure View With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title                   | body | field_media_file_upload | field_article_sub_type_secart | field_description_abstract | field_contact_name | field_contact_email | field_display_title                   | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_tags | field_act              |
      | Verify Market Structure | body | Behat Test File         | Market Structure              | random text                | John Doe           | johndoe@gmail.com   | Data and sub type as Market Structure | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Data                          | Agency-Wide                   | 123-KO               | data       | Securities Act of 1933 |
      | Verify Market Structure |      | Behat Test File         | Market Structure              | random text                | John Doe           | johndoe@gmail.com   | Data and sub type as Market Structure | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Data                          | Agency-Wide                   | 123-KO               | data       | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@market_structure_page" tag

@ui @api @javascript @wdio
Scenario: Reports and Publications With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title           | body | field_media_file_upload | field_article_sub_type_secart | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
      | Verify PDF file | test | Behat Test File         | Annual Reports                | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Reports and Publications      | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
      | Verify PDF file |      | Behat Test File         | Annual Reports                | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Reports and Publications      | Agency-Wide                   | 123-KO               | Auditors       | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@reports_publications_page" tag

@ui @api @javascript @wdio
Scenario: Forms With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title           | body | field_media_file_upload | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
      | Verify PDF file | body | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Forms                         | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
      | Verify PDF file |      | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Forms                         | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@forms_page" tag

@ui @api @javascript @wdio
Scenario: Fast-Answers With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title           | body | field_media_file_upload | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_act              |
      | Verify PDF file | body | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Fast Answers                  | Corporation Finance           | 123-KO               | Securities Act of 1933 |
      | Verify PDF file |      | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Fast Answers                  | Corporation Finance           | 123-KO               | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@fast_answers_page" tag

@ui @api @javascript @wdio
Scenario: Investor Alerts Page With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title           | body | field_media_file_upload | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
      | Verify PDF file | test | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
      | Verify PDF file |      | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Investor Alerts and Bulletins | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@investor_alerts_page" tag

@ui @api @javascript @wdio
Scenario: Corpfin Announcements Page With and Without Body
  Given I create "media" of type "static_file":
      | name            | field_display_title | field_media_file | field_description_abstract | status |
      | Behat Test File | static file         | behat-form1.pdf  | This is description abs    | 1      |
    And "secarticle" content:
      | title           | body | field_media_file_upload | field_display_title | field_list_page_det_secarticle | field_publish_date  | field_date          | status | field_article_type_secarticle | field_primary_division_office | field_release_number | field_audience | field_act              |
      | Verify PDF file | body | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Announcement                  | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
      | Verify PDF file |      | Behat Test File         | Verify PDF file     | Some random text               | 2019-06-17T17:00:00 | 2019-06-18T17:01:00 | 1      | Announcement                  | Corporation Finance           | 123-KO               | Auditors       | Securities Act of 1933 |
  Then I take a screenshot on "sec" using "views.feature" file with "@corpfin_announcement_page" tag

@ui @api @javascript @wdio
Scenario: Amicus Brief List and Node Page With and Without File Attachment
  Given I create "media" of type "static_file":
      | name       | field_media_file       | status |
      | Behat File | behat-file_corpfin.pdf | 1      |
    And "secarticle" content:
      | field_article_type_secarticle | field_media_file_upload | moderation_state | title             | field_display_title | status | body             | field_primary_division_office | field_publish_date  | field_list_page_det_secarticle | changed             |
      | Amicus Brief                  | Behat File              | published        | Behat for Article | BEHAT Link Title    | 1      | This is the body | Enforcement                   | 2020-05-17T17:00:00 | This is list page details      | 2019-07-25T17:00:00 |
      | Amicus Brief                  |                         | published        | Behat for Article | Basic Article Title | 1      | Normal text      | Enforcement                   | 2019-07-15T17:00:00 | This is list page details      |                     |
  Then I take a screenshot on "sec" using "views.feature" file with "@amicusbriefs_page" tag
  Then I take a screenshot on "sec" using "views.feature" file with "@amicusbriefs_nodepage" tag

@ui @api @javascript @wdio
Scenario: Appellate Brief List and Node Page With and Without File Attachment
  Given I create "media" of type "static_file":
      | name       | field_media_file       | status |
      | Behat File | behat-file_corpfin.pdf | 1      |
    And "secarticle" content:
      | field_article_type_secarticle | field_media_file_upload | moderation_state | title             | field_display_title | status | body             | field_primary_division_office | field_publish_date  | field_list_page_det_secarticle | changed             |
      | Appellate Brief               | Behat File              | published        | Behat for Article | BEHAT Link Title    | 1      | This is the body | Enforcement                   | 2020-05-17T17:00:00 | This is list page details      | 2019-07-25T17:00:00 |
      | Appellate Brief               |                         | published        | Behat for Article | Basic Article Title | 1      | Normal text      | Enforcement                   | 2019-07-15T17:00:00 | This is list page details      |                     |
  Then I take a screenshot on "sec" using "views.feature" file with "@appellatebriefs_page" tag
  Then I take a screenshot on "sec" using "views.feature" file with "@appellatebriefs_nodepage" tag

@ui @api @javascript @wdio
Scenario: WDIO Investment Company Act screenshots of Notices and Order Page
  Given "rulemaking_index" terms:
      | name      |
      | bi-90-po  |
      | bi-91-po  |
      | bi-92-po  |
    And "investment_company_act_category" terms:
      | name        |
      | Behat-ica-1 |
      | Behat-ica-2 |
    And I create "media" of type "static_file":
      | name         | field_display_title | field_media_file | field_description_abstract | status |
      | Behat file 1 | published media     | behat-file.pdf   | This is description abs    | 1      |
      | Behat file 2 | published media     | behat-file.pdf   | This is description abs    | 1      |
      | Behat file 3 | published media     | behat-file.pdf   | This is description abs    | 1      |
    And "regulation" content:
      | title                      | body                | field_rule_type                         | field_release_number | field_publish_date  | moderation_state | status | field_release_file | field_see_also             |
      | Behat Proposed Rule 1      | detail body 1       | Investment Company Act Notice           | 01-11111             | 2022-01-04 12:00:00 | published        | 1      | behat file 1       | behat file 1, Behat file 2 |
      | Behat Final-Concept Rule 2 | detail body 2       | Investment Company Act Order            | 02-22222             | 2021-07-01 12:00:00 | published        | 1      | behat file 2       | behat file 2               |
      | Behat Interim Final Rule 3 | detail body 3       | Investment Company Act Notice           | 03-33333             | 2021-01-03 12:00:00 | published        | 1      | behat file 3       | behat file 3               |
      | Behat Concept Rule 4       | detail body 4       | Investment Company Act Notice           | 04-44444             | 2020-06-29 12:00:00 | published        | 1      |                    |                            |
      | Behat Interpretive Rule 5  | detail body 5       | Investment Company Act Order            | 05-55555             | 2020-01-01 12:00:00 | published        | 1      |                    |                            |
      | Behat Final Rule 6         | detail body 6       | Investment Company Act Order            | 05-66666,01-11111    | 2023-01-01 12:00:00 | published        | 1      |                    |                            |
      | Behat Draft Rule-Release 7 | Draft will not show | Investment Company Act Notice           | 06-77777             | 2000-01-01 12:00:00 | draft            | 0      |                    |                            |
    And "rule" content:
      | title               | field_display_title | field_file_number | body                             | field_related_rule                                | moderation_state | status | field_investment_company_act_cat |
      | Behat Parent Rule 1 | Behat Parent Rule 1 | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Final-Concept Rule 2 | published        | 1      | Behat-ica-1                      |
      | Behat Parent Rule 2 | Behat Parent Rule 2 | bi-91-po          | This is a parent rule overview 2 | Behat Draft Rule-Release 7                        | published        | 1      | Behat-ica-2                      |
      | Behat Parent Rule 3 | Behat Parent Rule 3 |                   | This is a parent rule overview 3 | Behat Interim Final Rule 3                        | published        | 1      | Behat-ica-1                      |
      | Behat Parent Rule 4 | Behat Parent Rule 4 | bi-92-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                        | published        | 0      | Behat-ica-2                      |
  Then I take a screenshot on "sec" using "views.feature" file with "@icreleases_page" tag

@ui @api @javascript @wdio
Scenario: WDIO Exchange Act Exemptive Page
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
      | title                      | body                | field_rule_type    | field_release_number | field_publish_date  | moderation_state | status | field_release_file | field_see_also             |
      | Behat Proposed Rule 1      | detail body 1       | Exemptive          | 01-11111             | 2022-01-04 12:00:00 | published        | 1      | behat file 1       | behat file 1, Behat file 2 |
      | Behat Final-Concept Rule 2 | detail body 2       | Exemptive, Concept | 02-22222             | 2021-07-01 12:00:00 | published        | 1      | behat file 2       | behat file 2               |
      | Behat Interim Final Rule 3 | detail body 3       | Exemptive          | 03-33333             | 2021-01-03 12:00:00 | published        | 1      | behat file 3       | behat file 3               |
      | Behat Concept Rule 4       | detail body 4       | Exemptive          | 04-44444             | 2020-06-29 12:00:00 | published        | 1      |                    |                            |
      | Behat Interpretive Rule 5  | detail body 5       | Exemptive          | 05-55555             | 2020-01-01 12:00:00 | published        | 1      |                    |                            |
      | Behat Final Rule 6         | detail body 6       | Exemptive          | 05-66666,01-11111    | 2023-01-01 12:00:00 | published        | 1      |                    |                            |
      | Behat Draft Rule-Release 7 | Draft will not show | Final              | 06-77777             | 2000-01-01 12:00:00 | draft            | 0      |                    |                            |
    And "rule" content:
      | title               | field_display_title | field_file_number | body                             | field_related_rule                          | moderation_state | status | field_show_comments_received | field_show_submit_comments | field_submit_comments | field_comments_received             | field_comments_date_format | field_comments_due_date | field_comments_notice |
      | Behat Parent Rule 1 | Behat Parent Rule 1 | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | published        | 1      | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov | date                       | 2018-12-05T17:00:00     |                       |
      | Behat Parent Rule 2 | Behat Parent Rule 2 | bi-91-po          | This is a parent rule overview 2 | Behat Draft Rule-Release 7                  | published        | 1      | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov |                            |                         |                       |
      | Behat Parent Rule 3 | Behat Parent Rule 3 |                   | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | published        | 1      |                              |                            |                       |                                     |                            |                         |                       |
      | Behat Parent Rule 4 | Behat Parent Rule 4 | bi-92-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | published        | 0      |                              |                            |                       |                                     |                            |                         |                       |
      | Behat Parent Rule 5 | Behat Parent Rule 5 | bi-93-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | published        | 1      |                              |                            |                       |                                     | text                       |                         | rebuttal              |
      | Behat Parent Rule 6 | Behat Parent Rule 6 | bi-94-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | published        | 1      |                              |                            |                       |                                     |                            |                         |                       |
  Then I take a screenshot on "sec" using "views.feature" file with "@exorders_page" tag

@ui @api @javascript @wdio
Scenario: WDIO Investment Company Act Deregistration Page
  Given I create "media" of type "static_file":
      | name         | field_display_title | field_media_file | field_description_abstract | status |
      | Behat file 1 | published media     | behat-file.pdf   | This is description abs    | 1      |
      | Behat file 2 | published media     | behat-file.pdf   | This is description abs    | 1      |
      | Behat file 3 | published media     | behat-file.pdf   | This is description abs    | 1      |
    And "regulation" content:
      | title                      | body                | field_rule_type                | field_release_number | field_publish_date  | moderation_state | status | field_release_file |
      | Behat Proposed Rule 1      | detail body 1       | Investment Company Act Release | 01-11111             | 2022-01-04 12:00:00 | published        | 1      | Behat file 1       |
      | Behat Final-Concept Rule 2 | detail body 2       | Investment Company Act Release | 02-22222             | 2021-07-01 12:00:00 | published        | 1      | Behat file 2       |
      | Behat Interim Final Rule 3 | detail body 3       | Investment Company Act Release | 03-33333             | 2021-01-03 12:00:00 | published        | 1      |                    |
      | Behat Concept Rule 4       | detail body 4       | Investment Company Act Release | 04-44444             | 2020-06-29 12:00:00 | published        | 1      | Behat file 2       |
      | Behat Interpretive Rule 5  | detail body 5       | Investment Company Act Release | 05-55555             | 2020-01-01 12:00:00 | published        | 1      |                    |
      | Behat Final Rule 6         | detail body 6       | Investment Company Act Release | 05-66666             | 2023-01-01 12:00:00 | published        | 1      | Behat file 3       |
      | Behat Draft Rule-Release 7 | Draft will not show | Investment Company Act Release | 06-77777             | 2000-01-01 12:00:00 | draft            | 0      |                    |
    And "rule" content:
      | title               | field_display_title | body                             | field_related_rule         | moderation_state | status |
      | Behat Parent Rule 1 | Behat Parent Rule 1 | This is a parent rule overview 1 | Behat Proposed Rule 1      | published        | 1      |
      | Behat Parent Rule 2 | Behat Parent Rule 2 | This is a parent rule overview 2 | Behat Final-Concept Rule 2 | published        | 1      |
      | Behat Parent Rule 3 | Behat Parent Rule 3 | This is a parent rule overview 3 | Behat Interim Final Rule 3 | published        | 1      |
      | Behat Parent Rule 4 | Behat Parent Rule 4 | This is a parent rule overview 4 | Behat Final-Concept Rule 2 | published        | 0      |
      | Behat Parent Rule 5 | Behat Parent Rule 5 | This is a parent rule overview 5 | Behat Interpretive Rule 5  | published        | 1      |
      | Behat Parent Rule 6 | Behat Parent Rule 6 | This is a parent rule overview 6 | Behat Final Rule 6         | published        | 0      |
  Then I take a screenshot on "sec" using "views.feature" file with "@dereg_page" tag

Scenario: WDIO Other Commission Order Page
    Given "rulemaking_index" terms:
        | name      | field_respondents | status | field_ap_status | field_rulemaking |
        | bi-90-po  | Anthony           | 1      | Open            | Behat Accounting |
        | bi-91-po  | Harry             | 1      | Open            | Behat Finance    |
        | bi-92-po  | Larry             | 1      | Open            | Behat Billing    |
        | bi-93-po  | Curly             | 1      | Open            | Behat Operations |
        | bi-94-po  | Moe               | 1      | Open            | Behat Shipping   |
        | ti-100-po | Joe               | 1      | Open            | Behat Customer   |
      And "customized_comment_form" content:
        | title         | field_display_title | status | field_file_number | field_rule_path    | field_ruling |
        | Comment Form  | Display Title for 1 | 1      | bi-90-po          | /comments/bi-90-po | bi-90-po     |
      And I create "media" of type "static_file":
        | name         | field_display_title | field_media_file | field_description_abstract | status |
        | Behat file 1 | published media     | behat-file.pdf   | This is description abs    | 1      |
        | Behat file 2 | published media     | behat-file.pdf   | This is description abs    | 1      |
        | Behat file 3 | published media     | behat-file.pdf   | This is description abs    | 1      |
      And "regulation" content:
        | title                      | body                | field_rule_type | field_release_number | field_publish_date  | moderation_state | status | field_release_file | field_see_also             | field_conformed_to_federal_regis | field_federal_register_version | field_document_citation |
        | Behat Proposed Rule 1      | detail body 1       | Other           | 01-11111, 02-33333   | 2022-01-04 12:00:00 | published        | 1      | behat file 1       | behat file 1, Behat file 2 | 1                                | https://www.sec.gov            | behat citation          |
        | Behat Final-Concept Rule 2 | detail body 2       | Other           | 02-22222             | 2021-07-01 12:00:00 | published        | 1      | behat file 2       | behat file 2               |                                  |                                |                         |
        | Behat Interim Final Rule 3 | detail body 3       | FASB            | 03-33333, 01-33333   | 2021-01-03 12:00:00 | published        | 1      | behat file 3       | behat file 3               | 1                                | https://www.sec.gov            | wdio doc citation       |
        | Behat Concept Rule 4       | detail body 4       | Other           | 04-44444             | 2020-06-29 12:00:00 | published        | 1      |                    |                            |                                  |                                |                         |
        | Behat Interpretive Rule 5  | detail body 5       | Other           | 05-55555             | 2020-01-01 12:00:00 | published        | 1      |                    |                            |                                  |                                |                         |
        | Behat Final Rule 6         | detail body 6       | Other           | 05-66666             | 2023-01-01 12:00:00 | published        | 1      |                    |                            |                                  |                                |                         |
        | Behat Draft Rule-Release 7 | Draft will not show | Other           | 06-77777             | 2000-01-01 12:00:00 | draft            | 0      |                    |                            |                                  |                                |                         |
      And "rule" content:
        | title               | field_display_title | field_file_number | body                             | field_related_rule         | moderation_state | status | field_show_comments_received | field_show_submit_comments | field_submit_comments | field_comments_received             | field_comments_date_format | field_comments_due_date |
        | Behat Parent Rule 1 | Behat Parent Rule 1 | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1      | published        | 1      | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov | date                       | 2018-12-05T17:00:00     |
        | Behat Parent Rule 2 | Behat Parent Rule 2 | bi-91-po          | This is a parent rule overview 2 | Behat Final-Concept Rule 2 | published        | 1      | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov |                            |                         |
        | Behat Parent Rule 3 | Behat Parent Rule 3 | bi-92-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3 | published        | 1      |                              |                            |                       |                                     |                            |                         |
        | Behat Parent Rule 4 | Behat Parent Rule 4 |                   | This is a parent rule overview 4 | Behat Final-Concept Rule 2 | published        | 0      |                              |                            |                       |                                     |                            |                         |
        | Behat Parent Rule 5 | Behat Parent Rule 5 |                   | This is a parent rule overview 5 | Behat Interpretive Rule 5  | published        | 1      |                              |                            |                       |                                     |                            |                         |
        | Behat Parent Rule 6 | Behat Parent Rule 6 | bi-93-po          | This is a parent rule overview 6 | Behat Final Rule 6         | published        | 0      |                              |                            |                       |                                     |                            |                         |
  Then I take a screenshot on "sec" using "views.feature" file with "@other_page" tag
