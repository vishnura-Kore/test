@whatsapp
Feature: Title of your feature
  I want to use this template for my feature file

  @tag1
  Scenario: launch the whatsapp web
    Given My WebApp 'Whatsapp' is open
    Then I should see element with text 'To use WhatsApp on your computer:' present on page

  @tag1
  Scenario: get connected and select bank
    Given I wait for visiblity of element 'landingpage'
    And I wait for visiblity of element 'search'
    Then I type 'Akraji Bank' in field 'search' and click enter

  @tag1
  Scenario: send input and validate
    Given I wait for visiblity of element 'Inputbox'
    And I type 'منتجات الأفراد' in field 'Inputbox' and click enter	
    Then I compare user input message 'منتجات الأفراد' from Channel type 'whatsapp'
    And I compare responces message 'Hello Vishnu' from Channel type 'whatsapp'
