Feature: Person View Page
  As a Site Visitor, the user should be able to view list pages available on SEC.gov

@ui @api @javascript @wdio
Scenario: Person Related Speech, Testimony, Statement and Press Releases Blocks
  Given "secperson" content:
    | title      | field_first_name_secperson | field_last_name_secperson | body                                                                               | field_bottom_center_column_perso | field_description_abstract_perso | field_left_nav_override |field_enable_biography_page | status |
    | John Behat | John                       | Behat                     | John started working with behat in 2033 and has been maintaining behat ever since. | This is the bottom center column | This is the descroption/abstract | Enforcement             | 1                          | 1      |
    And I create "media" of type "static_file":
    | name       | field_media_file       | status |
    | Behat File | behat-file_corpfin.pdf | 1      |
    And "news" content:
    | field_news_type_news | field_primary_division_office | title           | status | field_description_abstract     | field_display_title             | field_publish_date  | field_person | field_media_file_upload | body         |
    | Speech               | Agency-wide                   | Speech 1        | 1      | Speech by Behat Tester         | Speech 1 by Behat Tester        | 2034-11-11 12:00:00 | John Behat   | Behat File              |              |
    | Speech               | Agency-wide                   | Speech 2        | 1      | Speech by Behat Tester         | Speech 2 by Behat Tester        | 2034-12-01 12:00:00 | John Behat   | Behat File              | this is body |
    | Speech               | Agency-wide                   | Speech 3        | 1      | Speech by Behat Tester         | Speech 3 by Behat Tester        | 2033-06-13 16:00:00 | John Behat   | Behat File              |              |
    | Speech               | Agency-wide                   | Speech 4        | 1      | Speech by Behat Tester         | Speech 4 by Behat Tester        | 2032-12-19 12:00:00 | John Behat   | Behat File              |              |
    | Speech               | Agency-wide                   | Speech 5        | 1      | Speech by Behat Tester         | Speech 5 by Behat Tester        | 2032-06-13 16:00:00 | John Behat   | Behat File              |              |
    | Testimony            | Agency-wide                   | Testimony 1     | 1      | Testimony by Behat Tester      | Testimony 1 by Behat Tester     | 2034-05-12 11:00:00 | John Behat   | Behat File              |              |
    | Testimony            | Agency-wide                   | Testimony 2     | 1      | Testimony by Behat Tester      | Testimony 2 by Behat Tester     | 2034-07-10 12:00:00 | John Behat   | Behat File              | this is body |
    | Testimony            | Agency-wide                   | Testimony 3     | 1      | Testimony by Behat Tester      | Testimony 3 by Behat Tester     | 2034-06-13 12:00:00 | John Behat   | Behat File              |              |
    | Statement            | Agency-wide                   | Pub Statement 1 | 1      | Statement by Behat Tester      | Statement 1 by Behat Tester     | 2034-09-11 12:00:00 | John Behat   | Behat File              |              |
    | Statement            | Agency-wide                   | Pub Statement 2 | 1      | Statement by Behat Tester      | Statement 2 by Behat Tester     | 2034-10-10 12:00:00 | John Behat   | Behat File              | this is body |
    | Statement            | Agency-wide                   | Pub Statement 3 | 1      | Statement by Behat Tester      | Statement 3 by Behat Tester     | 2033-06-13 12:00:00 | John Behat   | Behat File              |              |
    | Statement            | Agency-wide                   | Pub Statement 4 | 1      | Statement by Behat Tester      | Statement 4 by Behat Tester     | 2034-07-11 12:00:00 | John Behat   | Behat File              |              |
    | Press Release        | Agency-wide                   | Press release 1 | 1      | Press release by Behat Tester  | Press release 1 by Behat Tester | 2034-03-11 12:00:00 | John Behat   | Behat File              |              |
    | Press Release        | Agency-wide                   | Press release 2 | 1      | Press release by Behat Tester  | Press release 2 by Behat Tester | 2034-06-10 12:00:00 | John Behat   | Behat File              | this is body |
    | Press Release        | Agency-wide                   | Press release 3 | 1      | Press release by Behat Tester  | Press release 3 by Behat Tester | 2033-06-13 12:00:00 | John Behat   | Behat File              |              |
    | Press Release        | Agency-wide                   | Press release 4 | 1      | Press release by Behat Tester  | Press release 4 by Behat Tester | 2034-07-11 12:00:00 | John Behat   | Behat File              |              |
   And "secarticle" content:
    | field_article_type_secarticle | field_article_sub_type_secart | moderation_state | title               | field_display_title               | status | body             | field_primary_division_office | field_person | field_publish_date  |
    | Staff Papers                  | Data-MarketStructure          | published        | Behat for Article 1 | This is the BEHAT display title 1 | 1      | This is the body | Corporation Finance           | John Behat   | 2035-11-11 12:00:00 |
    | Staff Papers                  | Data-MarketStructure          | published        | Behat for Article 2 | This is the BEHAT display title 2 | 1      | This is the body | Corporation Finance           | John Behat   | 2034-08-11 12:00:00 |
   And "secarticle" content:
    | title               | field_display_title | field_list_page_det_secarticle   | field_publish_date     | status | field_article_type_secarticle| field_primary_division_office | field_tags            | field_person | field_media_file_upload |
    | Behat Publication 0 | Behat Test 0        | The Sky is Gray Publication      | 2040-05-17T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | Insider Trading       | John Behat   | Behat File              |
    | Behat Publication 1 | Behat Test 1        | The Sky is Blue Publication      | 2039-07-15T17:00:00    | 1      | Academic Publications        | Economic and Risk Analysis    | DERA Newsletter       | John Behat   | Behat File              |
  Then I take a screenshot on "sec" using "persons.feature" file with "@person_page" tag
