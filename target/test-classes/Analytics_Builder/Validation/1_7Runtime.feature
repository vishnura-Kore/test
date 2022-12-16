@runtime
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

  Scenario: runtime1
    * def Payload =
      """
        {
        "message": {
            "text": "Hi"
        },
        "from": {
            "id": ""
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.from.id = "Kore"+name
   * def UserId1 = Payload.from.id
    * print UserId1
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

  Scenario: runtime2
    * def streamId = JavaClass.get('streamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print streamId
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "variableCheck"
        },
        "from": {
            "id": ""
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
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
    
     Scenario: runtime3
    * def Payload =
      """
        {
        "message": {
            "text": "asdfsdfsd"
        },
        "from": {
            "id": ""
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.from.id = "Kore"+name
     * def UserId3 = Payload.from.id
    * print UserId3
    * def streamId = JavaClass.get('streamId')
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
    
    
      Scenario: runtime4
    * def Payload =
      """
        {
        "message": {
            "text": "FunctionCheck"
        },
        "from": {
            "id": ""
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.from.id = "Kore"+name
     * def UserId6 = Payload.from.id
    * print UserId6
    * def streamId = JavaClass.get('streamId')
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
    
    
    
    
      Scenario: runtime5
    * def Payload =
      """
        {
        "message": {
            "text": "SendEmail"
        },
        "from": {
            "id": ""
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.from.id = "Kore"+name
    * def UserId5 = Payload.from.id
    * print UserId5
    * def streamId = JavaClass.get('streamId')
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
    
    
    
    Scenario: runtime6
    * def Payload =
      """
        {
        "message": {
            "text": "hello"
        },
        "from": {
            "id": ""
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.from.id = "Kore"+name
   * def UserId6 = Payload.from.id
    * print UserId6
    * def streamId = JavaClass.get('streamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
 Scenario: runtime6
    * def Payload =
      """
        {
        "message": {
            "text": "how r u"
        },
        "from": {
            "id": ""
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.from.id = "Kore"+name
   * def UserId6 = Payload.from.id
    * print UserId6
    * def streamId = JavaClass.get('streamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response