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
    
     Scenario: input Selecting english language
    * def Payload =
      """
        {
        "message": {
            "text": "English"
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
    
    
     Scenario: This test is to verify environment variables are getting resolved in dialog message node
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "EnvironmentVariableValidation"
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
   
   #  From the options displayed, choose "Dialog Message Node"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Dialog Message Node"
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
    And match response.text[0] == "This message is from environment variable"
    And match response.completedTaskName == "environmentvariablevalidation"
    
    
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
    
    
    
    
    
    
    
    Scenario: This test is to verify environment variables are getting resolved in dialog script node
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "EnvironmentVariableValidation"
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
   
    
    
   
    # From the options displayed, choose "Dialog Script Node"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Dialog Script Node"
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
     
   And match response.text[0] == "This message is from environment variable"
    And match response.completedTaskName == "environmentvariablevalidation"
    
    
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
    
    
    
     Scenario: This test is to verify environment variables are getting resolved in dialog service node
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "EnvironmentVariableValidation"
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
   
    
    
    
    
    
    # From the options displayed, choose "Dialog Service Node"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Dialog Service Node"
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
    
    * def TodaysDate = response.text[0]
    * print TodaysDate
     
     
     
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
  
    
    
    Scenario: This test is to verify environment variables are getting resolved in KG responses
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Can you please display Get time service url from Environment variables?"
        },
        "from": {
            "id": "kore123"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.from.id = "Kore"+name
    * def User2 = Payload.from.id
    * print User2
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanityBotStreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
     And match response.text[0] == "http://worldtimeapi.org/api/timezone/Asia/Kolkata"
    
    
    
    
    
    
     
    
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
    
    
 
 
    
   
  Scenario: This test is to verify one environment variable can use the value of another environment variable as reference.
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "EnvironmentVairableToEnvironmentVairableReference"
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
    And match response.text[0] == "This message is from environment variable"
    And match response.completedTaskName == "environmentvairabletoenvironmentvairablereference"
    
    
    
     Scenario: This test is to verify content variables are getting resolved in dialog message node
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "ContentVariableValidation"
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
   
   
   #. From the options displayed, choose "Dialog Message Node"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Dialog Message Node"
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
    And match response.text[0] == "This message is from content variables"
    And match response.completedTaskName == "contentvariablevalidation"
   
    
    
    
    
  
     Scenario: This test is to verify content variables are getting resolved in dialog script node
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "ContentVariableValidation"
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
   
   
    
    
    
    
    # From the options displayed, choose "Dialog Script Node"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Dialog Script Node"
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
    And match response.text[0] == "This message is from content variables"
    And match response.completedTaskName == "contentvariablevalidation"
    
    
  
    
        Scenario: This test is to verify content variables are getting resolved in dialog service node
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "ContentVariableValidation"
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
    
    
      #From the options displayed, choose "Dialog Service Node"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Dialog Service Node"
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
   
    
    
    
    
        Scenario: This test is to verify content variables are getting resolved in KG responses
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "What is the value for the key content_key1 in content variables?"
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
    And match response.text[0] == "This message is from content variables"
 
    
        Scenario: This test is to verify custom entity extraction using regex in a dialog
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "CustomEntityValidation"
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
    
    
  #  When bot asks to enter some text, enter following text "Extract only NLP-1234 from this utterance"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Extract only NLP-1234 from this utterance"
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
    And match $.text == ["Value captured NLP-1234"]
    
    

    
        Scenario: This test is to verify Bot Functions functinoality in bot dialog
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "BotFunctionsAccessInDialogValidation"
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
    And match $.text == ["This message is returned from botfunctions"]
    
    
    
    
     Scenario: This test is to verify environment variabels are getting rendered from botfunctions are not.
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "EnvironmentVariablesAccessFromBotFunctions"
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
    And match $.text == ["This message is rendered from environment variables"]
    
    
    
    
    Scenario: This test is to verify the Botfunctions functionality in KG
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Show me the content from botfunctions"
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
    And match $.text == ["This message is returned from botfunctions"]
    
    
    
    Scenario: This test is to verify the Botfunctions functionality in Smalltalk
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "botfunctions_smalltalk"
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
    And match $.text == "This message is returned from botfunctions"
    
    
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
    
    
    
    
     Scenario: This test is to verify KG primary FAQs are getting identified
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "How do I close savings bank account?"
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
    And match $.text == ["Please contact nearest branch to close savings bank account."]
    
    
    
      Scenario: This test is to verify KG Alternate FAQs are getting identified
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Can you show me the distance between Earth and Sun?"
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
    And match $.text == ["Current distance from Sun to Earth is 149.61 million km"]
    
    
    
       Scenario: This test is to verify KG Graph level synonyms are getting identified
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "How do I terminate savings bank account?"
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
    And match response.text == ["Please contact nearest branch to close savings bank account."]
    
    
    
    
       Scenario: This test is to verify KG path level synonyms are getting identified
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "How do I open current bank account ?"
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
    And match response.text == ["Please contact nearest branch to open checking bank account."]
    
    
      Scenario: This test is to verify Bot level synonms are getting identified in KG
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "What are the sources of UV radiation?"
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
    And match response.text == ["Ultraviolet (UV) radiation is a form of non-ionizing radiation that is emitted by the sun and artificial sources, such as tanning beds"]
    
    
    
      Scenario: This test is to verify Dialog task triggering from FAQ
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Trigger dialog from FAQ"
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
    And match response.text == ["Test Dialog triggered from FAQ"]
    
    
    
    
     Scenario: This test is to verify FAQ tries to trigger Dialog but dialog doesnt exist in the bot or deleted later
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "This is Sample FAQ linked with dialog but dialog removed later"
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
    And match response.text == "Sorry, answer for your question is not available."
    
    
    
    
    
    
    
    
     Scenario: This test is to verify the 'read more' link for huge responses in KG
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Show me Huge response faq"
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
   * def Text = response.text
   * print Text 
    
    
    
     Scenario: This test is to verify Order of messages in KG FAQ responses
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Show Order of Messages in KG"
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
    And match response.text == ["KG FAQ response1","KG FAQ response2","KG FAQ response3","KG FAQ response4"]
    
    
 
     Scenario: This test is to verify Alternate responses functionality in KG
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Alternate responses faq"
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
    #And match response contains ["Alternate Response2","Alternate Response1","Alternate Response3"] 
    
    
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
    
      Scenario: This test is to verify Data table record addition from service node
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "DataTableRecordAddition"
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
    
    
      Scenario: This test is to verify Data table record fetching from service node
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "DataTableRecordFetching"
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
    And match $.text == ["Records fetched from the data table :\n\ncustomer_id : 1234\ncustomer_name : Ram\ncustomer_address : Hyderabad\n"]
    
    
    
      Scenario: This test is to verify Data table record updation from service node
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "DataTableRecordUpdation"
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
  And match response.text == ["Record updation done successfully"]
  
  
   Scenario: This test is to verify Data table record deletion from service node
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "DataTableRecordDeletion"
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
  And match response.text == ["Record deleted successfully"]
  
  
  Scenario: This test is to verify that koreUtils Autotranslation functionality is working as expected or not
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "KoreUtilAutoTranslat"
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
  And match response.text == ["Dies ist eine Beispielnachricht"]
    
   
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
  
    
    Scenario: This test is to verify that koreUtils Moment functionality
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "koreUtilMoment"
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
    
     Scenario: This test is to verify that koreUtils Intl functionality
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "koreUtilIntl"
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
    * def constantValue = "123,456.789 12/20/2012"
    * print constantValue
    * def dateformat = response.text[0]
    * print dateformat
   
    
    
     
    Scenario: This test is to verify that koreUtils loadash functionality
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "KoreutilLoadash"
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
    And match response.text == ["ChunkArray : [[&quot;a&quot;,&quot;b&quot;],[&quot;c&quot;,&quot;d&quot;]]\nFilter Active : [&quot;barney&quot;]"]
    
  
  
   Scenario: This test is to verify koreUtil get session ID functionality
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "KoreUtilGetSessionId"
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
    
    
    
    
    
    
    
    
    
    Scenario: This test is to verify that PII data properly replaced/masked/redacted as per the settings and should be able to use it in service node
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "PIIValidation"
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
    And match response.text == "Enter host url"
    
   # When bot asks for host url, please enter "https://reqres.in/api/users"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "https://reqres.in/api/users"
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
    And match response.text == "Please provide your email address"
    
    
    # When bot asks for email address, please enter "tester@gmail.com"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "tester@gmail.com"
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
    And match response.text == "Please provide your phone number"
    
  # When bot asks for phone number, please enter "8985244504"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "8985244504"
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
    And match response.text == "Please provide SSN number"
    
    
  #When bot asks for SSN number, please enter "333-22-4444"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "333-22-4444"
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
    And match response.text == "Please provide Credit Card Number"
    
 #. When bot asks for Creditcard, please enter "9999888877775555"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "9999888877775555"
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
    * def Response = response.text
    * print Response
  
    
    Scenario: This test is to verify javascript text format rendering in chatwindow
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "TextFormatting"
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
    And match $.text == ["<b>This line is bold</b>\n<i>This line is in italic</i>"]
    
    
     Scenario: This test is to verify LOV enumerated rendering from context
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
   
    
     #Select "Mumbai" from the displayed city list
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Mumbai"
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
    And match $.text == ["City selected from LOV Enumerated From Context is Mumbai"]
    And match $.completedTaskName == "lovenumeratedfromcontext"
   
   
   
     Scenario: This test is to verify LOV enumerated rendering from static list
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
   
    
    
     #Select "Facebook" from the displayed city list
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Facebook"
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
    And match $.text == ["Company selected from LOV Enumerated from static list is Facebook"]
    
    
  
    
     Scenario: This test is to verify standard greetings smalltalk came with bot creation
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Hi"
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
   
    
     Scenario: This test is to verify custom smalltalk with response configured in standard mode
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "standard_smalltalk"
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
    And match $.text == "This response is from custom standard smalltalk"
    
    
    
    
     Scenario: This test is to verify custom smalltalk with response configured in Advanced javascript mode
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "javascript_smalltalk"
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
    And match $.text == "This response is from custom javascript smalltalk"
    
    
    
     Scenario: This test is to verify nested smalltalk functionality
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "mainsmalltalk"
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
    And match $.text == "main smalltalk response"
    
    
    #. Enter "nestedsmalltalk"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "nestedsmalltalk"
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
    And match $.text == "nested smalltalk response"
    
    
    #. Enter "nestedsmalltalk"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "nestedsmalltalk"
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
    And match $.text == ["I am unable to find an answer. Please try something else."]
    
    
    
    
    
  
     Scenario: This test is to verify smalltalk with combination of patterns and concepts
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "What is your name ?"
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
    * def Text1 = "I'm CustomerValidationBot1."
    * def Text = response.text
    * print Text
    And match Text == Text1
   
    
    
    
    
    
     Scenario: This test is to verify default standard response in bot
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "discard all"
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
    And match $.text == "Ok, I am discarding the task for now. We can start over whenever you are ready."
    
    
    
   
   
    
  
     Scenario: This test is to verify Sentiment Management Event trigger
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "I am very frustrated"
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
    And match $.text == "Angry tone even triggered from Sentiment Management"
    
    
    
    
       Scenario: This test is to verify setting of Enterprise context variable
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
   
    
     # Select "Set Enterprise Context Variable value"
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
    And match $.text == ["Enterprise key value pair set on this bot is 'enterpriseKey1':'enterpriseValue1' with ttl of 1 minute"]
    
    
   
   
    
       Scenario: This test is to verify setting of Bot context variable
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "BotContextValidation"
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
   
   # Select "Set Enterprise Context Variable value"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Set BotContext Variable value"
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
    And match $.text == ["BotContext key value pair set on this bot is 'botContextKey1':'botContextValue1' with ttl of 1 minute"]
    
    
    
# Now reexecute the dialog and then select "Get Enterprise Context Variable value"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "BotContextValidation"
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
   
  
   #Select "Get BotContext Variable value"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Get BotContext Variable value"
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
    And match $.text == ["BotContext value for the key 'botContextKey1' is botContextValue1"]
    
    
    
     Scenario: This test is to verify the fetching user details using UserContext
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """{
    "message": {
        "text": "UserContextValidation"
    },
    "from": {
        "id": "Kore123",
        "userInfo" :{
                        "firstName" : "Rama",
                        "lastName" : "Chandra",
                        "email" : "ramachandra.marreddi@kore.com"
                    }
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
    
    
    Scenario:This test is to verify the setting of User Session Variable
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "UserSessionValidation"
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
    
    
    
 # Select "Set User Session Variable value"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Set User Session Variable value"
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
    And match $.text == ["User Session key value pair set on this bot is 'userSessionKey1':'userSessionValue1' with ttl of 1 minute"]
    
    
  
    
    Scenario: This test is to verify the setting of User Session Variable
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "UserSessionValidation"
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
    
   #Select "Set User Session Variable value"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Set User Session Variable value"
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
    And match $.text == ["User Session key value pair set on this bot is 'userSessionKey1':'userSessionValue1' with ttl of 1 minute"]
    
    # Now reexecute the dialog and then select "Get User Session Variable value"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "UserSessionValidation"
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
    
    
    #Select "Get Bot User Session Variable value"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Get Bot User Session Variable value"
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
    And match $.text == ["User Session value for the key 'userSessionKey1' is userSessionValue1"]
    
    
    
    
    Scenario: This test is to verify setting and getting Bot User Session variable in javascript notation
      * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "JavascriptWayOfSettingContextVariables"
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
    And match $.text == ["Value set for testKey1 : testValue1"]
    
     Scenario: This test is to verify the accessibility of Last Message Object from BotUserSession
      * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "LastMessageObjectFromBotUserSession"
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
    And match $.text == ["This task failure event message rendered from environment variables"]
    
    
    
     Scenario: This test is to verify the getChoices() functionality when ambiguity is occured
      * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "ambiguity"
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
    And match $.text == "Ambiguity case triggered :\nAmbiguityDialog1,AmbiguityDialog2"
    
    
    
    
     Scenario: This test is to verify the deletion or clearing of context variable values using script node
      #Bot will display options with company names "Google","Facebook", "Apple", "Amazon"
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "ContextValuesClearingValidation"
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
 
    
    # Choose"Amazon"
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Amazon"
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
  
    #Selecting Yes or no option
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Yes"
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
    And match $.text == ["Context value cleared"]
    
    
    Scenario: This test is to verify scoping of environment variables using namespaces in dialog level
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "ScopingOfEnvironmentVariablesInDialog"
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
 
    
    # Selecting Dialog Level Scoping option
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Dialog Level Scoping"
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
    And match $.text == ["This environment variable value is getting resolved using namespace scoping from dialog level ---&gt;namespaces1_env_value1"]
    
    
    
    
    
     Scenario: This test is to verify the scoping of environment variables using namespaces in dialog component level override
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "ScopingOfEnvironmentVariablesInDialog"
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
 
    
    # Selecting Component Level Scoping option
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Component Level Scoping"
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
    And match $.text == ["This environment variable value is getting resolved using namespace scoping component level(Not from dialog level) ---&gt;namespaces2_env_value1"]
    
    
    
     Scenario: This test is to verify namespace scoped environment variables are getting resolved in KG responses
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "KG namespace scoped environment variable access"
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
    And match $.text == ["Environment variable value should be diaplayed after arrow---&gt;namespaces1_env_value1"]
    
    
    Scenario: This test is to verify KG responses for resolving non-scoped environment variables
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "KG non-namespace scoped environment variable access"
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
    And match $.text == ["Environment variable value should not be diaplayed after arrow---&gt;"]
    
    
    
    
    
    
    
    Scenario: This test is to verify small talk responses for resolving scoped environment variables
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "scoped_env_smalltalk"
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
    And match $.text == "Env variable value should be displayed after arrow---&gt;namespaces2_env_value1"
    
    
    
    
    Scenario: This test is to verify small talk responses for resolving non-scoped environment variables
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "nonscoped_env_smalltalk"
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
    And match $.text == "Env variable value should not be displayed after arrow---&gt;"
  
    
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
    
    
    
    
    Scenario: This test is to verify koreDebugger.log() functionality in the bot
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "KoreDebuggerValidation"
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
    And match $.text == ["Debug executed. Please verify NLP metrics debug logs, you should see &quot;Sample debug log&quot;"]
    
    
    
     Scenario: This test is to verify message tone and dialog tone identification functionality
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "ToneAnalysis"
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
    
    # Entering input I am very happy about this news
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "I am very happy about this news"
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
    And match $.text == ["Message tone joy identified\nDialog tone joy identified"]
    
    
    
    Scenario: This test is to verify message tone and dialog tone identification functionality
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "ToneAnalysis"
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
    
    # Entering input  I am very sad
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "I am very sad"
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
    And match $.text == ["Message tone sad identified\Dialog tone sad identified"]
    
    
    
     Scenario: This test is to verify subintent trigger functionality from Dialog
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "MainIntentToSubintentValidation"
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
    
    #  Enter subintent input as "Subintent trigger"
      * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Subintent trigger"
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
    And match $.text == ["Subintent triggered successfully"]
    
    
    
    
    
    
    
    
    
    
    
    
     Scenario: This test is to verify Linking dialog functionality with Resuming parent dialog after execution
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "LinkedDialog1"
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
    
    #Enter "Execute Dialog2 and Resume to Dialog1"
      * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Execute Dialog2 and Resume to Dialog1"
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
    And match $.text == ["Dialog2 triggered successfully","Dialog1 Resumed."]
    
    
    
    
    
     Scenario:This test is to verify Linking dialog functionality with discarding parent dialog and continue with only linked dialog
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "LinkedDialog1"
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
    
    # Enter "Execute Dialog2 and Do not Resume to Dialog1"
      * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Execute Dialog2 and Do not Resume to Dialog1"
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
    And match $.text ==  ["Dialog2 triggered successfully"]
    
    
    
    
    
    
    
    
    
    Scenario: This test is to verify Followup intents functionality in the bot
      * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "bookflight and bookhotel"
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
    And match $.text == ["Book Flight dialog triggered successfully","Book Hotel dialog triggered successfully"]
    
    
    
    
    
    
    
    
    
    Scenario: This test is to verify Soap requests accessibility functionality in platform
      * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "SoapAPIValidation"
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
    And match $.text ==  ["AddSoapIn"]
    
    
   
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
    
    
    Scenario: This test is to verify namespace scoped environment variable access in TaskFailure Event
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "TaskFailureEventTrigger"
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
    
    #Choose either "Service Node" or "Script Node"
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Service Node"
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
    And match $.text == ["This task failure event message rendered from environment variables"]
    
    
    
    
    
    
    
     Scenario: This is to verify the functionality of TaskFailureEvent trigger, When script or service node failed
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "TaskFailureEventTrigger"
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
    
    # Choose "Service Node"

     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Service Node"
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
    And match $.text == ["This task failure event message rendered from environment variables"]
    
    
    
    
     Scenario: This is to verify the functionality of TaskFailureEvent trigger, When script or service node failed
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "TaskFailureEventTrigger"
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
    
    #choose Script Node
     * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Script Node"
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
    And match $.text == ["This task failure event message rendered from environment variables"]
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     Scenario: This test is to verify customized standard response for node execution limit exceeded
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
    * def Text = response.text
    * print Text
    
    
    