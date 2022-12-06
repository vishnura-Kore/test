@screen
Feature: Test all help link

  @tag1 @deploy
  Scenario: load help page object
    Given I load page object 'Help'

  @tag2
  Scenario: summary help
    And I wait for Page to Load
    Then I verify screenshot to Baseline of page 'Summary_page'

  Scenario Outline: Stroyboard help
    And I wait for Page to Load
    Then I wait for '3' seconds
    And I click '<value>'
    And I wait for Page to Load
    Then I wait for '3' seconds
    Then I verify screenshot to Baseline of page '<value>'

    Examples: 
      | value      |
      | storyboard |
      | Dialogtask |
      | KG         |
      | Alert      |
      | Smalltalk  |

  Scenario: click DigitalSkill
    And I click 'DigitalSkill'
    And I wait for Page to Load
    Then I wait for '3' seconds
    Then I verify screenshot to Baseline of page 'DigitalSkill'

  Scenario Outline: Digital help
    Then I wait for '2' seconds
    And I wait for Page to Load
    And I click '<value>'
    And I wait for Page to Load
    Then I wait for '3' seconds
    Then I verify screenshot to Baseline of page '<value>'

    Examples: 
      | value        |
      | digitalForms |
      | digitalView  |

  Scenario: click NL
    And I click 'NL'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page 'NL'

  Scenario Outline: NL help
    And I click '<value>'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page '<value>'

    Examples: 
      | value      |
      | Training   |
      | Thresholds |
      | Advsetting |

  Scenario: click Intelligence
    And I click 'intelligence'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page 'intelligence'

  Scenario Outline: Intelligence help
    And I click '<value>'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page '<value>'

    Examples: 
      | value                |
      | Event                |
      | Manage_interrupt     |
      | Amend_entity         |
      | multiIntentDetection |
      | sentimentManagement  |
      | standardResponses    |

  Scenario: click Testing
    And I click 'Testing'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page 'Testing'

  Scenario Outline: Testing help
    And I click '<value>'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page '<value>'

    Examples: 
      | value               | 
      | Testing_train       |
      | Batch_test          |
      | ConversationTesting |

  Scenario: click configurations
    And I click 'configurations'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page 'configurations'

  Scenario Outline: configurations help
    And I click '<value>'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page '<value>'

    Examples: 
      | value                            |
      | Gen_setting                      |
      | Lang                             |
      | PII                              |
      | Bot_fun                          |
      | authorization                    |
      | Msg_session                      |
      | Env_variable                     |
      | configurationsvariableManagement |
@deploy
  Scenario: Deploy-Channel
    And I click 'Deploy_menu'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page 'Deploy_menu'
@ignore
  Scenario: Publish
    And I click 'publish'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page 'publish'
@deploy
  Scenario: click Integrations
    And I click 'Integrations'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page 'Integrations'
@deploy
  Scenario Outline: Integrations help
    And I click '<value>'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page '<value>'

    Examples: 
      | value         | Check         |
      | webMobileSDK  | webmobile-sdk |
      | Manage_app    | manage-apps   |
      | API_score     | api-scopes    |
      | AgentTransfer | AgentTransfer |
      | Bot_kit       | Bot_kit       |
@deploy
  Scenario: click botManagement
    And I click 'botManagement'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page 'botManagement'
@deploy
  Scenario Outline: botManagement help
    And I click '<value>'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page '<value>'

    Examples: 
      | value        | Check             |
      | Bot_version  | bot-versions      |
      | ImportExport | import-amp-export |

  Scenario: Change_log
    And I click 'Change_log'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page 'Change_log'

  Scenario: Manage -Team
    Then I wait for '2' seconds
    And I wait '5' secs for Element 'Manage' be clickable
    And I mouse over and click 'Manage'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page 'Manage'

  Scenario: Plan_usage
    And I wait '5' secs for Element 'Plan_usage' be clickable
    And I mouse over and click 'Plan_usage'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page 'Plan_usage'

  Scenario: Invoices
    And I wait '5' secs for Element 'Invoices' be clickable
    And I mouse over and click 'Invoices'
    And I wait for Page to Load
    Then I wait for '4' seconds
    Then I verify screenshot to Baseline of page 'Invoices'
