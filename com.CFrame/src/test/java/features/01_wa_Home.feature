@WA
Feature: Home Functionality

  @Regression
  Scenario: Opening the WA website
    Given My WebApp '01_wa_Home' is open
    When I login to workassist with O365 as 'james@koraqa1.com' using 'Outlook@123' 
    
#   When I logout and relogin with 'Hana@koraqa1.com','Outlook@123'
# 	And Dynamic xpath text 'Jaya' for the element '' and save as '(.*)'

  	
  @clear 
  Scenario: clear hashmap
  Given I clear hashmap 
    
