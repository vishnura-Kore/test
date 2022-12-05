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
 
  
    
     Scenario: input discard
    * def Payload =
      """
        {
        "message": {
            "text": "discard all"
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
    
    
     Scenario: This test is to verify the setting of Bot User Session Variable
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "BotUserSessionValidation"
        },
        "from": {
            "id": "Kore123"
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
    
    # Selecting Set Bot User Session Variable value
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Set Bot User Session Variable value"
        },
        "from": {
            "id": "Kore123"
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
    And match $.text == ["Bot User Session key value pair set on this bot is 'botUserSessionKey1':'botUserSessionValue1' with ttl of 1 minute"]
    
    
    
    
     Scenario: This test is to verify the setting of Bot User Session Variable
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "BotUserSessionValidation"
        },
        "from": {
            "id": "Kore123"
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
    
    # Selecting Set Bot User Session Variable value
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Set Bot User Session Variable value"
        },
        "from": {
            "id": "Kore123"
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
    
    And match $.text == ["Bot User Session key value pair set on this bot is 'botUserSessionKey1':'botUserSessionValue1' with ttl of 1 minute"]
   
   #Now reexecute the dialog and then select "Get Bot User Session Variable value"
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "BotUserSessionValidation"
        },
        "from": {
            "id": "Kore123"
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
    
    
    # selecting "Get Bot User Session Variable value"
      * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Get Bot User Session Variable value"
        },
        "from": {
            "id": "Kore123"
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
    
    And match $.text == ["Bot User Session value for the key 'botUserSessionKey1' is botUserSessionValue1"]
    
    
    
    
    
    
     Scenario: This test is to verify the ttl expiry of Bot User Session variable
    * def Payload =
      """
        {
        "message": {
            "text": "BotUserSessionValidation"
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
    
    
    # selecting Set Bot User Session Variable value
     * def Payload =
      """
        {
        "message": {
            "text": "Set Bot User Session Variable value"
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
    
    
    * def sleep =
      """
      function(seconds){
        for(i = 0; i <= seconds; i++)
        {
          java.lang.Thread.sleep(1*6000);
          karate.log(i);
        }
      }
      """
* call sleep 10

# after waiting 1 min executing  BotUserSessionValidation
    
      * def Payload =
      """
        {
        "message": {
            "text": "BotUserSessionValidation"
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
 
    
    #Selecting Get Bot User Session Variable value
    * def Payload =
      """
        {
        "message": {
            "text": "Get Bot User Session Variable value"
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
   And match $.text == ["Bot User Session value for the key 'botUserSessionKey1' is undefined"]
    
    
       
    
      Scenario: This test is to verify the ttl expiry of User Session variable
    * def Payload =
      """
        {
        "message": {
            "text": "UserSessionValidation"
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
    
    
    # selecting Set User Session Variable value
     * def Payload =
      """
        {
        "message": {
            "text": "Set User Session Variable value"
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
    
    
    * def sleep =
      """
      function(seconds){
        for(i = 0; i <= seconds; i++)
        {
          java.lang.Thread.sleep(1*6000);
          karate.log(i);
        }
      }
      """
* call sleep 10

# after waiting 1 min executing  UserSessionValidation
    
      * def Payload =
      """
        {
        "message": {
            "text": "UserSessionValidation"
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
 
    
    # selecting Get User Session Variable value
    * def Payload =
      """
        {
        "message": {
            "text": "Get User Session Variable value"
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
   And match $.text == ["User Session value for the key 'userSessionKey1' is undefined"]
    
    
    
    
    
    
      Scenario: This test is to verify the ttl expiry of Bot Context variable
    * def Payload =
      """
        {
        "message": {
            "text": "BotContextValidation"
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
    
    
    # selecting Set BotContext Variable value
     * def Payload =
      """
        {
        "message": {
            "text": "Set BotContext Variable value"
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
    
    
    * def sleep =
      """
      function(seconds){
        for(i = 0; i <= seconds; i++)
        {
          java.lang.Thread.sleep(1*6000);
          karate.log(i);
        }
      }
      """
* call sleep 10

# after waiting 1 min executing  BotContextValidation
    
      * def Payload =
      """
        {
        "message": {
            "text": "BotContextValidation"
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
 
    
    # selecting "Get BotContext Variable value"
    * def Payload =
      """
        {
        "message": {
            "text": "Get BotContext Variable value"
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
   And match $.text == ["BotContext value for the key 'botContextKey1' is undefined"]
   
   
   
   
 
   
   
   
     Scenario: This test is to verify the ttl expiry of Enterpise Context variable
    * def Payload =
      """
        {
        "message": {
            "text": "EnterpriseContextValidation"
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
    
    
    # selecting Set Enterprise Context Variable value
     * def Payload =
      """
        {
        "message": {
            "text": "Set Enterprise Context Variable value"
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
    
    
    * def sleep =
      """
      function(seconds){
        for(i = 0; i <= seconds; i++)
        {
          java.lang.Thread.sleep(1*6000);
          karate.log(i);
        }
      }
      """
* call sleep 10

# after waiting 1 min executing EnterpriseContextValidation
    
      * def Payload =
      """
        {
        "message": {
            "text": "EnterpriseContextValidation"
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
 
    
    # selecting "Get Enterprise Context Variable value"
    * def Payload =
      """
        {
        "message": {
            "text": "Get Enterprise Context Variable value"
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
   And match $.text == ["Enterprise value for the key 'enterpriseKey1' is undefined"]
   
   
   
    Scenario: input discard
    * def Payload =
      """
        {
        "message": {
            "text": "discard all"
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
   
   
    
    Scenario: This test is to verify customized standard response for node execution limit exceeded using namespace scoped environment variable
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "NodeLoopValidation"
        },
        "from": {
            "id": "kore123"
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
    
    
    Scenario: input discard
    * def Payload =
      """
        {
        "message": {
            "text": "discard all"
        },
        "from": {
            "id": "Kore123"
        },
        "to": {
            "id": "4323"
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
    
   
  Scenario: input Hi
    * def Payload =
      """
        {
        "message": {
            "text": "Hi"
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
    
    
    
   
   
   
   
    Scenario: This test is to verify that koreUtils Close Conversation functionality is working as expected or not
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "KoreUtilCloseConversation"
        },
        "from": {
            "id": "kore123"
        },
        "to": {
            "id": "4322"
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
  And match response.text == ["I am closing our current conversation as I have not received any input from you. We can start over when you need."]
    
   
   
  Scenario: input Hi
    * def Payload =
      """
        {
        "message": {
            "text": "discard all"
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
    
   
   
   
   
   
   
    Scenario: This test is to verify LOV lookup remote api functionality
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "LOVLookupRemoteAPI"
        },
        "from": {
            "id": "kore123"
        },
        "to": {
            "id": "4323"
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
    
    #Input Byron
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Byron"
        },
        "from": {
            "id": "kore123"
        },
        "to": {
            "id": "4323"
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
    And match $.text == ["byron.fields@reqres.in"]
   
    
    
    
     Scenario: This test is to verify error prompt for LOV lookup remote api functionality
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "LOVLookupRemoteAPI"
        },
        "from": {
            "id": "kore123"
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
    
    #Input abcd
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "abcd"
        },
        "from": {
            "id": "kore123"
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
     And match $..text == ["That is not a valid option. Let us try again."]
   
    
    
    
  Scenario: input Hi
    * def Payload =
      """
        {
        "message": {
            "text": "Hi"
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
      
    
     Scenario: This test is to verify error prompt for LOV enumerated rendering from static list
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "LOVEnumeratedFromStatic"
        },
        "from": {
            "id": "kore123"
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
    
    #Input abcd
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "abcd"
        },
        "from": {
            "id": "kore123"
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
    And match $.text == ["I cannot switch to 'LOVEnumeratedFromStatic' while 'LOVLookupRemoteAPI' is in progress.","That is not a valid option. Let us try again."]
    
    
    
    
     Scenario: This test is to verify error prompt for LOV enumerated rendering from context
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "LOVEnumeratedFromContext"
        },
        "from": {
            "id": "kore123"
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
    
    #Input abcd
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "abcd"
        },
        "from": {
            "id": "kore123"
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
    And match $..text == ["Ambiguity case triggered :\nLOVEnumeratedFromContext,LOVEnumeratedFromStatic"]
    
    
    
  Scenario: input Hi
    * def Payload =
      """
        {
        "message": {
            "text": "Hi"
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
    
    
     Scenario: This test is to verify getting of Enterprise context variable
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "EnterpriseContextValidation"
        },
        "from": {
            "id": "kore123"
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
    
    #Input Set Enterprise Context Variable value
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Set Enterprise Context Variable value"
        },
        "from": {
            "id": "kore123"
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
    
    
    #Input Get Enterprise Context Variable value
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Get Enterprise Context Variable value"
        },
        "from": {
            "id": "kore123"
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
    And match $..text == ["That is not a valid option. Let us try again."]
   
   
   
   
  
   
