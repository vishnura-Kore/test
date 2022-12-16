@runtime
Feature: Interacting with the bot using webhook channel

  Background: 
    * url runtimeUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    

  Scenario: input discard
    * def Payload =
      """
        {
        "message": {
            "text": "hi"
        },
        "from": {
            "id": "Kore123"
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
    
    
    
    
    Scenario: This test is to verify environment variable rendering functionality in alerts
    * def Payload =
      """
        {
        "message": {
            "text": "EnvironmentVariableAlert"
        },
        "from": {
            "id": "Kore123"
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
    
    #input selecting options
     * def Payload =
      """
        {
        "message": {
            "text": "a"
        },
        "from": {
            "id": "Kore123"
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
    
    #input selecting Yes
     * def Payload =
      """
        {
        "message": {
            "text": "yes"
        },
        "from": {
            "id": "Kore123"
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
    
    And match $..text == ["The task 'EnvironmentVariableAlert' has been set up successfully. I will monitor for this event and will notify you when it occurs."]
    
    
    
    
    
     Scenario: This test is to verify webservice alert functionality
    * def Payload =
      """
        {
        "message": {
            "text": "webservice alert"
        },
        "from": {
            "id": "Kore123"
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
    
    #input selecting options
     * def Payload =
      """
        {
        "message": {
            "text": "a"
        },
        "from": {
            "id": "Kore123"
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
    
    #input selecting Yes
     * def Payload =
      """
        {
        "message": {
            "text": "yes"
        },
        "from": {
            "id": "Kore123"
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
    And match $..text == ["The task 'webservice alert' has been set up successfully. I will monitor for this event and will notify you when it occurs."]
    
    
    
    
    
    
    
    
      Scenario: This test is to verify smart alert expiry functionality with option "Number of Days"
    * def Payload =
      """
        {
        "message": {
            "text": "SmartAlertWithNumberOfDaysLimit"
        },
        "from": {
            "id": "Kore123"
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
    And match $.text ==  ["SmartAlert limit set for 1 day. You should receive alert notification for 24 hours from now."]
    
    
    
    
     
      Scenario: This test is to verify smart alert subscription functionality usign webhook alert
    * def Payload =
      """
        {
        "message": {
            "text": "SmartAlertWithWebhook"
        },
        "from": {
            "id": "Kore123"
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
  
   
    
    
    
    
      Scenario: This test is to verify Bot functions functionality in alerts
    * def Payload =
      """
        {
        "message": {
            "text": "AlertWithBotFunctions"
        },
        "from": {
            "id": "Kore123"
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
    
     #input selecting options
     * def Payload =
      """
        {
        "message": {
            "text": "a"
        },
        "from": {
            "id": "Kore123"
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
    
    #input selecting Yes
     * def Payload =
      """
        {
        "message": {
            "text": "yes"
        },
        "from": {
            "id": "Kore123"
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
    And match $..text == ["The task 'AlertWithBotFunctions' has been set up successfully. I will monitor for this event and will notify you when it occurs."]
    
    
    
    
    
     
      Scenario: This test is to verify smart alert expiry functionality with option "Number of Notifications"
    * def Payload =
      """
        {
        "message": {
            "text": "SmartAlertWithNumberOfNotificationsLimit"
        },
        "from": {
            "id": "Kore123"
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
    And match $.text ==  ["SmartAlert limit set for 2 notifications. You should receive only 2 notification from this subscription"]
    
    
    
    
    
    
    
    
    
     Scenario: This test is to verify rss alert functionality
    * def Payload =
      """
        {
        "message": {
            "text": "rss alert"
        },
        "from": {
            "id": "Kore123"
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
    
     #input selecting options
     * def Payload =
      """
        {
        "message": {
            "text": "a"
        },
        "from": {
            "id": "Kore123"
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
    
    #input selecting Yes
     * def Payload =
      """
        {
        "message": {
            "text": "yes"
        },
        "from": {
            "id": "Kore123"
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
    And match $..text == ["The task 'rss alert' has been set up successfully. I will monitor for this event and will notify you when it occurs."]
    
    