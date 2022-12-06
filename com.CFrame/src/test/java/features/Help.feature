@Help
Feature: Test all help link

  @tag1
  Scenario: load help page object
    Given I load page object 'Help'

  @tag2
  Scenario: summary help
    And I wait for Page to Load
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
    And Validate all Links

  Scenario Outline: Stroyboard help
    And I switch back to default content
    Then I click 'Help_close'
    And I wait for Page to Load
    Then I wait for '3' seconds
    And I click '<value>'
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
    And Validate all Links

    Examples: 
      | value      |
      | storyboard |
      | Dialogtask |
      | KG         |
      | Alert      |
      | Smalltalk  |

  Scenario: click DigitalSkill
    And I switch back to default content
    Then I click 'Help_close'
    And I wait for Page to Load
    And I click 'DigitalSkill'
    Then I wait for '2' seconds
    And I click 'help_icon'

  Scenario Outline: Digital help
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I wait for Page to Load
    And I click '<value>'
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
    And Validate all Links

    Examples: 
      | value        |
      | digitalForms |
      | digitalView  |

  Scenario: click NL
    And I switch back to default content
    Then I click 'Help_close'
    And I wait for Page to Load
    And I click 'NL'
    Then I wait for '2' seconds
    And I click 'help_icon'

  Scenario Outline: NL help
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I wait for Page to Load
    And I click '<value>'
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
    And Validate all Links

    Examples: 
      | value      |
      | Training   |
      | Thresholds |
      | Advsetting |

  Scenario: click Intelligence
    And I switch back to default content
    Then I click 'Help_close'
    And I wait for Page to Load
    And I click 'intelligence'
    Then I wait for '2' seconds
    And I click 'help_icon'

  Scenario Outline: Intelligence help
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I wait for Page to Load
    And I click '<value>'
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
    And Validate all Links

    Examples: 
      | value                |
      | Event                |
      | Manage_interrupt     |
      | Amend_entity         |
      | multiIntentDetection |
      | sentimentManagement  |
      | standardResponses    |

  Scenario: click Testing
    And I switch back to default content
    Then I click 'Help_close'
    And I wait for Page to Load
    And I click 'Testing'
    Then I wait for '2' seconds
    And I click 'help_icon'

  Scenario Outline: Testing help
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I wait for Page to Load
    And I click '<value>'
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
    And Validate all Links

    Examples: 
      | value               |
      | Testing_train       |
      | Batch_test          |
      | ConversationTesting |

  Scenario: click configurations
    And I switch back to default content
    Then I click 'Help_close'
    And I wait for Page to Load
    And I click 'configurations'
    Then I wait for '2' seconds
    And I click 'help_icon'

  Scenario Outline: configurations help
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I wait for Page to Load
    And I click '<value>'
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
    And Validate all Links

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

  Scenario: Deploy-Channel
      And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I click 'Deploy_menu'
    And I wait for Page to Load
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
        Then I wait for '2' seconds
    And I should see element with ID 'channels' present on page
    And Validate all Links

  Scenario: Publish
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I click 'publish'
    And I wait for Page to Load
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
            Then I wait for '2' seconds
    And I should see element with ID 'publish' present on page
    And Validate all Links

  Scenario: click Integrations
    And I switch back to default content
    Then I click 'Help_close'
    And I wait for Page to Load
    And I click 'Integrations'
    Then I wait for '2' seconds
    And I click 'help_icon'

  Scenario Outline: Integrations help
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I wait for Page to Load
    And I click '<value>'
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
                Then I wait for '2' seconds
    And I should see element with ID '<Check>' present on page
    And Validate all Links

    Examples: 
      | value         |Check|
      | AgentTransfer |agent-transfer|
      | Bot_kit       |botkit|
      | webMobileSDK  |webmobile-sdk|
      | Manage_app    |manage-apps|
      | API_score     |api-scopes|

  Scenario: click botManagement
    And I switch back to default content
    Then I click 'Help_close'
    And I wait for Page to Load
    And I click 'botManagement'
    Then I wait for '2' seconds
    And I click 'help_icon'

  Scenario Outline: botManagement help
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I wait for Page to Load
    And I click '<value>'
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
                    Then I wait for '2' seconds
    And I should see element with ID '<Check>' present on page
    And Validate all Links

    Examples: 
      | value        |Check|
      | Bot_version  |bot-versions|
      | ImportExport |import-amp-export|


  Scenario: Change_log
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I click 'Change_log'
    And I wait for Page to Load
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
    Then I wait for '2' seconds
    And I should see element with ID 'change-logs' present on page
    And Validate all Links

  Scenario: Manage -Team
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I wait '5' secs for Element 'Manage' be clickable
    And I mouse over and click 'Manage'
    And I wait for Page to Load
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
    Then I wait for '2' seconds
    And I should see element with ID 'team' present on page
    And Validate all Links

  Scenario: Plan_usage
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I wait '5' secs for Element 'Plan_usage' be clickable
    And I mouse over and click 'Plan_usage'
    And I wait for Page to Load
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
    Then I wait for '2' seconds
    And I should see element with ID 'plan-amp-usage' present on page
    And Validate all Links

  Scenario: Invoices
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I wait '5' secs for Element 'Invoices' be clickable
    And I mouse over and click 'Invoices'
    And I wait for Page to Load
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
    Then I wait for '2' seconds
    And I should see element with ID 'invoices' present on page
    And Validate all Links

  Scenario Outline: Analyze help
    And I switch back to default content
    Then I click 'Help_close'
    Then I wait for '2' seconds
    And I wait '2' secs for Element 'Analyze' be clickable
    And I mouse over and click 'Analyze'
    And I wait for Page to Load
    And I click '<value>'
    And I click 'help_icon'
    Then I wait for '5' seconds
    Then I click 'Topic_guide'
    And I switch to iFrame 'HelpFrame'
    Then I wait for '2' seconds
    And I should see element with ID '<Check>' present on page
    And Validate all Links

    Examples: 
      | value               | Check                   |
      | Conversations_Dash  | conversations-dashboard |
      | Performance_Dash    | performance-dashboard   |
      | Custom_Dash         | custom-dashboards       |
      | Conversation_flow   | conversation-flows      |
      | NLP_Metrics         | nlp-metrics             |
      | Usage_Metrics       | usage-metrics           |
      | Containment_Metrics | containment-metrics     |
