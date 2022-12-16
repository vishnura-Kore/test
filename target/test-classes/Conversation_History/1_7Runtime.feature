@R10.0
Feature: RunTime Scenarios

  Background: 
    * url jwturl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')

  Scenario: Generate JWT Token
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def smartclientsecret1 = JavaClass.get('smartclientsecret1')
    * def userID1 = JavaClass.get('userID1')
    * print userID1
    * print smartclientId1
    * print smartclientsecret1
    * def Payload =
      """
       {
       "clientId": "smartclientId1",
       "clientSecret": "smartclientsecret1",
       "identity": "userID1",
       "aud": "",
       "isAnonymous": true
      }
      """
    * set Payload.clientId = smartclientId1
    * set Payload.identity = userID1
    * set Payload.clientSecret = smartclientsecret1
    * print Payload
    And request Payload
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def ConsumerWebHookJWT = response.jwt
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('ConsumerWebHookJWT', ConsumerWebHookJWT)
    And print  'Response is ' , response


Scenario: input hi
    * def Payload =
      """
        {
        "message": {
            "text": "hi"
        },
        "from": {
            "id": "intnotiden"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def streamId = JavaClass.get('streamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print streamId
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
  
Scenario: intent not identified event
    * def Payload =
      """
        {
        "message": {
            "text": "xyz"
        },
        "from": {
            "id": "intnotiden"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def streamId = JavaClass.get('streamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print streamId
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: Intent Identification
    * def streamId = JavaClass.get('streamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print streamId
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Execution"
        },
        "from": {
            "id": "intentidentification1"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    #sending Confirmation node value
    
    * def streamId = JavaClass.get('streamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print streamId
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "TestRunTime"
        },
        "from": {
            "id": "intentidentification1"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
   Scenario: Confirmation retry Identification
    
    * def streamId = JavaClass.get('streamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print streamId
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Login"
        },
        "from": {
            "id": "Confiretry"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    # confirmation retry prompt
    
    * def streamId = JavaClass.get('streamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print streamId
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "test"
        },
        "from": {
            "id": "Confiretry"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
     # confirmation entry prompt
    
    * def streamId = JavaClass.get('streamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print streamId
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "yes"
        },
        "from": {
            "id": "Confiretry"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
     # Entry retry prompt
    
    * def streamId = JavaClass.get('streamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print streamId
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "test"
        },
        "from": {
            "id": "Confiretry"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
     # Email prompt
    
    * def streamId = JavaClass.get('streamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print streamId
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "abc@gmail.com"
        },
        "from": {
            "id": "Confiretry"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    