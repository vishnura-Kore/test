#Author: your.email@your.domain.com
@Itassist
Feature: Log in to Itassist
  I want to use this template for my feature file

  @tag1
  Scenario: login to ITAssist
    Given My WebApp 'itassist' is open
    Then I wait for Page to Load
    And I wait '30' seconds for presence of element 'username'
    Then I should see element 'CtnBtn' present on page
    And I enter 'itp-user23022022@mailinator.com' in field 'username'
    And I click 'CtnBtn'
    Then I enter 'Kore@123' in field 'password'
		When I click 'login_btn'
		
		  @tag1
  Scenario: go to Apdt
  And I wait '5' seconds for presence of element 'Adapter'
 
  And I wait '10' secs for Element 'Adapter' be clickable
  Then I click 'Adapter'
   Then I wait for '10' seconds
    Then I switch to iFrame 'Dashboard_iframe'
   And I should see element 'Title' present on page
    #And I wait '5' seconds for presence of element 'Title'
    And I click 'IT_HR'