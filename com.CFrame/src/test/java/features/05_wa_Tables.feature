@WATab
Feature: Tables Functionality

  @Regression
  Scenario: 2.1-Check the list of items in Boards
  
		When I load page object '05_wa_Tables'
		When I load page object '02_wa_Workspaces'
		And I navigate to workassist homepage
		And I search and select workspace 'StandardWSB'
		
		And I wait for '5' seconds
   	And I wait for visiblity of element 'wsplusicon'
  	Then I click 'wsplusicon'
  	And I wait for '5' seconds
  	And I wait for visiblity of element 'wsboard_application'
  	And I wait for visiblity of element 'wsboard_table'
  	And I wait for visiblity of element 'wsboard_document'
  	And I wait for visiblity of element 'wsboard_embed'
  	And I wait for visiblity of element 'wsboard_folder'
  	
  Scenario: 2.2_2.3-Select Table from Boards list and start from scratch
  
  	Then I click 'wsboard_table'
  	And I wait for visiblity of element 'wstable_startfromscratch'
  	And I click 'wstable_startfromscratch' 
  	Then I wait for '2' seconds
  	And I click 'wstabletitle' 
  	
  Scenario: 2.6-Check the default column types  after creation of the table
 		Then I wait for '2' seconds
  	And I wait for visiblity of element 'wstabletitle'
  	And I wait for visiblity of element 'wstablepeople'
  	And I wait for visiblity of element 'wstabledateandtime'
    
   Scenario: 2.7- check the list of options on the table view screen
   
    Then I wait for '2' seconds
    And I wait for visiblity of element 'ws3dots'
    And I wait for visiblity of element 'wstableBoardnotsharedmessage'
    And I wait for visiblity of element 'wstablegrid'
    And I wait for visiblity of element 'wstablegridplusicon'
    And I wait for visiblity of element 'wstableaddrecord'
    And I wait for visiblity of element 'wstablesearch'
    And I wait for visiblity of element 'wstablefilter'
    And I wait for visiblity of element 'wstableoptions'
    
   Scenario: 2.8- check the list of options in 3 dots beside the table
   
   Then I wait for visiblity of element 'ws3dots'
  	And I click 'ws3dots' 
  	Then I wait for visiblity of element 'wstablerename'
  	And I wait for visiblity of element 'wstablecopylink'
  	And I wait for visiblity of element 'wstableexport'
  	And I wait for visiblity of element 'wstablesharigandpermissions'
  	And I wait for visiblity of element 'wstabledelete'
  	
  	
  Scenario: 2.9-navigate to sharing and permissions screen and able to share the table
    
  #  And I click 'ws3dots' 
	And I wait for visiblity of element 'wstablesharigandpermissions'
	And I click 'wstablesharigandpermissions'
	And I wait for visiblity of element 'wstableinviteusers'
	And I click 'wstableinviteusers'
	And I select participants 'hana@koraqa1.com'
	And I wait for visiblity of element 'wstableinvite'
	And I click 'wstableinvite'