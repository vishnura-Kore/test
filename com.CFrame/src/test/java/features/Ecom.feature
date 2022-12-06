@Ecom
Feature: Test Ecom

  Scenario: Login to kore
    Given My WebApp 'Ecom' is open
    Then I wait for '2' seconds


  Scenario Outline: Login to kore botbuilder
    Then I wait for '2' seconds
    And I clear field 'username'
    And I enter '<Username>' in field 'username'
    And I mouse over 'ContinueBtn'
    Then I wait for '2' seconds
    And I click 'ContinueBtn'
    And I clear field 'password'
    And I enter encrypted data '<Password>' in field 'password'
    And I click 'Login'
    And I wait for Page to Load
    And I wait '2' seconds for presence of element 'Kore_logo'
    #Scenario: Create a new bot
    Then I wait for '5' seconds
    And I wait for Page to Load
    And I click 'NewBotButton'
    And I wait for '2' seconds
    And I click 'StartFromScratchButton'
    When I enter value with Random email/string/number 'string' in field 'Bot_name'
    And I wait for '5' seconds
    And I click 'CreateButton'
    And I wait for '10' seconds
    And I should see element 'Build' present on page
    And I wait for Page to Load
    #Scenario: Enable web channel for the bot
    And I wait '10' secs for Element 'Deploy_menu' be clickable
    When I click 'Deploy_menu'
    Then I wait for '5' seconds
    #And I click 'Channels'
    Then I wait for '5' seconds
    When I enter 'Web' in field 'Channel_search'
    And I mouse over 'Web_mobile_client'
    And I click 'Web_mobile_client'
    Then I wait for '2' seconds
    And I switch to default content
    And I click 'Enable'
    Then I wait for '2' seconds
    Then I click 'Save_web'
    Then I wait for '2' seconds
    And I switch to default content
    And I click 'Save_ok'
    And I switch to default content
    #Scenario: Publish
    And I wait for Page to Load
    When I click 'Deploy_menu'
    Then I click 'Publish'
    Then I wait for '4' seconds
    And I switch to default content
    And I click 'Proceed'
    Then I wait for '2' seconds
    Then I enter 'Test' in field 'text_area'
    And I click 'Confirm'
    Then I wait for '5' seconds
    #Scenario: Publish with plan
    And I wait for Page to Load
    Then I click 'plan'
    Then I wait for '2' seconds
    Then I enter '100' in field 'Amount_usd'
    And I click 'Authorize_Payment'
    Then I wait for '1' seconds
    Then I switch to iFrame 'payProIframe'
    And I wait for Page to Load
    And I scroll to element 'submit_order'
    Then I wait for visiblity of element 'submit_order'
    Then I click 'submit_order'
    And  I wait for '20' sec untill element not displayed 'submit_order'
    And I wait for Page to Load
    Then I wait for '2' seconds
    And I switch to default content
    Then I wait for visiblity of element 'PayDone'
    And I click 'PayDone'
    Then I wait for '2' seconds
    And I click 'close_pay'
    Then I wait for '3' seconds
    #Scenario: check the Plan
    And I wait for Page to Load
    And I wait '5' secs for Element 'Manage' be clickable
    And I mouse over and click 'Manage'
    Then I wait for '4' seconds
    Then I wait for Page to Load
    Then I click 'Plan_usage'
    And I wait for '2' seconds
    Then I should see element 'Std_plan' present on page
    And I should see element 'Credit_status_100' present on page
    Then I should see element 'Allowed_req_10000' present on page
    #Scenario: chat to bot
    Then I wait for '3' seconds
    And I wait for Page to Load
    When I click 'Deploy_menu'
    Then I wait for Page to Load
    And I click 'Channels'
    Then I wait for '4' seconds
    When I enter 'Web' in field 'Channel_search'
    And I mouse over 'Web_mobile_client1'
    And I click 'Web_mobile_client1'
    Then I wait for '2' seconds
    And I click 'Redirect'
    And I switch to window with title 'Kore.ai Web Client'
    Then I wait for '2' seconds
    And I switch to window with title ''
    Then I wait for '2' seconds
    When I type 'Hi' in field 'chat' and click enter
    Then I compare responces message 'H' from Channel type 'Talk2Bot'
    And I wait for '2' seconds
    Then I close Tab
    And I switch back to default content
    #Scenario: Logout
    Then I wait for Page to Load
    And I click 'Cancel_home'
    Then I should see element 'Profile' present on page
    And I click 'Profile'
    Then I wait for '2' seconds
    Then I click 'Logout'
    And I wait for Page to Load
    Then I wait for '10' seconds
    #Then I should see text 'One platform for automating' present on page

    Examples: 
      | Username              | Password     |
      | adeva1@mailinator.com | S29yZUAxMjM= |



  Scenario: clear hashmap
    Then I clear hashmap
