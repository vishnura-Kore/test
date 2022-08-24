@runtime
Feature: Creating AppScopes in Bot Builder

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def JWTToken1 = JavaClass.get('JWTToken1')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def name = JavaMethods.generateRandom('number')
    * print SanitystreamId
    * def JWTToken1 = JavaClass.get('JWTToken1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')

  Scenario: create appscope
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
    Given path '/users/'+botadminUserID1+'/streams/'+SanitystreamId+'/sdk/apps'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def scopeclientId2 = response.clientId
    * def scopeclientSecret2 = response.clientSecret
    * def scopeappName2 = response.appName
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('scopeclientSecret2', scopeclientSecret2)
    * JavaClass.add('scopeclientId2', scopeclientId2)
    * JavaClass.add('scopeappName2', scopeappName2)
    * print scopeclientSecret2
    * print scopeappName2
    * print scopeclientId2

  Scenario: Assiging appscopes
    * def JavaClass = Java.type('data.HashMap')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def scopeclientId2 = JavaClass.get('scopeclientId2')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def scopeappName2 = JavaClass.get('scopeappName2')
    * print botadminUserID1
    * print botadminorgID1
    * print scopeclientId2
    * def Payload = read('JSONUploadFiles/AssigingAppScpopes.json')
    * set Payload.bots[0] = SanitystreamId
    * set Payload.scope[0].bot = SanitystreamId
    * set Payload.appName = scopeappName2
    * print Payload
    Given path '/users/'+botadminUserID1+'/streams/'+SanitystreamId+'/sdk/apps/'+scopeclientId2
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'PUT'
    When method post
    Then status 200
    And print 'Response is: ', response
