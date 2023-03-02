Feature: National Security Exhanges (NSE) View
As a sec.gov site visitor, I should be able to view National Security Echanges.

  Background:
    Given "rulemaking_index" terms:
        | name      | field_respondents | status | field_ap_status | field_rulemaking |
        | bi-90-po  | Anthony           | 1      | Open            | Behat Accounting |
        | bi-91-po  | Harry             | 1      | Open            | Behat Finance    |
        | bi-92-po  | Larry             | 1      | Open            | Behat Billing    |
        | bi-93-po  | Curly             | 1      | Open            | Behat Operations |
        | bi-94-po  | Moe               | 1      | Open            | Behat Shipping   |
        | ti-100-po | Joe               | 1      | Open            | Behat Customer   |
      And "sro_organization" terms:
        | name        | field_category                |
        | Behat-sro-1 | National Securities Exchanges |
        | Behat-sro-2 | National Securities Exchanges |
      And "division_office" terms:
        | name           |
        | Behat-office 1 |
        | Behat-office 2 |
        | Behat-office 3 |
        | Behat-office 4 |
        | Behat-office 5 |
        | Behat-office 6 |
        | Behat-office 7 |
      And "customized_comment_form" content:
        | title         | field_display_title | status | field_file_number | field_rule_path    | field_ruling |
        | Comment Form  | Display Title for 1 | 1      | bi-90-po          | /comments/bi-90-po | bi-90-po     |
      And I create "media" of type "static_file":
        | name         | field_display_title | field_media_file  | field_description_abstract | status |
        | Behat file 1 | published media     | behat-file.pdf    | This is description abs    | 1      |
        | Behat file 2 | published media     | behat-file.pdf    | This is description abs    | 1      |
        | Behat file 3 | published media     | behat-file.pdf    | This is description abs    | 1      |
      And "regulation" content:
        | title                      | body                | field_rule_type | field_release_number | field_publish_date  | moderation_state | status | field_release_file | field_see_also             |
        | Behat Proposed Rule 1      | detail body 1       | Proposed        | 01-11111             | 2022-01-04 12:00:00 | published        | 1      | behat file 1       | behat file 1, Behat file 2 |
        | Behat Final-Concept Rule 2 | detail body 2       | Final, Concept  | 02-22222             | 2021-07-01 12:00:00 | published        | 1      | behat file 2       | behat file 2               |
        | Behat Interim Final Rule 3 | detail body 3       | Interim Final   | 03-33333             | 2021-01-03 12:00:00 | published        | 1      | behat file 3       | behat file 3               |
        | Behat Concept Rule 4       | detail body 4       | Concept         | 04-44444             | 2020-06-29 12:00:00 | published        | 1      |                    |                            |
        | Behat Interpretive Rule 5  | detail body 5       | Interpretive    | 05-55555             | 2020-01-01 12:00:00 | published        | 1      |                    |                            |
        | Behat Final Rule 6         | detail body 6       | Final           | 05-66666,01-11111    | 2023-01-01 12:00:00 | published        | 1      |                    |                            |
        | Behat Draft Rule-Release 7 | Draft will not show | Final           | 06-77777             | 2000-01-01 12:00:00 | draft            | 0      |                    |                            |
      And "rule" content:
        | title               | field_display_title | field_file_number | body                             | field_related_rule                          | field_primary_division_office | moderation_state | status | field_sro_organization | field_show_comments_received | field_show_submit_comments | field_submit_comments | field_comments_received             | field_comments_date_format | field_comments_due_date |
        | Behat Parent Rule 1 | Behat Parent Rule 1 | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      | Behat-sro-1            | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov | date                       | 2018-12-05T17:00:00     |
        | Behat Parent Rule 2 | Behat Parent Rule 2 | bi-91-po          | This is a parent rule overview 2 | Behat Draft Rule-Release 7                  | Behat-office 2                | published        | 1      | Behat-sro-2            | 1                            | 1                          | Comment Form          | Go to SEC.gov - https://www.sec.gov |                            |                         |
        | Behat Parent Rule 3 | Behat Parent Rule 3 |                   | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      | Behat-sro-1            |                              |                            |                       |                                     |                            |                         |
        | Behat Parent Rule 4 | Behat Parent Rule 4 | bi-92-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 0      | Behat-sro-2            |                              |                            |                       |                                     |                            |                         |
        | Behat Parent Rule 5 | Behat Parent Rule 5 | bi-93-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      | Behat-sro-1            |                              |                            |                       |                                     |                            |                         |
        | Behat Parent Rule 6 | Behat Parent Rule 6 | bi-94-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      | Behat-sro-2            |                              |                            |                       |                                     |                            |                         |

  @api @javascript
  Scenario: Validate Default National Security Exchange Page
    Given I am on "/rules-regulations/national-securities-exchanges-rulemaking"
    When I click "Submit A Comment"
    Then I should see the heading "Submit Comments on bi-90-po Comment Form"
    When I visit "/rules-regulations/national-securities-exchanges-rulemaking"
    Then I should see the heading "National Security Exchanges"
      And I should see the text "SRO Organization" in the "NSE_table" region
      And I should see the text "Title" in the "NSE_table" region
      And I should see the text "Release Number" in the "NSE_table" region
      And I should see the text "File Number" in the "NSE_table" region
      And I should see the text "Year" in the "NSE_table" region
      And I should see the text "Month" in the "NSE_table" region
      And I should see the text "Release Number" in the "NSE_header" region
      And I should see the text "SEC Issue Date" in the "NSE_header" region
      And I should see the text "File Number" in the "NSE_header" region
      And I should see the text "SRO Organization" in the "NSE_header" region
      And I should see the text "Details" in the "NSE_header" region
      And I should see the text "05-66666" in the "Behat Parent Rule 6" row
      And I should see the text "01-11111" in the "Behat Parent Rule 6" row
      And I should see the text "Jan 1, 2023" in the "Behat Parent Rule 6" row
      And I should see the text "bi-94-po" in the "Behat Parent Rule 6" row
      And I should see the text "Behat-sro-2" in the "Behat Parent Rule 6" row
      And I should see the text "Behat Parent Rule 6" in the "Behat Parent Rule 6" row
      And I should see the text "01-11111" in the "Behat Parent Rule 1" row
      And I should see the text "Jan 4, 2022" in the "Behat Parent Rule 1" row
      And I should see the text "bi-90-po" in the "Behat Parent Rule 1" row
      And I should see the text "Behat-sro-1" in the "Behat Parent Rule 1" row
      And I should see the text "Behat Parent Rule 1" in the "Behat Parent Rule 1" row
      And I should see the text "Comments Due: December 5, 2018" in the "Behat Parent Rule 1" row
      And I should see the link "Go to SEC.gov"
      And I should see "See Also - Behat file 1, Behat file 2"
      And I should see the link "Submit A Comment"
      And I should see the text "05-55555" in the "Behat Parent Rule 5" row
      And I should see the text "Jan 1, 2020" in the "Behat Parent Rule 5" row
      And I should see the text "bi-93-po" in the "Behat Parent Rule 5" row
      And I should see the text "Behat-sro-1" in the "Behat Parent Rule 5" row
      And I should see the text "Behat Parent Rule 5" in the "Behat Parent Rule 5" row
      And I should see the text "Displaying 1 - 6 of 6"
      And I should not see the text "Behat Parent Rule 2"

  @api @javascript
  Scenario: Validating NSE View Search Filters
    Given I am on "/rules-regulations/national-securities-exchanges-rulemaking"
    When  I select "Behat-sro-1" from "SRO Organization"
      And I wait 2 seconds
    Then I should see "Behat Parent Rule 1"
      And I should see "Behat Parent Rule 3"
      And I should see "Behat Parent Rule 5"
      And I should not see "Behat Parent Rule 6"
      And I should not see "Behat Parent Rule 4"
      And I should see "Displaying 1 - 4 of 4"
    When I select "-View All-" from "SRO Organization"
      And I fill in "Title" with "6"
      And I press "Apply"
      And I wait 2 seconds
    Then I should see "Behat Parent Rule 6"
      And I should see "Displaying 1 - 1 of 1"
    When I fill in "Title" with ""
      And I fill in "Release Number" with "5"
      And I press "Apply"
      And I wait 2 seconds
    Then I should see "Behat Parent Rule 6"
      And I should see "Behat Parent Rule 5"
      And I should see "Displaying 1 - 2 of 2"
    When I fill in "Release Number" with ""
      And I fill in "File Number" with "0"
      And I press "Apply"
      And I wait 2 seconds
    Then I should see "01-11111"
      And I should see "04-44444"
      And I should see "Displaying 1 - 2 of 2"
    When I fill in "File Number" with ""
      And I select "2021" from "year"
    Then I should see "02-22222"
      And I should see "03-33333"
      And I should see "Displaying 1 - 2 of 2"
    When I select "7" from "month"
    Then I should see "02-22222"
      And I should not see "03-33333"
      And I should see "Displaying 1 - 1 of 1"

  @api
  Scenario Outline: Site visitor Filters only NSE Items
    Given I am on "/rules-regulations/national-securities-exchanges-rulemaking"
    When I select "<NSE_items>" from "SRO Organization"

    Examples:
      | NSE_items                                           |
      | Bats BYX Exchange, Inc. (BatsBYX)                   |
      | American Stock Exchange (Amex)                      |
      | Bats BZX Exchange, Inc. (BatsBZX)                   |
      | Bats EDGA Exchange, Inc. (BatsEDGA)                 |
      | Bats EDGX Exchange, Inc. (BatsEDGX)                 |
      | BATS Exchange (BATS)                                |
      | BATS Y-Exchange (BYX)                               |
      | Behat-sro-1                                         |
      | Behat-sro-2                                         |
      | Boston Stock Exchange (BSE)                         |
      | BOX Exchange LLC (BOX)                              |
      | Cboe BYX Exchange, Inc. (CboeBYX)                   |
      | Cboe BZX Exchange, Inc. (CboeBZX)                   |
      | Cboe C2 Exchange, Inc. (C2)                         |
      | Cboe EDGA Exchange, Inc. (CboeEDGA)                 |
      | Cboe EDGX Exchange, Inc. (CboeEDGX)                 |
      | Cboe Exchange, Inc. (CBOE)                          |
      | Chicago Stock Exchange, Inc. (CHX)                  |
      | EDGA Exchange (EDGA)                                |
      | Investors Exchange LLC (IEX)                        |
      | ISE Gemini (ISEGemini)                              |
      | ISE Mercury (ISEMercury)                            |
      | Long-Term Stock Exchange, Inc. (LTSE)               |
      | MEMX LLC (MEMX)                                     |
      | Miami International Securities Exchange, LLC (MIAX) |
      | MIAX Emerald, LLC (EMERALD)                         |
      | MIAX PEARL, LLC (PEARL)                             |
      | Nasdaq BX, Inc. (BX)                                |
      | Nasdaq GEMX, LLC (GEMX)                             |
      | Nasdaq ISE, LLC (ISE)                               |
      | Nasdaq MRX, LLC (MRX)                               |
      | NASDAQ OMX PHLX                                     |
      | Nasdaq PHLX LLC (Phlx)                              |
      | New York Stock Exchange LLC (NYSE)                  |
      | NYSE Alternext US (NYSEALTR)                        |
      | NYSE American LLC (NYSEAMER)                        |
      | NYSE Amex (NYSEAmex)                                |
      | NYSE Arca (NYSEArca)                                |
      | NYSE Chicago, Inc. (NYSECHX)                        |
      | NYSE MKT (NYSEMKT)                                  |
      | The Nasdaq Stock Market LLC (NASDAQ)                |
      | Topaz Exchange (Topaz)                              |

  @api @javascript
  Scenario: Validate NSE Page Sorting of SEC Date
    Given I am on "/rules-regulations/national-securities-exchanges-rulemaking"
    Then "Jan 1, 2023" should precede "Jan 4, 2022" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan 4, 2022" should precede "Jul 1, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jul 1, 2021" should precede "Jan 3, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan 3, 2021" should precede "Jun 29, 2020" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jun 29, 2020" should precede "Jan 1, 2020" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
    When I click "sort by SEC Issue Date"
      And I wait 15 seconds
    Then "Jan 1, 2020" should precede "Jun 29, 2020" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jun 29, 2020" should precede "Jan 3, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan 3, 2021" should precede "Jul 1, 2021" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jul 1, 2021" should precede "Jan 4, 2022" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"
      And "Jan 4, 2022" should precede "Jan 1, 2023" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[2]"

  @api @javascript
  Scenario: Validate NSE Page Sorting of File Number
    Given I am on "/rules-regulations/national-securities-exchanges-rulemaking?sro_organization=All&title=&release_number=&file_number=&year=All&month=All&order=name&sort=desc"
    Then "bi-94-po" should precede "bi-93-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[3]"
      And "bi-93-po" should precede "bi-92-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[3]"
      And "bi-92-po" should precede "bi-90-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[3]"
    When I click "sort by File Number"
      And I wait 13 seconds
    Then "bi-90-po" should precede "bi-92-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[3]"
      And "bi-92-po" should precede "bi-93-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[3]"
      And "bi-93-po" should precede "bi-94-po" for the query "//*[@id='block-secgov-content']/div/div/table/tbody/tr[*]/td[3]"

  @api
  Scenario: NSE Pagination
    Given "rule" content:
        | title               | field_display_title  | field_file_number | body                             | field_related_rule                          | field_primary_division_office | moderation_state | status | field_sro_organization |
        | Behat Parent Rule 1 | Behat Parent Rule 7  | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      | Behat-sro-1            |
        | Behat Parent Rule 2 | Behat Parent Rule 8  | bi-91-po          | This is a parent rule overview 2 | Behat Draft Rule-Release 7                  | Behat-office 2                | published        | 1      | Behat-sro-2            |
        | Behat Parent Rule 3 | Behat Parent Rule 9  |                   | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      | Behat-sro-1            |
        | Behat Parent Rule 4 | Behat Parent Rule 10 | bi-92-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 0      | Behat-sro-2            |
        | Behat Parent Rule 5 | Behat Parent Rule 11 | bi-93-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      | Behat-sro-1            |
        | Behat Parent Rule 6 | Behat Parent Rule 12 | bi-94-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      | Behat-sro-2            |
        | Behat Parent Rule 1 | Behat Parent Rule 13 | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      | Behat-sro-1            |
        | Behat Parent Rule 2 | Behat Parent Rule 14 | bi-91-po          | This is a parent rule overview 2 | Behat Draft Rule-Release 7                  | Behat-office 2                | published        | 1      | Behat-sro-2            |
        | Behat Parent Rule 3 | Behat Parent Rule 15 |                   | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      | Behat-sro-1            |
        | Behat Parent Rule 4 | Behat Parent Rule 16 | bi-92-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 0      | Behat-sro-2            |
        | Behat Parent Rule 5 | Behat Parent Rule 17 | bi-93-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      | Behat-sro-1            |
        | Behat Parent Rule 6 | Behat Parent Rule 18 | bi-94-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      | Behat-sro-2            |
        | Behat Parent Rule 1 | Behat Parent Rule 19 | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      | Behat-sro-1            |
        | Behat Parent Rule 2 | Behat Parent Rule 20 | bi-91-po          | This is a parent rule overview 2 | Behat Draft Rule-Release 7                  | Behat-office 2                | published        | 1      | Behat-sro-2            |
        | Behat Parent Rule 3 | Behat Parent Rule 21 |                   | This is a parent rule overview 3 | Behat Interim Final Rule 3                  | Behat-office 3                | published        | 1      | Behat-sro-1            |
        | Behat Parent Rule 4 | Behat Parent Rule 22 | bi-92-po          | This is a parent rule overview 4 | Behat Final-Concept Rule 2                  | Behat-office 4                | published        | 0      | Behat-sro-2            |
        | Behat Parent Rule 5 | Behat Parent Rule 23 | bi-93-po          | This is a parent rule overview 5 | Behat Interpretive Rule 5                   | Behat-office 5                | published        | 1      | Behat-sro-1            |
        | Behat Parent Rule 6 | Behat Parent Rule 24 | bi-94-po          | This is a parent rule overview 6 | Behat Final Rule 6                          | Behat-office 6                | published        | 1      | Behat-sro-2            |
        | Behat Parent Rule 1 | Behat Parent Rule 25 | bi-90-po          | This is a parent rule overview 1 | Behat Proposed Rule 1, Behat Concept Rule 4 | Behat-office 1                | published        | 1      | Behat-sro-1            |
        | Behat Parent Rule 2 | Behat Parent Rule 26 | bi-91-po          | This is a parent rule overview 2 | Behat Draft Rule-Release 7                  | Behat-office 2                | published        | 1      | Behat-sro-2            |
    When I am on "/rules-regulations/national-securities-exchanges-rulemaking"
    Then I should see the text "Displaying 1 - 25 of 26"
      And I should see the link "1"
      And I should see the link "2"
      And I should see the link "Go to next page"
      And I should see the link "Go to last page"
    When I click "Go to last page"
    Then I should see the text "Displaying 26 - 26 of 26"
    When I click "First"
    Then I should see the text "Displaying 1 - 25 of 26"
