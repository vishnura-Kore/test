@9.1 @Kore @login @test_demo
Feature: Login Functionality

  Scenario: Kore botbuilder URL
    Given My WebApp 'Kore_applications' is open
    Then I wait for '2' seconds
    Then I wait for Page to Load
    And I wait '30' seconds for presence of element 'username'
    Then I should see element 'ContinueBtn' present on page
    Then I should see text 'One platform for automating all your customer interactions' present on page

  Scenario: Kore botbuilder Validate Img

  #And Validate all Image
  Scenario: Kore botbuilder Validate Link

  #And Validate all Links
  Scenario: Login to kore botbuilder
    Given I login in to Kore with username 'vishnuprasath.ramanujam@kore.com' and password 'Kore@123'

  #And I clear field 'username'
  #And I enter 'vishnuprasath.ramanujam@kore.com' in field 'username'
  # And I wait '5' secs for Element 'ContinueBtn' be clickable
  #Then I wait for '2' seconds
  #And I click 'ContinueBtn'
  #And I clear field 'password'
  #And I enter encrypted data 'S29yZUAxMjM=' in field 'password'
  #And I click 'Login'
  #And I wait for Page to Load
  #And I wait '5' seconds for presence of element 'Kore_logo'

  Scenario: Search for Bot
    Then I wait for '2' seconds
    And I wait '5' secs for Element 'sreach' be clickable
    And I mouse over 'sreach'
    When I enter 'Travel bot' in field 'sreach'
    When I click 'My_1st'
    Then I wait for Page to Load
    Then I wait for '15' seconds
    And I mouse over 'Summary_menu'
    And I click 'Summary_menu'

  @clear_hashmp
  Scenario: Clear HashMap
    And I clear hashmap
