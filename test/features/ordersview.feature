Feature: Other Commission Orders and Notices View
As a sec.gov site visitor, I should be able to view Other Commission Orders

 Background:
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
        | Behat Proposed Rule 1      | detail body 1       | Other           | 01-11111             | 2022-01-04 12:00:00 | published        | 1      | behat file 1       | behat file 1, Behat file 2 | 1                                | https://www.sec.gov            | behat citation          |
        | Behat Final-Concept Rule 2 | detail body 2       | Other           | 02-22222             | 2021-07-01 12:00:00 | published        | 1      | behat file 2       | behat file 2               |                                  |                                |                         |
        | Behat Interim Final Rule 3 | detail body 3       | FASB            | 03-33333             | 2021-01-03 12:00:00 | published        | 1      | behat file 3       | behat file 3               | 1                                | https://www.sec.gov            | wdio doc citation       |
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

  @api
  Scenario: Validate Default Other Commission Orders Page
    Given I am on "/rules/other"
    Then I should see the heading "Other Commission Orders, Notices, and Information"
      And I should see the text "Regulatory Actions"
      And I should see the text "Archive of other SEC Orders, Notices and Information available include"
      And I should see the heading "Quick Links"
      And "July 1, 2021" should precede "Jan. 3, 2021" for the query "//*[@id='block-secgov-content']/div/table/tbody/tr[*]/td[2]"
      And "Jan. 3, 2021" should precede "Jan. 1, 2020" for the query "//*[@id='block-secgov-content']/div/table/tbody/tr[*]/td[2]"
      And I should see the text "Release Number" in the "OT_header" region
      And I should see the text "SEC Issue Date" in the "OT_header" region
      And I should see the text "File Number" in the "OT_header" region
      And I should see the text "Details" in the "OT_header" region
      And I should see the text "01-11111" in the "Behat Proposed Rule 1" row
      And I should see the text "Jan. 4, 2022" in the "Behat Proposed Rule 1" row
      And I should see the text "bi-90-po" in the "Behat Proposed Rule 1" row
      And I should see the text "Comments Due: December 5, 2018" in the "Behat Proposed Rule 1" row
      And I should see the text "Go to SEC.gov" in the "Behat Proposed Rule 1" row
      And I should see the text "See Also - Behat file 1, Behat file 2" in the "Behat Proposed Rule 1" row
      And I should see the link "Submit A Comment on bi-90-po"
      And I should see "Federal Register version (behat citation)"
      And I should see the text "02-22222" in the "Behat Final-Concept Rule 2" row
      And I should see the text "July 1, 2021" in the "Behat Final-Concept Rule 2" row
      And I should see the text "bi-91-po" in the "Behat Final-Concept Rule 2" row
      And I should see the text "See Also - Behat file 2" in the "Behat Final-Concept Rule 2" row
      And I should see the text "Behat Final-Concept Rule 2" in the "Behat Final-Concept Rule 2" row
      And I should see the text "03-33333" in the "Behat Interim Final Rule 3" row
      And I should see the text "Jan. 3, 2021" in the "Behat Interim Final Rule 3" row
      And I should see the text "bi-92-po" in the "Behat Interim Final Rule 3" row
      And I should see the text "Behat Interim Final Rule 3" in the "Behat Interim Final Rule 3" row
      And I should see the text "See Also - Behat file 3" in the "Behat Interim Final Rule 3" row
      And I should see the link "Submit A Comment on bi-91-po"
      And I should see the text "Displaying 1 - 4 of 4"
      And I should not see the text "Behat Final Rule 6"
    When I am on "/rules/other"
      And I click "Submit A Comment on bi-90-po"
    Then I should see the heading "Submit Comments on bi-90-po Comment Form"

  @api
  Scenario: Verify Other Quick Links
    Given I am logged in as a user with the "sitebuilder" role
    When I am on "/rules/other/edit"
      And I select "Show Default Quick Links" from "field_quick_links"
      And I press "Save"
      And I am not logged in
      And I am on "/rules/other"
    Then I should see "Quick Links"
      And I click "How to Submit Comments"
      And I should see the heading "How to Submit Comments"
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/rules/other/edit"
      And I select "Show Alternate Default Quick Links" from "field_quick_links"
      And I press "Save"
      And I am logged in as a user with the "authenticated" role
      And I am on "/rules/other"
    Then I should see "Quick Links"
      And I should see the link "How to Submit Comments"
      And I should see the link "Electronic Filings in Administrative Proceedings (eFAP)"
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/rules/other/edit"
      And I select "Customize Quick Links" from "field_quick_links"
      And I fill in "field_customized_quick_links[0][uri]" with "http://sec.lndo.site/edgar/about"
      And I fill in "field_customized_quick_links[0][title]" with "EDGAR"
      And I press "field_customized_quick_links_add_more"
      And I fill in "field_customized_quick_links[1][uri]" with "https://www.google.com"
      And I fill in "field_customized_quick_links[1][title]" with "External Google Link"
      And I press "Save"
      And I am not logged in
      And I am on "/rules/other"
      And I click "EDGAR"
      And I wait 2 seconds
    Then I should see the text "About EDGAR"
    When I am on "/rules/other"
    Then I should see the "a" element with the "href" attribute set to "https://www.google.com" in the "release_view_about" region
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/rules/other/edit"
      And I select "Hide Quick Links" from "field_quick_links"
      And I press "Save"
      And I am not logged in
      And I am on "/rules/other"
    Then I should not see "Quick Links"
      And I should not see the link "How to Submit Comments"
    #return to default quick links
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/rules/other/edit"
      And I select "Show Default Quick Links" from "field_quick_links"
      And I press "Save"

  @api
  Scenario: Validate Other Page Sorting of SEC Date
    Given I am on "/rules/other"
    When I click "sort by SEC Issue Date"
    Then "Jan. 1, 2020" should precede "Jan. 3, 2021" for the query "//*[@id='block-secgov-content']/div/table/tbody/tr[*]/td[2]"
      And "Jan. 3, 2021" should precede "July 1, 2021" for the query "//*[@id='block-secgov-content']/div/table/tbody/tr[*]/td[2]"
      And "July 1, 2021" should precede "Jan. 4, 2022" for the query "//*[@id='block-secgov-content']/div/table/tbody/tr[*]/td[2]"
    When I click "sort by SEC Issue Date"
    Then "Jan. 4, 2022" should precede "July 1, 2021" for the query "//*[@id='block-secgov-content']/div/table/tbody/tr[*]/td[2]"
      And "July 1, 2021" should precede "Jan. 3, 2021" for the query "//*[@id='block-secgov-content']/div/table/tbody/tr[*]/td[2]"
      And "Jan. 3, 2021" should precede "Jan. 1, 2020" for the query "//*[@id='block-secgov-content']/div/table/tbody/tr[*]/td[2]"

  @api
  Scenario: Validate Other Page Sorting of File Number
    Given I am on "/rules/other"
    When I click "sort by File Number"
    Then "bi-90-po" should precede "bi-91-po" for the query "//*[@id='block-secgov-content']/div/table/tbody/tr[*]/td[3]"
      And "bi-91-po" should precede "bi-92-po" for the query "//*[@id='block-secgov-content']/div/table/tbody/tr[*]/td[3]"
    When I click "sort by File Number"
    Then "bi-92-po" should precede "bi-91-po" for the query "//*[@id='block-secgov-content']/div/table/tbody/tr[*]/td[3]"
      And "bi-91-po" should precede "bi-90-po" for the query "//*[@id='block-secgov-content']/div/table/tbody/tr[*]/td[3]"

  @api
  Scenario: Other View Pagination
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
    When I am on "/rules/other"
    Then I should see the text "Displaying 1 - 100 of 115"
      And I should see the link "1"
      And I should see the link "2"
      And I should see the link "Go to next page"
      And I should see the link "Go to last page"
    When I click "Go to last page"
    Then I should see the text "Displaying 101 - 115 of 115"
