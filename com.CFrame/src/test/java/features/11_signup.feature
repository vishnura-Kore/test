@singup @Kore
Feature: signup

  @Land_signup
  Scenario: to Signup
    Given My WebApp 'signup' is open
    And I wait for '2' seconds
    Then I should see element 'platformLogo' present on page

  @Signup
  Scenario: to Signup for Kore
    #Then I load page object 'signup'
    And I wait for '2' seconds
    Given I click 'Signup_btn'
    And I wait for '1' seconds
    Then I should see text 'Build powerful Virtual Assistants using Kore.ai Experience Optimization (XO) Platform.' present on page
    And I clear field 'Enter_email'
    Then I enter value with Random email/string/number 'email' in field 'Enter_email'
    And I click 'Click_btn'
    And I wait for '1' seconds
    Then I should see text 'Welcome to Kore.ai' present on page

  #And I compare attribute value 'Enter_email' stored value 'Enter_email'
  @Signup @ignore
  Scenario Outline: Enter details
    Then I enter value with Random email/string/number '<value>' in field '<field>'

    Examples: 
      | value     | field        |
      | string    | first_name   |
      | string    | Last_name    |
      | string    | Account_name |


  @signup @ignore
  Scenario: to Signup for Kore
    And I enter 'Test@1234' in field 'Pass_secure'
    And I enter 'Test@1234' in field 'confirm_pwd'
    Then I should see element 'ToolTip' present on page
    And I wait for '2' seconds
   # And I click 'SignupBtn'
