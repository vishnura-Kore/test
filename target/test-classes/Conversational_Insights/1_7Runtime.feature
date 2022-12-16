@R10.0
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

  Scenario: input Login
    * def Payload =
      """
        {
        "message": {
            "text": "Login"
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

  Scenario:input Register
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
        {
        "message": {
            "text": "Register"
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
    
      Scenario: input Booking
    * def Payload =
      """
        {
        "message": {
            "text": "Booking"
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
