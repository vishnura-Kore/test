@New_bot1 @flow
Feature: create a new bot
	
	@login_newbot @ignore
	Scenario: Login to kore botbuilder
		Given My WebApp 'Kore_applications' is open
	  Then I wait for '2' seconds
    And I clear field 'username'
    And I enter 'vishnuprasath.ramanujam@kore.com' in field 'username'
    And I click 'ContinueBtn'
    And I clear field 'password'
    And I enter encrypted data 'S29yZUAxMjM=' in field 'password'
    And I click 'Login'
    And I wait for Page to Load
    And I wait '2' seconds for presence of element 'Kore_logo'

  @create_new_bot1
  Scenario: Create a new bot
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
  