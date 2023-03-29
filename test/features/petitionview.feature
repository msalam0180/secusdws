Feature:  Petitions for Rulemaking Submitted to the SEC View
As a sec.gov site visitor, I should be able to view Public Petitions Orders

 Background:
    Given "rulemaking_index" terms:
        | name      |
        | bi-90-po  |
        | bi-91-po  |
        | bi-92-po  |
        | bi-93-po  |
        | bi-94-po  |
        | ti-100-po |
      And "customized_comment_form" content:
        | title         | field_display_title | status | field_file_number | field_rule_path    | field_ruling |
        | Comment Form  | Display Title for 1 | 1      | bi-90-po          | /comments/bi-90-po | bi-90-po     |
      And I create "media" of type "static_file":
        | name         | field_display_title | field_media_file | field_description_abstract | status |
        | Behat file 1 | published media     | behat-file.pdf   | This is description abs    | 1      |
        | Behat file 2 | published media     | behat-file.pdf   | This is description abs    | 1      |
        | Behat file 3 | published media     | behat-file.pdf   | This is description abs    | 1      |
      And "regulation" content:
        | title                      | body                | field_rule_type | field_release_number | field_publish_date  | moderation_state | status | field_release_file | field_see_also             | field_submitted_by |
        | Behat Proposed Rule 1      | detail body 1       | Petition        | 01-11111             | 2022-01-04 12:00:00 | published        | 1      | behat file 1       | behat file 1, Behat file 2 | Andrew John        |
        | Behat Final-Concept Rule 2 | detail body 2       | Petition        | 02-22222             | 2021-07-01 12:00:00 | published        | 1      | behat file 2       | behat file 2               | Max Mason          |
        | Behat Interim Final Rule 3 | detail body 3       | Petition        | 03-33333             | 2021-01-03 12:00:00 | published        | 1      | behat file 3       | behat file 3               |                    |
        | Behat Concept Rule 4       | detail body 4       | Petition        | 04-44444             | 2020-06-29 12:00:00 | published        | 1      |                    |                            |                    |
        | Behat Interpretive Rule 5  | detail body 5       | Petition        | 05-55555             | 2020-01-01 12:00:00 | published        | 1      |                    |                            |                    |
        | Behat Final Rule 6         | detail body 6       | Petition        | 05-66666             | 2023-01-01 12:00:00 | published        | 1      |                    |                            |                    |
        | Behat Draft Rule-Release 7 | Draft will not show | Petition        | 06-77777             | 2000-01-01 12:00:00 | draft            | 0      |                    |                            |                    |
      And "rule" content:
        | title               | field_display_title | field_file_number | body                             | field_related_rule         | moderation_state | status | field_show_comments_received | field_show_submit_comments | field_submit_comments | field_comments_received             | field_comments_date_format | field_comments_due_date |
        | Behat Parent Rule 1 | Behat Parent Rule 1 | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1      | published        | 1      | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov | date                       | 2018-12-05T17:00:00     |
        | Behat Parent Rule 2 | Behat Parent Rule 2 | bi-91-po          | This is a parent rule overview 2 | Behat Final-Concept Rule 2 | published        | 1      | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov |                            |                         |
        | Behat Parent Rule 3 | Behat Parent Rule 3 | bi-92-po          | This is a parent rule overview 3 | Behat Interim Final Rule 3 | published        | 1      |                              |                            |                       |                                     |                            |                         |
        | Behat Parent Rule 4 | Behat Parent Rule 4 |                   | This is a parent rule overview 4 | Behat Final-Concept Rule 2 | published        | 0      |                              |                            |                       |                                     |                            |                         |
        | Behat Parent Rule 5 | Behat Parent Rule 5 |                   | This is a parent rule overview 5 | Behat Interpretive Rule 5  | published        | 1      |                              |                            |                       |                                     |                            |                         |
        | Behat Parent Rule 6 | Behat Parent Rule 6 | bi-93-po          | This is a parent rule overview 6 | Behat Final Rule 6         | published        | 0      |                              |                            |                       |                                     |                            |                         |

  @api @javascript
  Scenario: Validate Default Public Petitions Page
    Given I am logged in as a user with the "Content Approver" role
    When I am on "/rules/2021/07/behat-parent-rule-2/edit"
      And I fill in "edit-field-comments-received-0-title" with ""
      And I press "Save"
      And I am on "/user/logout"
      And I am on "/rules/petitions"
    Then I should see the heading "Petitions for Rulemaking Submitted to the SEC"
      And I should see the text "Regulatory Actions"
      And I should see the text "Petitions must contain the text or substance of any proposed rule or amendment or specify the rule or portion of a rule requested to be repealed. Persons submitting petitions must also include a statement of their interest and/or reasons for requesting Commission action."
      And I should see the heading "Quick Links"
      And "July 1, 2021" should precede "Jan. 3, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan. 3, 2021" should precede "Jan. 1, 2020" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And I should see the text "File Number" in the "NSE_header" region
      And I should see the text "Date" in the "NSE_header" region
      And I should see the text "Details" in the "NSE_header" region
      And I should see the text "bi-90-po" in the "Behat Proposed Rule 1" row
      And I should see the text "Jan. 4, 2022" in the "Behat Proposed Rule 1" row
      And I should see the text "Comments Due: December 5, 2018" in the "Behat Proposed Rule 1" row
      And I should see the text "Go to SEC.gov" in the "Behat Proposed Rule 1" row
      And I should see the text "See Also - Behat file 1, Behat file 2" in the "Behat Proposed Rule 1" row
      And I should see the text "Submitted By:" in the "Behat Proposed Rule 1" row
      And I should see the text "Andrew John" in the "Behat Proposed Rule 1" row
      And I should see the link "Submit A Comment on bi-90-po"
      And I should see the text "bi-91-po" in the "Behat Final-Concept Rule 2" row
      And I should see the text "July 1, 2021" in the "Behat Final-Concept Rule 2" row
      And I should see the text "See Also - Behat file 2" in the "Behat Final-Concept Rule 2" row
      And I should see the text "Behat Final-Concept Rule 2" in the "Behat Final-Concept Rule 2" row
      And I should see the text "View Received Comments" in the "Behat Final-Concept Rule 2" row
      And I should see the text "Submitted By:" in the "Behat Final-Concept Rule 2" row
      And I should see the text "Max Mason" in the "Behat Final-Concept Rule 2" row
      And I should see the text "bi-92-po" in the "Behat Interim Final Rule 3" row
      And I should see the text "Jan. 3, 2021" in the "Behat Interim Final Rule 3" row
      And I should see the text "Behat Interim Final Rule 3" in the "Behat Interim Final Rule 3" row
      And I should see the text "See Also - Behat file 3" in the "Behat Interim Final Rule 3" row
      And I should see the text "Jan. 1, 2020" in the "Behat Interpretive Rule 5" row
      And I should see the text "Displaying 1 - 4 of 4"
      And I should not see the text "Behat Final Rule 6"
      And I should see the link "Behat Proposed Rule 1" before I see the link "Behat Final-Concept Rule 2" in the "Public Petitions" view
      And I should see the link "Behat Final-Concept Rule 2" before I see the link "Behat Interim Final Rule 3" in the "Public Petitions" view
    When I click "Submit A Comment on bi-90-po"
    Then I should see the heading "Submit Comments on bi-90-po Comment Form"

  @api
  Scenario: Verify Petitions Quick Links
    Given I am logged in as a user with the "sitebuilder" role
    When I am on "/block/1291?destination=/rules/petitions"
      And I select "Show Default Quick Links" from "field_quick_links"
      And I press "Save"
      And I am not logged in
      And I am on "/rules/petitions"
    Then I should see "Quick Links"
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/block/1291?destination=/rules/petitions"
      And I select "Show Alternate Default Quick Links" from "field_quick_links"
      And I press "Save"
      And I am not logged in
      And I am on "/rules/petitions"
    Then I should see "Quick Links"
      And I should see the link "Electronic Filings in Administrative Proceedings (eFAP)"
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/block/1291?destination=/rules/petitions"
      And I select "Customize Quick Links" from "field_quick_links"
      And I fill in "field_customized_quick_links[0][uri]" with "http://sec.lndo.site/edgar/about"
      And I fill in "field_customized_quick_links[0][title]" with "EDGAR"
      And I press "field_customized_quick_links_add_more"
      And I fill in "field_customized_quick_links[1][uri]" with "https://www.google.com"
      And I fill in "field_customized_quick_links[1][title]" with "External Google Link"
      And I press "Save"
      And I am not logged in
      And I am on "/rules/petitions"
      And I click "EDGAR"
    Then I should see the text "About EDGAR"
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/block/1291?destination=/rules/petitions"
      And I select "Hide Quick Links" from "field_quick_links"
      And I press "Save"
      And I am not logged in
      And I am on "/rules/petitions"
    Then I should not see "Quick Links"
      And I should not see the link "How to Submit Comments"
      #return to default quick links
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/block/1291?destination=/rules/petitions"
      And I select "Show Default Quick Links" from "field_quick_links"
      And I press "Save"

  @api
  Scenario: Validate Petitions Page Sorting of Date
    Given I am on "/rules/petitions"
    When I click "sort by Date"
    Then "Jan. 1, 2020" should precede "Jan. 3, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan. 3, 2021" should precede "July 1, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "July 1, 2021" should precede "Jan. 4, 2022" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
    When I click "sort by Date"
    Then "Jan. 4, 2022" should precede "July 1, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "July 1, 2021" should precede "Jan. 3, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan. 3, 2021" should precede "Jan. 1, 2020" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"

  @api
  Scenario: Validate Petitions Page Sorting of File Number
    Given I am on "/rules/petitions"
    When I click "sort by File Number"
    Then "bi-90-po" should precede "bi-91-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[1]"
      And "bi-91-po" should precede "bi-92-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[1]"
    When I click "sort by File Number"
    Then "bi-92-po" should precede "bi-91-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[1]"
      And "bi-91-po" should precede "bi-90-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[1]"

  @api
  Scenario: Petitions View Pagination
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
    When I am on "/rules/petitions"
    Then I should see the text "Displaying 1 - 100 of 115"
      And I should see the link "1"
      And I should see the link "2"
      And I should see the link "Next"
      And I should see the link "Last"
    When I click "Last"
    Then I should see the text "Displaying 101 - 115 of 115"
