#Author: your.email@your.domain.com
@workb
Feature: Login Functionality WB

  Scenario: Kore Workbench URL
    Given My WebApp 'workB' is open
    Then I wait for '2' seconds
    Then I wait for Page to Load
    And I wait '10' seconds for presence of element 'username'
    Then I should see element 'cont' present on page
    And I clear field 'username'
    And I enter 'jan27.sa@prod01.com' in field 'username'
    And I wait '5' secs for Element 'cont' be clickable
    Then I wait for '2' seconds
    And I click 'cont'
    And I clear field 'pass'
    And I enter encrypted data 'S29yZUAxMjM0' in field 'pass'
    And I click 'login'

  Scenario: Checing Workbench
    Then I wait for Page to Load
    And I wait '20' seconds for presence of element 'Bankassist'
    Then I wait for '3' seconds
    Then I wait for '20' sec untill element not displayed 'Loading'
    And I wait '5' secs for Element 'Config' be clickable
    And I mouse over and click 'Config'
    Then I wait for '2' seconds
    And I click 'Transaction_Codes'
    Then I should see text 'Transaction Codes' present on page
    And I click 'Transaction_Codes'
    And I click 'Checking'
    Then I wait for '5' seconds
