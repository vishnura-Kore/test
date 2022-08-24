@runtime
Feature: RunTime Scenarios

  Background: 
    * url appUrl
    * url jwturl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def StreamID = JavaClass.get('StreamID')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def JWTToken = JavaClass.get('JWTToken')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')

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

  Scenario: Input SendEmail
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
    * def StreamID = JavaClass.get('StreamID')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+StreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: Input  with 1201 characters
    * def Payload =
      """
        {
        "message": {
            "text": ""
        },
        "from": {
            "id": ""
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.message.text = read('jsonfilewith1201characters.json')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+StreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..text == ["Looks like you have mistyped a really long word. Please check if you have missed a space or spelled a word incorrectly."]

  Scenario: Input with 6001 words
    * def Payload =
      """
        {
        "message": {
            "text": ""
        },
        "from": {
            "id": ""
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.message.text = read('jsonfilewith6001words.json')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+StreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..text == ["Looks like you have mistyped a really long word. Please check if you have missed a space or spelled a word incorrectly."]

  Scenario: Editing  Standard Response in Webhook Channel
    Given url appUrl
    * def payload = read('payload2.json')
    * set payload.streamId = StreamID
    Given path '/users/'+botadminUserID1+'/builder/streams/'+StreamID+'/koraGenericResp/condition'
    And param rnd = '140kqh'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header X-HTTP-Method-Override = 'put'
    And header Host = '<calculated when request is sent>'
    And header accountid = adminaccountID1
    And request payload
    When method post
    Then status 200
    And print responseTime
    And print response
    And match $.streamId == StreamID
    * def ID = response._id
    * JavaClass.add('ID',ID)

 Scenario: Publishing the bot
    * def PstreamId = JavaClass.get('StreamID')
    Given url publicUrl
    Then path '/public/bot/'+StreamID+'/publish'
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







  Scenario: Input with 1201 characters
    * def Payload =
      """
        {
        "message": {
            "text": ""
        },
        "from": {
            "id": ""
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.message.text = read('jsonfilewith1201characters.json')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+StreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..text == ["Validating Webhook response"]
    
    
     Scenario: Input with 6001 words
    * def Payload =
      """
        {
        "message": {
            "text": ""
        },
        "from": {
            "id": ""
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.message.text = read('jsonfilewith6001words.json')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+StreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
     And match $..text == ["Validating Webhook response"]
     
     
     
     Scenario: Deleting Standard Response in Webhook Channel
    Given url appUrl
    * def payload = read('deletestandardresponse.json')
    * set payload.streamId = StreamID
    Given path '/users/'+botadminUserID1+'/builder/streams/'+StreamID+'/koraGenericResp/condition'
    And param rnd = '140kqh'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header X-HTTP-Method-Override = 'put'
    And header Host = '<calculated when request is sent>'
    And header accountid = adminaccountID1
    And request payload
    When method post
    Then status 200
    And print responseTime
    And print response
    
    
    Scenario: Input with 1201 characters without publishing the bot
    * def Payload =
      """
        {
        "message": {
            "text": ""
        },
        "from": {
            "id": ""
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.message.text = read('jsonfilewith1201characters.json')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+StreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..text == ["Validating Webhook response"]
    
    
    Scenario: Publishing the bot
    * def PstreamId = JavaClass.get('StreamID')
    Given url publicUrl
    Then path '/public/bot/'+StreamID+'/publish'
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
    
    
     Scenario: Input with 1201 characters after publishing the bot
    * def Payload =
      """
        {
        "message": {
            "text": ""
        },
        "from": {
            "id": ""
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * set Payload.message.text = read('jsonfilewith1201characters.json')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+StreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..text == ["Looks like you have mistyped a really long word. Please check if you have missed a space or spelled a word incorrectly."]
    
    
    
    
    Scenario: Get all dialog ids in bot
    Given url appUrl
    Then path '/builder/streams/'+StreamID+'/dialogs'
   And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print response
    * def ID1 = response[0]._id
    * def ID2 = response[1]._id
    * def ID3 = response[2]._id
    * def ID4 = response[3]._id
    * def ID5 = response[4]._id
    * JavaClass.add('ID1',ID1)
    * JavaClass.add('ID2',ID2)
    * JavaClass.add('ID3',ID3)
    * JavaClass.add('ID4',ID4)
    * JavaClass.add('ID5',ID5)
    
    
    
    Scenario: Suspending tasks 
    Given url appUrl
    * def ID1 = JavaClass.get('ID1')
    * def ID2 = JavaClass.get('ID2')
    * def ID3 = JavaClass.get('ID3')
    * def ID4 = JavaClass.get('ID4')
    * def ID5 = JavaClass.get('ID5')
    * def payload = read('Suspendtasks.json')
    * set payload[0].dialogId = ID1
    * set payload[1].dialogId = ID2
    * set payload[2].dialogId = ID3
    * set payload[3].dialogId = ID4
    * set payload[4].dialogId = ID5
    Given path '/organization/'+botadminorgID1+'/workflows/updateTaskStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header X-HTTP-Method-Override = 'put'
    And header Host = '<calculated when request is sent>'
    And header accountid = adminaccountID1
    And request payload
    When method post
    Then status 200
    And print responseTime
    And print response
   
    
 
    
    
    
    
    
    
    
    
