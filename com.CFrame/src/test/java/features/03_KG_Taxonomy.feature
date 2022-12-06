@KG_T @9.1 @Kore @test3
Feature: KG Functionality validation

  @9.1
  Scenario: Navigating to KG
    Given I load page object 'KG'
    And I wait '10' secs for Element 'Knowledge_Graph' be clickable
    And I click 'Knowledge_Graph'
    
  Scenario: Switch to knowledge task
  	When I wait for visiblity of element 'Knowledge_Graph_task'
    And I wait for '3' seconds
    And I click 'Knowledge_Graph_task'
    And I wait for '3' seconds

  @9.1
  Scenario: Talk to Bot
    And I click 'Talk2Bot'
    And I wait for '2' seconds

  @9.1
  Scenario: Taxonomy FAQ Test
    And I switch to window with title ''
    And I wait for '5' sec untill element 'Tittle2' is visible
    When I type 'Apply Loan' in field 'Chat' and click enter
    And I wait for '1' seconds
    And I compare user input message 'Apply Loan' from Channel type 'Talk2Bot'
    Then I wait '3' sec for chat massage to load in Bot
    Then I compare template header responces 'Did you mean?' for Template type Quick/Button 'Button'
    Then I compare button template responces message 'Home' and click/onlycompare 'onlycompare'
    Then I compare button template responces message 'New' and click/onlycompare 'onlycompare'
    Then I compare button template responces message 'Latest' and click/onlycompare 'onlycompare'
    Then I compare button template responces message 'Latest' and click/onlycompare 'click'
    Then I wait '3' sec for chat massage to load in Bot
    Then I compare responces message 'ANS: How can I apply for a loan for new car without Guarantor?' from Channel type 'Talk2Bot'


  @9.1
  Scenario: Close the Chat
    And I wait for '2' seconds
    Then I click 'Chat_close'
    And I wait for '2' seconds
    Then I switch back to default content

  

  @9.1
  Scenario: Moving to KG Homescreen from Questions screen
    When I click 'KG_Back_Button'
    And I wait for '5' seconds
    Then I should see text 'Knowledge Graph' present on page
