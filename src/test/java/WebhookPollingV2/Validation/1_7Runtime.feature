@runtime
Feature: RunTime Scenarios

  Background: 
     * url appUrl
    * url jwturl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def streamId = JavaClass.get('streamId')
     * def JWTToken = JavaClass.get('JWTToken')
     * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')

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

  Scenario: input Variable check
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
       {
      "message": {
      "type" : "text",
      "val" : "Verify Service Request"
      },
      "from": {
      "id": "New1234"
      },
      "to": {
      "id": "4321"
      }
      
      }
        
      """
    Given url runtimeUrl
    Then path 'chatbot/v2/webhook/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def Pollid = response.pollId
    * JavaClass.add('Pollid',Pollid)
     And match response.pollId == '#present'
   
    
    
    Scenario: input pollId
    * def Pollid = JavaClass.get('Pollid')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    Given url runtimeUrl
    Then path '/chatbot/v2/webhook/'+streamId+'/poll/'+Pollid
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    

    
    
    
    
    
     Scenario: disablibg polling option in  Webhook channel
     Given url appUrl
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * print smartclientId1
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload =
      """
     {
    "app": {
        "clientId": "cs-109eff01-e352-51c5-896e-04f700a2565f",
        "appName": "Test5399"
    },
    "displayName": "\twebhook8754",
    "type": "ivr",
    "isAsync": false,
    "enable": true,
    "enablePolling": false
}
      }
      """
   
    * set Payload.app.clientId = smartclientId1
    * set Payload.displayName = 'webhook'+name
    * print Payload
    Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId+'/channels/ivr'
    And request  Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print response
    
     Scenario: Publishing the bot
    Given url publicUrl
    Then path '/public/bot/'+streamId+'/publish'
    And request
      """
      {
      "versionComment": "new update"
      }
      """
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
     Scenario: input Variable check
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    * def Payload =
      """
       {
      "message": {
      "type" : "text",
      "val" : "Verify Service Request"
      },
      "from": {
      "id": "New1234"
      },
      "to": {
      "id": "4321"
      }
      
      }
        
      """
    Given url runtimeUrl
    Then path 'chatbot/v2/webhook/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
     And match response.pollId == '#notpresent'
    