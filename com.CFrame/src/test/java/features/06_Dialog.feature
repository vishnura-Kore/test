@Dialog @Kore @9.1
Feature: Dialog
  I want to use this template for my feature file

  @9.1
  Scenario: Navigating to Dialog Tasks
    Given I load page object 'Dialog'
    And I wait '10' secs for Element 'Dialog_menu' be clickable
    And I click 'Dialog_menu'
    Then I wait '20' seconds for presence of element 'Dialog_task_title'

  @9.1
  Scenario: User should be able to Create a Dialog
    When I wait for '10' seconds
    And I click 'create_dialog_button'
    Then I should see text 'Create Dialog' present on page
    When I enter 'Check Balance' in field 'intent_name'
    And I enter 'To get account balance' in field 'intent_description'
    And I wait '10' secs for Element 'dialog_proceed_button' be clickable
    And I click 'dialog_proceed_button'
    And I wait for '5' seconds
    Then I switch to iFrame 'DialogFrame'
    #Then I wait '10' seconds for presence of element 'Dialog_welcome'
    #And I click 'Welcome_next'
    #Then I should see text 'Drag & Drop Nodes to Canvas' present on page
    #And I click 'Welcome_next'
    #Then I should see text 'Introducing Bot Action' present on page
    #And I click 'Welcome_next'
    #Then I should see text 'Collaborate with Comments' present on page
    #And I click 'Welcome_next'
    #Then I should see text 'Group Node' present on page
    #And I click 'Welcome_next'
    #Then I should see text 'Find me !' present on page
    #And I click 'Welcome_close'
    And I wait '10' seconds for presence of element 'Message_menu'
    And I should see element 'CheckBalance_title' present on page
    And I should see element 'check_header_intent' present on page
    And I click 'Add_node'
    Then I mouse over element with text 'Entity ' and click
    Then I mouse over element with text '+ New Entity' and click
    And I should see element with text 'Component Properties' present on page
    And I enter 'account_id' in field 'Node_name'
    And I enter 'Account id' in field 'Node_display'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'
    #Then I click 'Entity_type'
    And I select element 'Number' from Dropdown 'Entity_type'
    #And I enter 'Number' in field 'EntityTyp_search'
    #Then I click 'Number'
    And I should see element with text 'String will be changed to Number' present on page
    And I click 'OK'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'
    And I scroll to element 'User_prompt'
    Then I mouse over and click 'User_prompt'
    And I enter 'Please enter your Account ID' in field 'User_prompt'
    And I wait for '2' seconds
    And I send key pageUp/pageDown/ESC/Enter/Tab 'Tab'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'
    Then I mouse over and click 'Manage_msg'
    And I should see element with text 'Manage User Prompts' present on page
    And I should see element 'Add_user_prompt' present on page
    #And I wait for '1' seconds
    #Then I mouse over and click 'Add_user_prompt'
    #And I wait for '1' seconds
    #And I should see element with text 'Sample Message' present on page
    #And I should see element 'Select_channel' present on page
    #Then I click 'Select_channel'
    #And I wait for '1' seconds
    #And I should see element 'Email_channel' present on page
    #And I click 'Email_channel'
    #And I enter 'Please send your Account ID in Email' in field 'Channel_prompt_msg'
    #Then I mouse over element with text 'Save' and click
    #And I should see element 'check_sendbyemail' present on page
    And I should see element 'Back_arrow_left' present on page
    Then I click 'Back_arrow_left'

  @9.1
  Scenario: Set  default_try
    And I should see element 'Check_entity' present on page
    Then I mouse over and click 'Instance_prop'
    And I scroll to element 'default_try'
    Then I click 'default_try'
    And I click 'Select_3'

  @Add_Confirmation
  Scenario: Add Confirmation
    And I click 'Add_node'
    Then I mouse over element with text 'Confirmation ' and click
    Then I mouse over element with text '+ New Confirmation' and click
    And I should see element with text 'Confirmation' present on page
    And I enter 'acct_id_conf' in field 'Node_name'
    And I enter 'Confirmation Account id' in field 'Node_display'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'
    And I scroll to element 'User_prompt'
    Then I mouse over and click 'User_prompt'
    And I enter 'Are you sure you want to proceed with Acc id-{{context.entities.Entity0024}}?' in field 'User_prompt'
    And I wait for '1' seconds
    And I send key pageUp/pageDown/ESC/Enter/Tab 'Tab'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'
    And I click 'Yes_radio'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'
    And I wait for '1' seconds
    Then I mouse over and click 'Connections'
    Then I wait '10' seconds for presence of element 'Connections_title'
    And I wait for '10' seconds
    And I scroll to element 'If_context'
    Then I mouse over 'If_context'
    And I mouse over and click 'Delete_if_context'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'
    And I wait for '2' seconds
    Then I mouse over 'Else_context'
    And I mouse over and click 'Delete_if_else'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'

 @Add_No_massage_node
  Scenario: Add No massage node
    And I scroll to element 'No_node'
    And I click 'No_node'
    Then I mouse over element with text 'Message ' and click
    Then I mouse over element with text '+ New Message' and click
    And I wait for '2' seconds
    And I scroll to element 'Node_name'
    And I enter 'Cancel_bal' in field 'Node_name'
    And I enter 'Cancel the balance request' in field 'Node_display'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'
    And I wait for '1' seconds
    Then I mouse over and click 'Connections'
    Then I wait '10' seconds for presence of element 'Connections_title'
    And I select element 'End_of_dialog' from Dropdown 'Conn_rules'
    
  @Add_service_node
  Scenario: Add yes service node
    And I click 'Yes_node'
    Then I mouse over element with text 'Bot Action ' and click
    Then I mouse over element with text '+ New Bot Action' and click
    And I wait for '5' seconds
    And I should see element 'Panel_close' present on page
    Then I mouse over and click 'Panel_close'
    And I wait for '1' seconds
    And I scroll to element 'Add_script_node'
    Then I mouse over and click 'Add_script_node'
    And I scroll to element 'Services'
    Then I mouse over element with text 'Service ' and click
    Then I mouse over element with text '+ New Service' and click
    And I should see element 'Service_title' present on page
    And I scroll to element 'Node_name'
    And I enter 'Fetch_bal' in field 'Node_name'
    And I enter 'Fetch balance' in field 'Node_display'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'
    And I scroll to element 'Define_request'
    Then I click 'Define_request'
    And I should see element 'DefineRequest_page' present on page
    When I enter 'https://627a2c564a5ef80e2c153ddb.mockapi.io/api/v1/Bankbalance/{{context.entities.Entity0024}}' in field 'Request_url'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'
    And I should see element 'Request_save' present on page
    And I click 'Request_save'
    And I wait for '3' seconds
    Then I mouse over and click 'Close_botaction'
    And I wait for '3' seconds
    #Then I mouse over and click 'botaction_close'

  @Add_massage_node
  Scenario: Add yes massage node
    And I click 'Act_bot_add'
    Then I mouse over element with text 'Message ' and click
    Then I mouse over element with text '+ New Message' and click
    And I wait for '3' seconds
    And I scroll to element 'Node_name'
    And I enter 'Bla_msg' in field 'Node_name'
    And I enter 'balance' in field 'Node_display'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'
    And I wait for '3' seconds
    And I scroll to element 'User_prompt'
    Then I mouse over and click 'User_prompt'
    And I enter 'the balance is -${{context.fetch_bal.response.body.balance}}' in field 'User_prompt'
    And I wait for '2' seconds
    And I send key pageUp/pageDown/ESC/Enter/Tab 'Tab'

  @Add_massage_node
  Scenario: Add yes massage node
    And I wait for '2' seconds
    And I click 'No_node'
    Then I mouse over element with text 'Message ' and click
    Then I mouse over element with text '+ New Message' and click
    And I wait for '2' seconds
    And I scroll to element 'Node_name'
    And I enter 'whatelese' in field 'Node_name'
    And I enter 'What else' in field 'Node_display'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'
    And I wait for '2' seconds
    And I scroll to element 'User_prompt'
    Then I mouse over and click 'User_prompt'
    And I enter 'What else can i do for you?' in field 'User_prompt'
    And I wait for '2' seconds
    And I send key pageUp/pageDown/ESC/Enter/Tab 'Tab'
    
    And I wait for '1' seconds
    Then I mouse over and click 'Connections'
    Then I wait '5' seconds for presence of element 'Connections_title'
    And I select element 'End_of_dialog' from Dropdown 'Conn_rules'
    And I wait for '1' seconds
    And I compare notify msg ' Component Properties' and switch back to iframeID 'DialogFrame'


 
