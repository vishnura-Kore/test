@storyboard
Feature: create storyboad

  Scenario: Kore botbuilder Validate Img
    Given I load page object 'Storyboard'

  #And Validate all Image
  Scenario: Kore botbuilder Validate link

  #And Validate all Links
  @tag1
  Scenario: create storyboad
    And I click 'story_menu'
    Then I wait for '2' seconds
    Then I should see text 'Storyboard' present on page
    And I wait '10' secs for Element 'Mock_scense' be clickable
    And I click 'Mock_scense'
    Then I wait for '2' seconds
    #Then I should see text 'Create Your First Scene' present on page
    And I wait '10' seconds for presence of element 'Create_scene'
    And I wait '10' secs for Element 'Create_scene' be clickable
    And I click 'Create_scene'
    Then I wait for '2' seconds
    Then I should see text 'New Prototype' present on page
    Then I enter 'check account balance' in field 'Scren_name'
    Then I enter 'To fetch account balance' in field 'Description'
    And I click 'Procced'
    Then I wait for '2' seconds

  @tag1
  Scenario: create storyboad
    #Then I should see text 'Scene Timeline' present on page
    Then I wait for Page to Load
    Then I wait for '2' seconds
    Then I switch to iFrame 'storyBoardFrame'
    And I wait '5' secs for Element 'user' be clickable
    And I click 'user'
    When I type 'I want to get my account balance' in field 'Input_chat' and click enter
    Then I mouse over and click 'Note'
    When I type '#Start_intent Check balance' in field 'Input_chat' and click enter
    And I click 'Bot'
    And I type 'Ok, I can get you balance. Get me your Account number' in field 'Input_chat' and click enter
    And I click 'user'
    When I type '12345678' in field 'Input_chat' and click enter
    And I mouse over text contains '123456'
    Then I wait for '1' seconds
    And I click edit in storyboard chat last_0 or last-n'0'
    And I perfrom action Edit/Delete/Comment/Link a message/Link a scene in storyboard chat 'Comment'
    Then I enter 'Account number is 8 digit' in field 'text_area'
    And I click 'Post'
    And I click 'Bot'
    Then I click 'Template'
    And I click 'quick_reply'
    Then I should see text 'Quick reply template' present on page
    Then I enter 'Are you sure you want proceed with account number 12345678?' in field 'Quick_text'
    Then I enter 'Yes' in field 'Yes_btn'
    Then I enter 'No' in field 'No_btn'
    And I click 'Quick_done'
    When I type 'Your account balance is $200.00' in field 'Input_chat' and click enter
    And I click 'Bot'
    When I type 'What can i do for you' in field 'Input_chat' and click enter
    Then I mouse over and click 'Note'
    When I type '#end_intent Check balance' in field 'Input_chat' and click enter
    And I click 'Chat_no'
    And I click 'Bot'
    When I type 'Ok, Cancelling your task.' in field 'Input_chat' and click enter
    Then I wait for '2' seconds
    And I mouse over text contains 'Ok, Cancelling your task'
    And I click edit in storyboard chat last_0 or last-n'0'
    And I perfrom action Edit/Delete/Comment/Link a message/Link a scene in storyboard chat 'Link a Message'
    And I wait for Page to Load
    #Then I should see element with text 'Select any of the message nodes to link' present on page
    And I wait '10' secs for Element 'linkmsg' be clickable
    And I mouse over 'linkmsg'
    Then I wait for '3' seconds
    And I click 'circle_click'
    #Then I send key pageUp/pageDown/ESC/Enter/Tab 'Enter'
    #Then I mouse over and click 'linkmsg'
    Then I wait for '3' seconds
    Then I should see text 'Do you want to link this message ?' present on page
    And I click 'Link_yes'
    And I wait for Page to Load
    #And I should see element with text 'What can i do for you' present on page
    #And I click 'Back'
    #And I wait for Page to Load
    #And I should see element with text 'In Progress' present on page
    #And I should see element with text 'check account balance' present on page
    #And I should see element with text 'To fetch account balance' present on page

  @clear_hashmp
  Scenario: Clear HashMap
    And I clear hashmap
