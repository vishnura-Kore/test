@Demo_login @Kore_demo_1
Feature: To login to Kore.

  @landing_page
  Scenario: Open URL and land on Kore login screen.
    Given My WebApp 'Kore_demo_login' is open
    And I wait for visiblity of element 'ContBtn'

  @valid_link
  Scenario: Check for valid links

  #Given Validate all Links
  @valid_image
  Scenario: Check for valid Image

  #Given Validate all Image
  @Login_demo
  Scenario: Login to kore botbuilder
    And I wait for visiblity of element 'username'
    And I enter 'vishnuprasath.ramanujam@kore.com' in field 'username'
    And I wait '5' secs for Element 'ContBtn' be clickable
    And I click 'ContBtn'
    Then I wait for visiblity of element 'password'
    And I enter encrypted data 'S29yZUAxMjM=' in field 'password'
    And I mouse over element with text 'Login' and click
    And I wait for Page to Load
    Then I wait till '15' seconds for visiblity of element 'Kore_logo'

  @Home_screen
  Scenario: Validate Home screen
    And I wait for visiblity of element 'VA'
    And I wait for visiblity of element 'PA'
    Then I enter 'My 1st bot' in field 'Search'
    And I click 'My_bot'
    Then I wait for visiblity of element 'Check_my_bot'

  @clear_Hashmap
  Scenario: clear Hashmap
    Given I clear hashmap
