#Add new email
@on_boarding
Feature: Onboarding
  I want to use this template for my feature file

  @create_a_new_email
  Scenario: create a new email
    Given My WebApp 'createemail' is open
    Then I click 'addemail'
    And I wait for visiblity of element 'username'
    Then I enter value with Random email/string/number 'string' in field 'username'
    And I select option 'inboxbear.com' in dropdown 'dropdown' by 'Value'
    And I click 'Add_button'
    When I should see element with text 'Your inbox is sacred' present on page
    And I get innertext of random gentext 'username' and store in 'Loginid'

  @create_FN_pwd
  Scenario: login to kore
    Given I open and navigate to New 'kore' Tab
    And I wait for Page to Load
    When I wait for '10' seconds
    And I wait for visiblity of element 'username_kore'
    Then I like enter saved random element value 'Loginid' in field 'username_kore' which is Input/Dropdown/Multi 'Input'
    And I wait '15' secs for Element 'ContBtn' be clickable
    And I wait for visiblity of element 'ContBtn'
    And I click 'ContBtn'
    And I wait for visiblity of element 'EmailBtn'
    And I should see element with text 'or sign up with email' present on page
    Then I click 'EmailBtn'
    And I wait for visiblity of element 'Firstname'
    And I should see element with text 'Welcome to Kore.ai' present on page
    And I enter 'TestAutoEng' in field 'Firstname'
    And I enter 'Test@12345' in field 'Password'
    Then I click 'Create_acct'
    And I wait for visiblity of element 'Resendcode'
    Then I should see element with text 'Great! Check your email for a verification code' present on page

  @Get_code
  Scenario: Get the code
    Given I switch to window with title 'nada - Disposable Temp Email'
    Then I scroll to element 'Subject'
    And I wait till '50' seconds for visiblity of element 'Click_email'
    Then I click 'Click_email'
    When I wait for '3' seconds
    Then I switch to iFrame 'Iframe'
    Then I scroll to element 'Code_xp'
    And I get text from 'Code_xp' and store
    When I wait for '5' seconds

  @Ente_code
  Scenario: move to Kore and enter code
    Given I switch to window with title 'Kore.ai Bot Builder'
    Then I enter OTP value from stored text 'Code_xp'
    When I wait for '1' seconds

  @New_login
  Scenario: Login to kore botbuilder
    Then I wait for visiblity of element 'password'
    And I enter 'Test@12345' in field 'password'
    And I click 'login'
    Then I wait for visiblity of element 'Industry'
    Then I wait for visiblity of element 'Department'
    And I should see text 'Welcome to the Kore.ai XO Platform!' present on page

  @create_profile
  Scenario: create profile
    And I select element 'E-Commerce' from Dropdown 'Industry'
    Then I select element 'Engg' from Dropdown 'Department'
    Then I click 'Continue_onboard'
    And I wait for visiblity of element 'search_acc'
    When I enter 'kore' in field 'search_acc'

  @Newworkspace
  Scenario: New workspace
    Then I scroll to element 'create_new'
    When I click 'create_new'
    And I wait for visiblity of element 'workspace_name'
    And I wait for visiblity of element 'Invite_email'
    Then I should see element with text 'setup your workspace' present on page
    When I enter 'QAtest' in field 'workspace_name'
    And I click 'Continue_work'
    Then I switch to default content
    And I wait for visiblity of element 'welcome'
    And I click 'skip'
    When I wait for '5' seconds

  @Get_new_email_id
  Scenario: Get new email id
    Given I switch to window with title 'nada - Disposable Temp Email'
    Then I scroll to element 'Gotoinbox'
    Then I click 'Gotoinbox'
    And I wait till '40' seconds for visiblity of element 'addemail'
    And I click 'addemail'
    And I wait for visiblity of element 'username'
    Then I enter value with Random email/string/number 'string' in field 'username'
    And I select option 'inboxbear.com' in dropdown 'dropdown' by 'Value'
    And I click 'Add_button'
    When I should see element with text 'Your inbox is sacred' present on page
    And I get innertext of random gentext 'username' and store in 'Invite_id'

  @invite
  Scenario: invite other user
    Given I switch to window with title 'Kore.ai Bot Builder'
    And I wait for Page to Load
    When I wait for '5' seconds
    And I wait for visiblity of element 'invite'
    Then I click 'invite'
    Then I switch to default content
    Then I wait for visiblity of element 'Invite_input'
    Then I like enter saved random element value 'Invite_id' in field 'Invite_input' which is Input/Dropdown/Multi 'Input'
    Then I click 'Invite_btn'
    And I wait for visiblity of element 'Invite_ok'
    When I should see element with text 'Invite sent successfully' present on page
    When I click 'Invite_ok'
    Then I switch to default content
    Then I should see element 'Profile' present on page
    And I click 'Profile'
    Then I click 'Logout'
    And I wait for Page to Load
    And I close Tab

  @Get_code_for_invited_user
  Scenario: Get the codefor invite user
    Given I switch to window with title 'nada - Disposable Temp Email'
    And I Refresh the page
    Then I scroll to element 'Subject'
    And I wait till '50' seconds for visiblity of element 'invite_email'
    Then I click 'invite_email'
    When I wait for '3' seconds
    Then I switch to iFrame 'Iframe'
    Then I scroll to element 'Accept'
    Then I click 'Accept'
    When I wait for '10' seconds

  @invite_user_login
  Scenario: invite user login
    Given I switch to window with title 'Kore.ai Bot Builder'
    And I wait till '30' seconds for visiblity of element 'invite_landing'
    And I enter 'Invite_TestAutoEng' in field 'Firstname'
    And I enter 'Test@12345' in field 'Password'
    Then I click 'Create_acct'
    And I wait for Page to Load
    Then I wait for visiblity of element 'password'
    When I wait for '5' seconds
    And I focus on element 'password'
    And I enter 'Test@12345' in field 'password'
    When I wait '5' secs for Element 'login' be clickable
    And I click 'login'
    When I wait for '3' seconds
    Then I wait for visiblity of element 'Industry'
    Then I wait for visiblity of element 'Department'
    And I should see text 'Welcome to the Kore.ai XO Platform!' present on page

  @add_to_created_profile
  Scenario: create profile and compare the workspace name
    And I select element 'E-Commerce' from Dropdown 'Industry'
    Then I select element 'Engg' from Dropdown 'Department'
    Then I click 'Continue_onboard'
    Then I switch to default content
    And I wait for visiblity of element 'welcome'
    And I click 'skip'
    Then I wait for visiblity of element 'WS_name'
    And I compare 'WS_name' with given value 'QAtest'
    And I should not see element 'invite' present on page
    Then I should see element 'Profile' present on page
    And I click 'Profile'
     Then I wait for visiblity of element 'Logout'
    Then I click 'Logout'
    And I wait for Page to Load
   

  @clear_Hashmap
  Scenario: clear Hashmap
    Given I clear hashmap
