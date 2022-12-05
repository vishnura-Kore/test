@token
Feature: Login Into AnotherAccount

  Background: 
    * url appUrl

  Scenario: Generate AuthToken
    Given path 'oauth/token'
    When request { "password":'Kore#1122', "client_id":"1", "client_secret":"1","scope":"friends","grant_type":"password","username":'zudij@getairmail.com' }
    And method post
    Then status 200
    And print 'Response is: ', response
    And def accessToken2 = response.authorization.accessToken
    And def orgId2 = response.userInfo.orgID
    And def userId2 = response.userInfo.id
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('userId2', userId2)
    * JavaClass.add('accessToken2', accessToken2)
    * print accessToken2
    * print orgId2
    * print userId2

  Scenario: Generate AuthToken
    Given path 'oauth/token'
    When request { "password":'Kore#1122', "client_id":"1", "client_secret":"1","scope":"friends","grant_type":"password","username":'zudij@getairmail.com' }
    And method post
    Then status 200
    And def botadminaccesstokenuser2 = response.authorization.accessToken
    And def botadminorgID2 = response.userInfo.orgID
    And def botadminUserID2 = response.authorization.resourceOwnerID
    And def adminaccountID2 = response.authorization.accountId
    And def userID2 = response.userInfo.id
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('botadminorgID2', botadminorgID2)
    * JavaClass.add('botadminUserID2', botadminUserID2)
    * JavaClass.add('adminaccountID2',adminaccountID2)
    * JavaClass.add('botadminaccesstokenuser2', botadminaccesstokenuser2 )
    * JavaClass.add('userID2',userID2);
    And print 'Response is: ', response
    * print botadminorgID2
    * print botadminUserID2
    * print botadminaccesstokenuser2
    * print userID2
    * print adminaccountID2

  Scenario: create appscope
   * def JavaClass = Java.type('data.commonJava')
    * def name = JavaClass.generateRandom('string')
    * print name
    * def JavaClass = Java.type('data.HashMap')
    * def botadminUserID2 = JavaClass.get('botadminUserID2')
    * def adminaccountID2 = JavaClass.get('adminaccountID2')
    * def botadminorgID2 = JavaClass.get('botadminorgID2')
    * def botadminaccesstokenuser2 = JavaClass.get('botadminaccesstokenuser2')
     * def adminaccountID2 = JavaClass.get('adminaccountID2')
    * def Payload =
      """
      {
      "algorithm": "HS256",
      "appName": "sanityadminapp",
      "bots": [],
      "pushNotifications": {
        "enable": false,
        "webhookUrl": ""
      },
      "isJtiEnforced": false,
      "isJweEnforced": false
      }
      """
    * set Payload.appName = "sanityadminapp"+name
    * print Payload
    Given path '/organization/'+botadminorgID2+'/users/'+botadminUserID2+'/sdk/apps'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser2
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID2
    When method post
    Then status 200
    And print 'Response is: ', response
    * def scopeclientId12 = response.clientId
    * def scopeclientSecret12 = response.clientSecret
    * def scopeappName = response.appName
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('scopeclientSecret12', scopeclientSecret12)
    * JavaClass.add('scopeclientId12', scopeclientId12)
    * JavaClass.add('scopeappName', scopeappName)
    * print scopeclientSecret12
    * print scopeappName
    * print scopeclientId12

  Scenario: Assiging appscopes
    * def JavaClass = Java.type('data.HashMap')
    * def botadminUserID2 = JavaClass.get('botadminUserID2')
    * def adminaccountID2 = JavaClass.get('adminaccountID2')
    * def botadminorgID2 = JavaClass.get('botadminorgID2')
    * def scopeclientId12 = JavaClass.get('scopeclientId12')
    * def botadminaccesstokenuser2 = JavaClass.get('botadminaccesstokenuser2')
    * def scopeappName = JavaClass.get('scopeappName')
    * print  botadminUserID2
    * print botadminorgID2
    * print scopeclientId12
    * def Payload = read('AssginingAppScopes.json')
    * set Payload.appName = scopeappName
    * print Payload
    Given path '/organization/'+botadminorgID2+'/users/'+botadminUserID2+'/sdk/apps/'+scopeclientId12
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser2
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'PUT'
    And header accountid = adminaccountID2
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: creating a bot in Second Account
   * def JavaClass = Java.type('data.HashMap')
   
    * def botadminUserID2 = JavaClass.get('botadminUserID2')
    * def adminaccountID2 = JavaClass.get('adminaccountID2')
    * def botadminorgID2 = JavaClass.get('botadminorgID2')
    * def botadminaccesstokenuser2 = JavaClass.get('botadminaccesstokenuser2')
    * def JavaClass = Java.type('data.commonJava')
    * def name = JavaClass.generateRandom('number')
    * print name
    * def Payload = read('CreateBot2.json')
    * set Payload.name = 'SanityBot'+name
    * print  Payload
    Given path 'users/'+botadminUserID2+'/builder/streams'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser2
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID2
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.name == Payload.name
    * def SanityStreamId2 = response._id
    * print 'SanityBot streamID is:',SanityStreamId2
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('SanityStreamId2', SanityStreamId2)
    * print SanityStreamId2

  Scenario: create appscope
    * def JavaClass = Java.type('data.HashMap')
     * def JavaClass = Java.type('data.commonJava')
     * def name = JavaClass.generateRandom('string')
     * def botadminUserID2 = JavaClass.get('botadminUserID2')
    * def adminaccountID2 = JavaClass.get('adminaccountID2')
    * def botadminorgID2 = JavaClass.get('botadminorgID2')
    * def adminaccountID2 = JavaClass.get('adminaccountID2')
    * def SanityStreamId2 = JavaClass.get('SanityStreamId2')
    * def botadminaccesstokenuser2 = JavaClass.get('botadminaccesstokenuser2')
    * def Payload =
      """
      {
      "appName": "{{App1Stream1}}",
      "scope": [],
      "pushNotifications": {
         "enable": false,
         "webhookUrl": ""
      },
      "algorithm": "HS256",
      "bots": [
         "SanityStreamId2"
      ]
      }
      """
    * set Payload.bots[0] = SanityStreamId2
    * print Payload
    Given path '/users/'+botadminUserID2+'/streams/'+SanityStreamId2+'/sdk/apps'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser2
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID2
    When method post
    Then status 200
    And print 'Response is: ', response
    * def App1Stream1ClientId1 = response.clientId
    * print 'appList account id is:',App1Stream1ClientId1
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('App1Stream1ClientId1', App1Stream1ClientId1)
    * print App1Stream1ClientId1

  Scenario: sendemail
    * def JavaClass = Java.type('data.HashMap')
    * def SanityStreamId2 = JavaClass.get('SanityStreamId2')
    * print SanityStreamId2
    * def botadminUserID2 = JavaClass.get('botadminUserID2')
    * def adminaccountID2 = JavaClass.get('adminaccountID2')
    * def botadminaccesstokenuser2 = JavaClass.get('botadminaccesstokenuser2')
    Given path 'users/'+botadminUserID2+'/builder/streams/'+SanityStreamId2
    And header Authorization = 'bearer '+botadminaccesstokenuser2
    And header Content-Type = 'application/json'
    When method get
    Then status 200

  Scenario: Create Component - Intent_SendEmail
    * def JavaClass = Java.type('data.HashMap')
    * def SanityStreamId2 = JavaClass.get('SanityStreamId2')
    * def botadminaccesstokenuser2 = JavaClass.get('botadminaccesstokenuser2')
    Given path 'builder/streams/'+SanityStreamId2+'/components'
    When request {"desc": "Test Automation","type": "intent","intent": "SendEmail"}
    And header Authorization = 'bearer '+botadminaccesstokenuser2
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    * def SendEmailRefId1 = response._id
    * def SendEmailIntentName1 = response.name
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('SendEmailRefId1', SendEmailRefId1)
    * JavaClass.add('SendEmailIntentName1', SendEmailIntentName1)
    * print SendEmailIntentName1
    * print SendEmailRefId1

  Scenario: Add component to Dialog
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser2 = JavaClass.get('botadminaccesstokenuser2')
    * def SanityStreamId2 = JavaClass.get('SanityStreamId2')
    * def SendEmailIntentName1 = JavaClass.get('SendEmailIntentName1')
    * def SendEmailRefId1 = JavaClass.get('SendEmailRefId1')
    * print SendEmailIntentName1
    * def Payload =
      """
       {
      "name": "SendEmailIntentName1",
      "shortDesc": "Sending Email",
      "nodes": [
          {
              "nodeId": "intent0",
              "type": "intent",
              "componentId": "SendEmailRefId1",
              "transitions": [
                  {
                      "default": "",
                      "metadata": {
                          "color": "#299d8e",
                          "connId": "dummy0"
                      }
                  }
              ],
              "metadata": {
                  "left": 31,
                  "top": 18
              }
          }
      ],
      "visibility": {
          "namespace": "private",
          "namespaceIds": [
              ""
          ]
      }
      }
      """
    * set Payload.name = SendEmailIntentName1
    * set Payload.nodes[0].componentId = SendEmailRefId1
    * print Payload
    Given path 'builder/streams/'+SanityStreamId2+'/dialogs'
    When request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser2
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    * def SendEmailDialogID1 = response._id
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('SendEmailDialogID1', SendEmailDialogID1)

  Scenario: Add Dialog to Bot
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser2 = JavaClass.get('botadminaccesstokenuser2')
    * def SendEmailRefId1 = JavaClass.get('SendEmailRefId1')
    * def SendEmailIntentName1 = JavaClass.get('SendEmailIntentName1')
    * def SendEmailDialogID1 = JavaClass.get('SendEmailDialogID1')
    * def SanityStreamId2 = JavaClass.get('SanityStreamId2')
    * print SendEmailIntentName1
    * print SendEmailDialogID1
    * def Payload =
      """
      {
      "name": "email",
      "dialogId": "SendEmailDialogID1"
      }
      """
    * set Payload.dialogId = SendEmailDialogID1
    * print Payload
    When path 'builder/streams/'+SanityStreamId2+'/components/'+SendEmailRefId1
    When request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser2
    And header Content-Type = 'application/json'
    When method put
    Then status 200

  Scenario: EnitityCreation_Email
    * def JavaClass = Java.type('data.HashMap')
    * def SanityStreamId2 = JavaClass.get('SanityStreamId2')
    * def botadminaccesstokenuser2 = JavaClass.get('botadminaccesstokenuser2')
    When path 'builder/streams/'+SanityStreamId2+'/components'
    When request
      """
      {
      "name": "{{email}}",
      "type": "entity",
      "message": [
         {
             "channel": "default",
             "text": "Please provide your email address",
             "type": "basic"
         }
      ],
      "entityType": "email",
      "errorMessage": [
         {
             "text": "I'm sorry, I did not recognize the email you entered. Please enter the email again. An example of an email address is JohnDoe@abc.com.",
             "type": "basic",
             "channel": "default"
         }
      ]
      }
      """
    And header Authorization = 'bearer '+botadminaccesstokenuser2
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    * def SendEmailEntityRefID1 = response._id
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('SendEmailEntityRefID1', SendEmailEntityRefID1)
