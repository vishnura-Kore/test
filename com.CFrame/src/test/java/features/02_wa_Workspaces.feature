@WAWorkspaces
Feature: Workspaces Functionality

  Scenario: 1.1_1.2 - Create private workspace and validate at other users end
    When I load page object '02_wa_Workspaces'
    And I load page object '01_wa_Home'
    
    And I navigate to workassist homepage
    And I create workspace '<wsnamenoParticipants>' as private 'true' with out participants
    And I create workspace '<wsnamewithParticipants>' as private 'false' with participants'<recUser>'
    And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
    Then I search for '<wsnamenoParticipants>' existance and should be 'false'
    Then I search for '<wsnamewithParticipants>' existance and should be 'true'
    
    Examples:
 |wsnamenoParticipants|wsnamewithParticipants|recUser|userrole|wsfrom3dots|wsrenameto|
 |DeleteWSAuto_1|DeleteWSAuto_2|hana@koraqa1.com|Admin|DeleteWSAuto_3|DeleteWSAuto_4|
 
   Scenario: 1.3 - Validate workspace 3 dot options
    Given I navigate to workassist homepage
    When I logout and relogin with 'james@koraqa1.com','Outlook@123'
    And I search and select workspace '<wsnamenoParticipants>'
   	And I click 'ws3dots'
    And I wait for visiblity of element 'ws3dotsrename'
    And I wait for visiblity of element 'ws3dotschangeicon'
    And I wait for visiblity of element 'ws3dotscopylink'
    And I wait for visiblity of element 'ws3dotspin'
    And I wait for visiblity of element 'ws3dotsviewprivateboards'
    And I wait for visiblity of element 'ws3dotspin'
    And I wait for visiblity of element 'ws3dotssharingandpermissions'
    And I wait for visiblity of element 'ws3dotsdelete'
    And I wait for visiblity of element 'ws3dotcreatews'
    And I wait for visiblity of element 'ws3dotsshowallws'
    Then I navigate to workassist homepage
    
    Examples:
 |wsnamenoParticipants|wsnamewithParticipants|recUser|userrole|wsfrom3dots|wsrenameto|
 |DeleteWSAuto_1|DeleteWSAuto_2|hana@koraqa1.com|Admin|DeleteWSAuto_3|DeleteWSAuto_4|
    
 #  Scenario: 1.4 - Validate rename workspace functionality from 3 dots
 #  Given I navigate to workassist homepage
 # 	When I search and select workspace '<wsnamenoParticipants>'
 #  And I click 'ws3dots'
 #  And I wait for visiblity of element 'ws3dotsrename'
 #  And I click 'ws3dotsrename'
 #  And I enter '<wsrenameto>' in field 'wsnameinws'
 #  And I click 'ws3dots'
 #  And I get text from 'wsnameinws' and store
 #  Then I check for existance of 'Renamed Workspace' with expected and actual strings '<wsrenameto>','wsnameinws'
   
  Scenario: 1.5 - Validate create workspace functionality from 3 dots
   Given I navigate to workassist homepage
   When I search and select workspace '<wsnamewithParticipants>'
   And I create workspace '<wsfrom3dots>' with in a workspace as private 'true' with out participants
   Then I navigate to workassist homepage
   
   Examples:
 |wsnamenoParticipants|wsnamewithParticipants|recUser|userrole|wsfrom3dots|wsrenameto|
 |DeleteWSAuto_1|DeleteWSAuto_2|hana@koraqa1.com|Admin|DeleteWSAuto_3|DeleteWSAuto_4|
   
   
   Scenario: 1.6 - Validate show all workspaces functionality from 3 dots
   Given I navigate to workassist homepage
   When I search and select workspace '<wsfrom3dots>'
   And I click 'ws3dots'
   And I wait for visiblity of element 'ws3dotsshowallws'
   And I click 'ws3dotsshowallws'
   Then I validate show all workspaces
   
   Examples:
 |wsnamenoParticipants|wsnamewithParticipants|recUser|userrole|wsfrom3dots|wsrenameto|
 |DeleteWSAuto_1|DeleteWSAuto_2|hana@koraqa1.com|Admin|DeleteWSAuto_3|DeleteWSAuto_4|
 
  Scenario: 1.9_1.10 - Validate share and permissions from 3 dots
  Given I navigate to workassist homepage
  When I search and select workspace '<wsfrom3dots>'
  And I click 'ws3dots'
  And I wait for visiblity of element 'ws3dotssharingandpermissions'
  And I click 'ws3dotssharingandpermissions'
  And I wait for visiblity of element 'wsinviteusers'
  And I click 'wsinviteusers'
 	Then I select '<recUser>' user and assign role 'true' of type '<userrole>'
 	
 	Examples:
 |wsnamenoParticipants|wsnamewithParticipants|recUser|userrole|wsfrom3dots|wsrenameto|
 |DeleteWSAuto_1|DeleteWSAuto_2|hana@koraqa1.com|Admin|DeleteWSAuto_3|DeleteWSAuto_4|
 
 Scenario: 1.12 - Validate member/admin able to see the shared workspace
 Given I navigate to workassist homepage
  And I logout and relogin with 'hana@koraqa1.com','Outlook@123'
  When I search and select workspace '<wsfrom3dots>'
  And I click 'ws3dots'
  And I wait for visiblity of element 'ws3dotssharingandpermissions'
  And I click 'ws3dotssharingandpermissions'
  And I validate user 'hana@koraqa1.com' role as 'Admin'
  When I logout and relogin with 'james@koraqa1.com','Outlook@123'
  
  Examples:
 |wsnamenoParticipants|wsnamewithParticipants|recUser|userrole|wsfrom3dots|wsrenameto|
 |DeleteWSAuto_1|DeleteWSAuto_2|hana@koraqa1.com|Admin|DeleteWSAuto_3|DeleteWSAuto_4|

Scenario: 1.14- Check the empty state for a newly created workspace
		Given I navigate to workassist homepage
		When I search and select workspace '<wsfrom3dots>'
		And I wait for visiblity of element 'wsworkspacename'
    And I wait for visiblity of element 'wsworkspacelivetext'
    And I wait for visiblity of element 'wschooseboard'
    And I wait for visiblity of element 'wstable'
    And I wait for visiblity of element 'wsdocument'
    And I wait for visiblity of element 'wsapplication'
       And I wait for visiblity of element 'wsembed'

Examples:
 |wsnamenoParticipants|wsnamewithParticipants|recUser|userrole|wsfrom3dots|wsrenameto|
 |DeleteWSAuto_1|DeleteWSAuto_2|hana@koraqa1.com|Admin|DeleteWSAuto_3|DeleteWSAuto_4|


 Scenario: 1.7 - Validate delete workspace functionality from 3 dots
   Given I navigate to workassist homepage
   When I search and select workspace '<wsnamenoParticipants>'
   And I delete workspace '<wsnamenoParticipants>'
   And I search and select workspace '<wsnamewithParticipants>'
   And I delete workspace '<wsnamewithParticipants>'
   And I search and select workspace '<wsfrom3dots>'
   And I delete workspace '<wsfrom3dots>'
   Then I navigate to workassist homepage
   
   
  Examples:
 |wsnamenoParticipants|wsnamewithParticipants|recUser|userrole|wsfrom3dots|wsrenameto|
 |DeleteWSAuto_1|DeleteWSAuto_2|hana@koraqa1.com|Admin|DeleteWSAuto_3|DeleteWSAuto_4|
   
   
  @clear 
  Scenario: clear hashmap
  Given I clear hashmap  
