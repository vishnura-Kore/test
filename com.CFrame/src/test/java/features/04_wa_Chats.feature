@WAChats
Feature: Chats Functionality

  @Regression
  Scenario: Create chats and validate
		Given I load page object '04_wa_Chats'
		When I load page object '01_wa_Home'
  	And I load page object '03_wa_Topics'
  	And I load page object '02_wa_Workspaces'
  	And I navigate to chats
  	And I start new chat
  	And I close new chat
    
    
  @clear 
  Scenario: clear hashmap
  Given I assert all
  When I clear hashmap 