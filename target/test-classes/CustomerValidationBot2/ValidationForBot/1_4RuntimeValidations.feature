@runtime
Feature: Interacting with the bot using webhook channel

  Background: 
    * url runtimeUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    

  Scenario: input Hi
    * def Payload =
      """
        {
        "message": {
            "text": "Hi"
        },
        "from": {
            "id": "Kore1234"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanityBotStreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    

    
     Scenario: This test is to verify Fallback dialog functionality when it is none of the intents identified
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "abcgdeefpp"
        },
        "from": {
            "id": "Kore1234"
        },
        "to": {
            "id": "4321"
        }
        }
      """

    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanityBotStreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $.text contains ["End of Conversation Event triggered"]
    
    
    
      
     Scenario: This test is to verify End Of Conversation Event functionality in case of end of FAQ
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Trigger EndOfConversation event for FAQ"
        },
        "from": {
            "id": "Kore1234"
        },
        "to": {
            "id": "4321"
        }
        }
      """

    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanityBotStreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $.text == ["This response is from KG","End of Conversation Event triggered"]
    
    
   
     Scenario: This test is to verify End Of Conversation Event functionality in case of end of Dialog
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "TestDialog"
        },
        "from": {
            "id": "Kore1234"
        },
        "to": {
            "id": "4321"
        }
        }
      """

    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanityBotStreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $.text == ["Test Dialog triggered successfully","End of Conversation Event triggered"]
    
    
    
    
    
    
    
    
    
    
      Scenario: This test is to verify Search by answer functionality in KG
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Contact nearest branch"
        },
        "from": {
            "id": "Kore1234"
        },
        "to": {
            "id": "4321"
        }
        }
      """

    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanityBotStreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $.text == ["Contact nearest branch to open bank account","End of Conversation Event triggered"]