@runtime
Feature: Enable channel and creating app

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
     * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')

  Scenario: create appscope
    * def streamId = JavaClass.get('streamId')
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload =
      """
      {
      "appName": "Test",
      "algorithm": "HS256",
      "scope": [
         "anonymouschat",
         "registration"
      ],
      "bots": [
         "PstreamId"
      ],
      "pushNotifications": {
         "enable": false,
         "webhookUrl": ""
      }
      }
      """
    * set Payload.appName = 'Test'+name
    * set Payload.bots[0] = streamId
    * print Payload
    Given path '/users/'+botadminUserID1+'/streams/'+streamId+'/sdk/apps'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def smartclientId1 = response.clientId
    * def smartclientsecret1 = response.clientSecret
    * print 'appList account id is:',smartclientId1
    * JavaClass.add('smartclientId1', smartclientId1)
    * JavaClass.add('smartclientsecret1', smartclientsecret1)
    * print smartclientId1
    * print smartclientsecret1

  Scenario: Enabling channel
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def streamId = JavaClass.get('streamId')
    * print streamId
    * print smartclientId1
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload =
      """
      {
      "app": {
          "clientId": "smartclientId1",
          "appName": "apppublic"
      },
      "displayName": "webhook",
      "type": "ivr",
      "isAsync": false,
      "enable": true,
      "createInstance": true
      }
      """
    * set Payload.app.appName = 'apppublic'+name
    * set Payload.app.clientId = smartclientId1
    * set Payload.displayName = '	webhook'+name
    * print Payload
    Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId+'/channels/ivr'
    And request  Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200

  Scenario: Publish
    * def streamId = JavaClass.get('streamId')
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
