@runtime
Feature: RunTime Scenarios

  Background: 
    * url jwturl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
     * def streamId = JavaClass.get('streamId')

  Scenario: Generating JWT Token
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

  Scenario: input hello
    * def Payload =
      """
        {
        "message": {
            "text": "Hello"
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
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: input hola
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "hola"
        },
        "from": {
            "id": "kore1234"
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
    
     Scenario: input Yes
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Yes"
        },
        "from": {
            "id": "kore1234"
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
    
    
    
      Scenario: input how r u in spanish
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Estoy bien. Gracias."
        },
        "from": {
            "id": "kore1234"
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
