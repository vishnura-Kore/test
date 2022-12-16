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

  Scenario: input Ambiguous Intent
    * def Payload =
      """
        {
        "message": {
            "text": "Book a Flight"
        },
        "from": {
            "id": "Webhook"
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
    And match response.text contains 'Select an option'
    And match response.text contains 'Book a Flight from Delhi to Hyderabad'
    And match response.text contains 'Book a Flight from Hyderabad to Delhi' 
    
    
    Scenario: input Flight Booking
    * def Payload =
      """
        {
        "message": {
            "text": "Book a Flight from Hyderabad to Delhi"
        },
        "from": {
            "id": "Webhook"
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
    And match response.text[0] == 'Book a Flight from Hyderabad to Delhi'
    And match response.completedTaskName == 'book a flight from hyderabad to delhi'
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('completedTaskId', response.completedTaskId)
    * def taskID = response.completedTaskId
    * print taskID
    
    
    
    
    
    
    
    
    
    
    
