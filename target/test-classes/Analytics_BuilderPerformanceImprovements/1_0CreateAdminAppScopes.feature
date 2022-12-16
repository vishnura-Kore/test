@runtime
Feature: feature to  login into BotAdimConsole

  Background: 
    * url appUrl

  Scenario: Generate AuthToken
    Given path 'oauth/token'
    When request { "password":'#(password)', "client_id":"1", "client_secret":"1","scope":"friends","grant_type":"password","username":'#(username)' }
    And method post
    Then status 200
    And def botadminaccesstokenuser1 = response.authorization.accessToken
    And def botadminorgID1 = response.userInfo.orgID
    And def botadminUserID1 = response.authorization.resourceOwnerID
    And def adminaccountID1 = response.authorization.accountId
    And def userID1 = response.userInfo.id
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('botadminorgID1', botadminorgID1)
    * JavaClass.add('botadminUserID1', botadminUserID1)
    * JavaClass.add('adminaccountID1',adminaccountID1)
    * JavaClass.add('botadminaccesstokenuser1', botadminaccesstokenuser1 )
    * JavaClass.add('userID1',userID1);
    And print 'Response is: ', response
    * print botadminorgID1
    * print botadminUserID1
    * print botadminaccesstokenuser1
    * print userID1
    * print adminaccountID1

  Scenario: create appscope
    * def JavaClass = Java.type('data.commonJava')
    * def name = JavaClass.generateRandom('string')
    * print name
    * def JavaClass = Java.type('data.HashMap')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def Payload =
      """
      {
      "algorithm": "HS256",
      "appName": "sanityadminapp",
      "bots": [],
      "pushNotifications": {
         "enable": false,
         "webhookUrl": ""
      }
      }
      """
    * set Payload.appName = "sanityadminapp"+name
    * print Payload
    Given path '/organization/'+botadminorgID1+'/users/'+botadminUserID1+'/sdk/apps'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header accountid = adminaccountID1
    When method post
    Then status 200
    And print 'Response is: ', response
    * def scopeclientId1 = response.clientId
    * def scopeclientSecret1 = response.clientSecret
    * def scopeappName = response.appName
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('scopeclientSecret1', scopeclientSecret1)
    * JavaClass.add('scopeclientId1', scopeclientId1)
    * JavaClass.add('scopeappName', scopeappName)
    * print scopeclientSecret1
    * print scopeappName
    * print scopeclientId1

  Scenario: Assiging appscopes
    * def JavaClass = Java.type('data.HashMap')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def scopeclientId1 = JavaClass.get('scopeclientId1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def scopeappName = JavaClass.get('scopeappName')
    * print  botadminUserID1
    * print botadminorgID1
    * print scopeclientId1
    * def Payload = read('AssginingAppScopes.json')
    * set Payload.appName = scopeappName
    * print Payload
    Given path '/organization/'+botadminorgID1+'/users/'+botadminUserID1+'/sdk/apps/'+scopeclientId1
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'PUT'
    When method post
    Then status 200
    And print 'Response is: ', response
