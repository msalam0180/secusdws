Feature: Utilizing Layout Builder
  As a sitebuilder or above user can use Layout Builder to SEC.gov
  I want to be able to view content that allows for layouts
  So that I quickly change the section and/or blocks

  @api
  Scenario Outline: Adding In-line Custom Block
    Given I am logged in as a user with the "sitebuilder" role
      And "<content_type>" content:
      | title  |
      | BEHAT  |
    When I am on "/<url>/layout"
      And I click "Add block"
      And I click "Create custom block"
      And I click "Basic block"
      And I fill in "Title" with "Behat Testing Block"
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I click on the element with css selector "#edit-submit"
    Then I should see the text "Behat Testing Block"

    Examples:
      | content_type | url             |
      | landing_page | page/behat      |
      | secperson    | biography/behat |

  @api
  Scenario Outline: Multiple Sections
    Given I am logged in as a user with the "sitebuilder" role
      And "<content_type>" content:
      | title  |
      | BEHAT  |
    When I am on "/<url>/layout"
      And I click "Add section"
    Then I should see the link "One column"
      And I should see the link "Two column"
      And <extra_step>

    Examples:
      | content_type | url             | extra_step                                |
      | landing_page | page/behat      | I should see the link "Hero Landing Page" |
      | secperson    | biography/behat | I should see the link "Three column"      |

  @api @javascript
  Scenario Outline: Add and Remove Sections
    Given I am logged in as a user with the "sitebuilder" role
      And "<content_type>" content:
      | title  |
      | BEHAT  |
    When I am on "/<url>/layout"
      And I click "Add section"
      And I click "Three column"
      And I press "Add section"
    Then I should see "in Section 1, First region"
      And I should see "in Section 1, Second region"
      And I should see "in Section 1, Third region"
    When I click "Remove Section 1"
      And I press "Remove"
    Then I should not see "in Section 1, First region"
      And I should not see "in Section 1, Second region"
      And I should not see "in Section 1, Third region"

    Examples:
      | content_type | url             |
      | landing_page | page/behat      |
      | secperson    | biography/behat |

  @api
  Scenario Outline: Revert Changes of Custom Block
    Given I am logged in as a user with the "sitebuilder" role
      And "<content_type>" content:
      | title |
      | BEHAT |
    When I am on "/<url>/layout"
      And I click "Add block"
      And I click "Create custom block"
      And I click "Basic block"
      And I fill in "Title" with "Behat Testing Block"
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I click on the element with css selector "#edit-submit"
    Then I should see the text "Behat Testing Block"
    When I visit "/<url>/layout"
      And I click on the element with css selector "#edit-revert"
      And I click on the element with css selector "#edit-submit"
    Then I should not see the text "Behat Testing Block"

    Examples:
      | content_type | url             |
      | landing_page | page/behat      |
      | secperson    | biography/behat |

  @api @javascript
  Scenario: Removing Custom Block Using Quick Edit
    Given I am logged in as a user with the "sitebuilder" role
      And I create "node" of type "landing_page":
      | title            |
      | BEHAT basic page |
    When I am on "/page/behat-basic-page/layout"
      And I wait for ajax to finish
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Basic block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Block"
      And I type "Detail body of custom block" in the "Body" WYSIWYG editor
      And I wait for ajax to finish
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I wait for ajax to finish
      And I click on the element with css selector "#edit-submit"
    Then I should see the text "Behat Testing Block"
      And I should see the text "Detail body of custom block"
    When I visit "/page/behat-basic-page/layout"
      And I scroll "//*[@id='layout-builder']/div[2]/div/div[1]/div[3]/div/div/h2" into view
      And I hover over the element "#layout-builder > div:nth-child(2) > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.region__inner.basic > div > div > h2"
      And I wait 2 seconds
      And I click on the element with css selector "#layout-builder > div:nth-child(2) > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.region__inner.basic > div > div > div.contextual > ul > li:nth-child(4) > a"
      And I wait 2 seconds
      And I press "Remove"
      And I click on the element with css selector "input[id^='edit-submit']"
    Then I should not see the text "Behat Testing Block"
      And I should not see the text "Detail body of custom block"

  @api @javascript
  Scenario: Move Custom Blocks Order Block To Landing Page
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title            |
      | BEHAT basic page |
    When I am on "/page/behat-basic-page/layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Basic block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Block 1"
      And I type "body 1 sdfuoisf" in the "Body" WYSIWYG editor
      And I wait for ajax to finish
      And I scroll to the top
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I wait for ajax to finish
      And I click "Add block"
      And I wait for ajax to finish
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Basic block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Block 2"
      And I type "body 2" in the "Body" WYSIWYG editor
      And I wait for ajax to finish
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I wait for ajax to finish
    Then "Behat Block 1" should precede "Behat Block 2" for the query "//h2"
    When I hover over the element "#layout-builder > div.layout-builder__section > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.region__inner.basic > div"
      And I wait 2 seconds
      And I click on the element with css selector "#layout-builder > div.layout-builder__section > div > div > div.js-layout-builder-block.layout-builder-block.contextual-region.block.region__inner.basic > div > div > div.contextual > ul > li:nth-child(2) > a"
      And I wait 2 seconds
      And I press "Show row weights"
      And I wait 1 seconds
      And I select "1" from "Behat Block 2"
      And I press "Move"
    Then "Behat Block 2" should precede "Behat Block 1" for the query "//h2"

  @api @javascript
  Scenario: Adding Text to Custom Content Block On Landing Page And Hide Display Title
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title            |
      | BEHAT basic page |
    When I am on "/page/behat-basic-page/layout"
      And I click "Add block"
      And I wait 2 seconds
      And I click "Create custom block"
      And I wait for ajax to finish
      And I click "Basic block"
      And I wait for ajax to finish
      And I fill in "Title" with "Behat Testing Block"
      And I type "Detail body of custom block" in the "Body" WYSIWYG editor
      And I uncheck "Display title"
      And I wait for ajax to finish
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I wait for ajax to finish
      And I click on the element with css selector "#edit-submit"
      And I wait for ajax to finish
    Then I should not see the text "Behat Testing Block"
      And I should see the text "Detail body of custom block"

  @api @javascript
  Scenario: Editing Custom Block On Landing Page
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title            |
      | BEHAT basic page |
    When I am on "/block/add"
      And I click "Basic block"
      And I wait for ajax to finish
      And I fill in "Block description" with "Behat content Block"
      And I type "Detail body of custom block" in the "Body" WYSIWYG editor
      And I press "Save"
      And I am on "/page/behat-basic-Page/layout"
      And I click "Add block"
      And I wait for ajax to finish
      And I fill in "Filter by block name" with "Behat"
      And I click "Behat content Block" in the "landingpage_blocks" region
      And I wait for ajax to finish
      And I press the "Add block" button
      And I wait for ajax to finish
      And I click on the element with css selector "#edit-submit"
    Then I should see the text "Behat content Block"
      And I should see the text "Detail body of custom block"
    When I am on "/admin/structure/block/block-content"
      And I click "Edit" in the "Behat content Block" row
      And I type "Updated Body" in the "Body" WYSIWYG editor
      And I press "Save"
      And I wait 1 seconds
      And I visit "/page/behat-basic-Page"
    Then I should see the text "Updated Body"
    When I am on "/admin/structure/block/block-content"
      And I wait 1 seconds
      And I click "Edit" in the "Behat content Block" row
      And I click on the element with css selector "#edit-delete"
      And I press "Delete"
    Then I should see the text "The custom block Behat content Block has been deleted."

  @api
  Scenario Outline: Confirm Permissions to Access Layout Builder
    Given "landing_page" content:
      | title            |
      | BEHAT basic page |
      And "secperson" content:
      | title      |
      | John Behat |
    When I am logged in as a user with the "<role>" role
      And I am on "/page/behat-basic-page/edit"
    Then I should <results> the link "Layout"
    When I am on "/biography/john-behat/edit"
    Then I should <results> the link "Layout"

    Examples:
      | role                     | results |
      | Individual Defendants    | not see |
      | Authenticated user       | not see |
      | Content Creator          | not see |
      | Content Approver         | not see |
      | Division/Office Admin    | not see |
      | Webform, Content Creator | not see |
      | sitebuilder              | see     |
      | Administrator            | see     |

  @api
  Scenario Outline: Adding Custom Blocks
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title            |
      | BEHAT basic page |
    When I am on "/page/behat-basic-Page/layout"
      And I click "Add block"
      And I click "<custom_block>"
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I press "Save"
    Then I should see the text "<custom_block>"

    Examples:
      | custom_block                                                        |
      | About the IDD                                                       |
      # List of all Custom Blocks at the time of testing. This will greatly increase testing time. Uncomment below on Regression.
      # Missing blocks are DERA and block names with "|" in the title.
      # | Accessing EDGAR Data                                                |
      # | Accounts and Audits Enforcement Releases Topper                     |
      # | ADI Right Content                                                   |
      # | ALJ - Introduction                                                  |
      # | ALJ - Quick Links                                                   |
      # | ARO Morehouse College Event Button                                  |
      # | Block Testing                                                       |
      # | Careers: Left Block                                                 |
      # | Careers: Right Block                                                |
      # | Careers: Right Image Block                                          |
      # | Chairman Jay Clayton's Accomplishments                              |
      # | Contact Information                                                 |
      # | Contact Us                                                          |
      # | CorpFin: About Intro                                                |
      # | Corpfin: Career Opportunities                                       |
      # | Corpfin: Contact us                                                 |
      # | Corpfin: Current Topics                                             |
      # | Corpfin: Filing & Disclosure                                        |
      # | Corpfin: Information for Special                                    |
      # | Corpfin: Quick Links                                                |
      # | Corpfin: Search on Edgar                                            |
      # | CorpFin: Staff Guidance & Intepretations                            |
      # | Corpfin: What's new                                                 |
      # | Corporation Finance Manual Search Block                             |
      # | Credit Rating / View Rules Combo Button Block                       |
      # | Credit Rating Agencies / Final Rules Combo Button                   |
      # | Custom Title for Featured Spotlight                                 |
      # | Cybersecurity                                                       |
      # | d                                                                   |
      # | DAI Submit Question                                                 |
      # | Delinquent Filings Topper                                           |
      # | DERA: Financial Statement Data Sets                                 |
      # | DERA: Intro About                                                   |
      # | DERA: Quick Links/Upcoming                                          |
      # | DERA: Speeches                                                      |
      # | DERA: Twitter                                                       |
      # | DERA: Twitter2                                                      |
      # | DERA Standard Tax 1                                                 |
      # | DERA Standard Tax 2                                                 |
      # | DERA_DataLibraryDisclaimer                                          |
      # | DERA_DataLibraryIntro                                               |
      # | DERA_Edgar-Legend                                                   |
      # | DERA_EdgarLogFileFAQ                                                |
      # | DERA_Financial-Reporting                                            |
      # | DERA_FlyoutTEST                                                     |
      # | DERA_FormD                                                          |
      # | DERA_Fund-Reporting                                                 |
      # | DERA_Market-Participants                                            |
      # | DERA_Offering-Data                                                  |
      # | DERA_Other-Research-Links                                           |
      # | DERA_RegulationA                                                    |
      # | Developer Resources: Contact Us                                     |
      # | Digital Asset Guidance Block                                        |
      # | EDGAR Quick Links                                                   |
      # | EEO Introduction                                                    |
      # | EEO No Fear Act                                                     |
      # | Enforce About                                                       |
      # | Enforcement: Enforcement Actions                                    |
      # | Enforcement: Important Links                                        |
      # | Enforcement: Intro About                                            |
      # | Enforcement: Quick Links                                            |
      # | Enforcement: Tips & Complaints                                      |
      # | Enforcement: Twitter                                                |
      # | Ethics Introduction                                                 |
      # | Ethics Links and Contact Information                                |
      # | Exam Hotline                                                        |
      # | Fair Access                                                         |
      # | FFB: Accordion                                                      |
      # | FFB: Intro About                                                    |
      # | FFB: Right                                                          |
      # | FOIA: Left column                                                   |
      # | FOIA Other Resources                                                |
      # | Global Footer: Stay Connected Footer                                |
      # | Global Header: DigitalGov Search                                    |
      # | GovDelivery                                                         |
      # | Homepage: Administrative Proceedings Text                           |
      # | Homepage: Ask a Question or Report a Problem                        |
      # | Homepage: Featured Video                                            |
      # | Homepage: Hero                                                      |
      # | Homepage: Litigation Releases Text                                  |
      # | Homepage: Money Market Fund Statistics Block                        |
      # | Homepage: Notices and Orders                                        |
      # | Homepage: Protect Your Money                                        |
      # | Homepage: Public Comments                                           |
      # | Homepage: Recent Edgar Filings Text                                 |
      # | Homepage: Recent Proposed Rules Text                                |
      # | Homepage: Reporting Securities Fraud                                |
      # | Homepage: SEC Mission                                               |
      # | Homepage: SEC Stories                                               |
      # | Homepage: Section 1 Title                                           |
      # | Homepage: Section 2 Title                                           |
      # | Homepage: Section 3 Title                                           |
      # | Homepage: Section 4 Title                                           |
      # | Homepage: Section 5 Title                                           |
      # | Homepage: Section 6 Title                                           |
      # | Homepage: Spotlight block with no background                        |
      # | Homepage: Spotlight block with white background                     |
      # | Homepage: View Final Rules                                          |
      # | Homepage: We Inform and Protect Investors Spotlight                 |
      # | Homepage: We Provide Data                                           |
      # | Homepage: We Provide Data Spotlight Block                           |
      # | Homepage: Whistleblowing Provisions                                 |
      # | Homepage: XBRL                                                      |
      # | Hompage: Investor Alert                                             |
      # | IDD Placeholder Block: DO NOT DELETE                                |
      # | IM: Action Center                                                   |
      # | IM: Intro About                                                     |
      # | IM: Latest News                                                     |
      # | IM: Laws & Rules                                                    |
      # | IM: Quick Links                                                     |
      # | IM: Regulatory Action                                               |
      # | IM: Resources                                                       |
      # | Information For - temp                                              |
      # | Investor Advocate Introduction                                      |
      # | Investor Advocate Right Side                                        |
      # | Landing Page Instructions                                           |
      # | Latest News - temp                                                  |
      # | Market Statistics Disclaimer                                        |
      # | Market Statistics Search                                            |
      # | Media Story                                                         |
      # | Municipal: Tabs                                                     |
      # | Municipal Introduction                                              |
      # | Municipal Right Side                                                |
      # | Need Help?                                                          |
      # | Newsroom: Media Kit                                                 |
      # | OACQ Doing Business with SEC                                        |
      # | OACQ Introduction                                                   |
      # | OACQ Solicitations                                                  |
      # | OACQ Whistleblower Protection                                       |
      # | OCA: Intro About                                                    |
      # | OCA: Office Groups                                                  |
      # | OCA: Right Block                                                    |
      # | OCIE: Anti-Money Laundering                                         |
      # | OCIE: Compliance Outreach                                           |
      # | OCIE: Electronic FTP                                                |
      # | OCIE: Email Updates                                                 |
      # | OCIE: Examination Related Forms                                     |
      # | OCIE: Intro About                                                   |
      # | OCIE: Left Column                                                   |
      # | OCIE: Office Resources                                              |
      # | OCIE: Potential SEC Shutdown                                        |
      # | OCIE GovDelivery Signup                                             |
      # | OCIE Intro                                                          |
      # | OCOO Introduction                                                   |
      # | OCOO Office Information and Resources                               |
      # | OCOO Organization                                                   |
      # | OCR: Division Resources                                             |
      # | OCR: Elsewhere                                                      |
      # | OCR: Examination Resources                                          |
      # | OCR: Intro About                                                    |
      # | OCR: Right Sidebar                                                  |
      # | OCR Left Column                                                     |
      # | OFM - Introduction                                                  |
      # | OFM - Related Links                                                 |
      # | OGC Introduction                                                    |
      # | OHR: Right                                                          |
      # | OHR Introduction                                                    |
      # | OHR Related Materials                                               |
      # | OIA: Cooperative Arrangements with Foreign Regulators               |
      # | OIA: International Enforcement Assistance                           |
      # | OIA: International Regulatory Policy                                |
      # | OIA: Intro About                                                    |
      # | OIEA Contact Information                                            |
      # | OIEA Introduction                                                   |
      # | OIEA Related Links                                                  |
      # | OIG: Intro About                                                    |
      # | OIG: Overview Tabs                                                  |
      # | OIG: Submit a Complaint                                             |
      # | OIG: Whistlerblower                                                 |
      # | OIT Introduction                                                    |
      # | OLIA Introduction                                                   |
      # | OMWI Contact Information                                            |
      # | OMWI Introduction                                                   |
      # | OPA Introduction                                                    |
      # | OPA Press Contacts                                                  |
      # | OSD GovDelivery                                                     |
      # | OSD Introduction                                                    |
      # | OSD Previous Trends                                                 |
      # | OSD Trends Links                                                    |
      # | OSD_previousTrends                                                  |
      # | OS Introduction                                                     |
      # | OS Rulemaking Releases                                              |
      # | Other Developer Resources                                           |
      # | Other Videos                                                        |
      # | Placeholder: Demo                                                   |
      # | Placeholder: Image                                                  |
      # | Promo Block: SEC Headquarters                                       |
      # | Proposed and Final Rules and Credit Rating Agencies Buttons Block   |
      # | Proposed Rules / Final Rules / Credit Rating Agencies Buttons Block |
      # | Quick Links                                                         |
      # | Regional Office Map                                                 |
      # | Request for Public Comment - temp                                   |
      # | Right Sidebar Instructions                                          |
      # | Secspotlight-Military: Military Outreach Header                     |
      # | Spotlight - temp                                                    |
      # | Spotlight: About the acts block                                     |
      # | Spotlight: Event Details block                                      |
      # | Spotlight: graphic banner for 75th Anniversary                      |
      # | Spotlight: Intro detail page                                        |
      # | Spotlight: right side bar                                           |
      # | Subscribe to E-mail Alerts                                          |
      # | Test                                                                |
      # | TM Division Information and Resources                               |
      # | TM Introduction                                                     |
      # | TM Quicklinks                                                       |
      # | Troubleshooting                                                     |
      # | Upcoming Events: Header                                             |
      # | Updated Behat content Block One more time                           |
      # | Women of Color Entrepreneurs                                        |

  @api
  Scenario Outline: Adding SEC Custom Blocks
    Given I am logged in as a user with the "sitebuilder" role
      And "landing_page" content:
      | title            |
      | BEHAT basic page |
    When I am on "/page/behat-basic-Page/layout"
      And I click "Add block"
      And I click "<custom_block>"
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I press "Save"
    Then I should see the text "<custom_block>"

    Examples:
      | custom_block                             |
      | Adiministrative Proceedings              |
      # List of all Custom Blocks at the time of testing. This will greatly increase testing time. Uncomment below on Regression.
      # | Administrative Proceedings Button        |
      # | Cyber Enforcement Actions Button         |
      # | Developer Resources                      |
      # | DigitalGov Global Search                 | This is for new theme only
      # | EDGAR Search                             |
      # | Edgar Search Tools block                 | Needs to change "Save" to "Add block"
      # | Home Email Update                        |
      # | Litigation Releases                      |
      # | OASB Capital Raising Map                 |
      # | Public Comments Final Rules Combo Button |
      # | Regulate Securities Buttons              |
      # | SEC Mission                              |
      # | Submit a Tip Button                      |

  @api
  Scenario Outline: Validating Default Blocks on Person Details Page
    Given "secperson" content:
      | title      | field_first_name_secperson | field_last_name_secperson |
      | John Behat | John                       | Behat                     |
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/biography/john-behat/layout"
    Then I should see the text "<news_block>"

    Examples:
      | news_block                             |
      | Photo                                  |
      | Person - Position History              |
      | Body                                   |
      | Bottom Center Column                   |
      | Speaker Webcasts: Live Webcasts        |
      | Speaker Webcasts: Upcoming Webcasts    |
      | Person Related Speeches and Statements |
      | Person Related Press Releases          |
      | Person Related Staff Papers            |
      | Person Related Academic Publications   |
    #bug in line 523 & 524 (OSSS-22295)

  @api
  Scenario Outline: Adding Custom Blocks on Person Details Page
    Given "secperson" content:
      | title      | field_first_name_secperson | field_last_name_secperson |
      | John Behat | John                       | Behat                     |
    When I am logged in as a user with the "sitebuilder" role
      And I am on "/biography/john-behat/layout"
      And I click "Add block"
      And I click "<custom_news_block>"
      And I click on the element with css selector "input[id^='edit-actions-submit']"
      And I press "Save"
    Then I should see the text "<custom_news_block>"

    Examples:
      | custom_news_block                |
      | Person Related Public Statements |
      | Person Related Testimonials      |
