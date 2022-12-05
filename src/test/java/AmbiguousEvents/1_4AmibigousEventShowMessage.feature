@R10.0
Feature: Enable the Amibigous Event with the show message

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def streamId = JavaClass.get('streamId')
    * def JWTToken = JavaClass.get('JWTToken')
    * def Botname = JavaClass.get('Botname')
  
  Scenario: Login into the Bot Builder
  Given path 'oauth/token'
  When request { "password":'#(password)', "client_id":"1", "client_secret":"1","scope":"friends","grant_type":"password","username":'#(username)' }
  And method post
  Then status 200
  * def JavaClass = Java.type('data.HashMap')
  * JavaClass.add('accountID', response.authorization.accountId)
  * JavaClass.add('accessToken', response.authorization.accessToken)
  * JavaClass.add('userId',response.userInfo.id)
  * JavaClass.add('orgID', response.userInfo.orgID )
  And print 'Response is: ', response  
  
  Scenario: Enable the Amibiguous event with Show Message
  * def JavaClass = Java.type('data.HashMap')
  * def accountID = JavaClass.get('accountID')
  * def userId = JavaClass.get('userId')
  * def orgID = JavaClass.get('orgID')
  * def accessToken = JavaClass.get('accessToken')
  
  Given path 'users/'+userId+'/builder/streams/'+streamId+'/events'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountID
  And header X-HTTP-Method-Override = 'put'
  * def Payload = read('ShowMessagePayload.json')
  * set Payload.botEvent.AMBIGUOUS_INTENTS.enabled = true
  * print Payload
  And request Payload
  When method post
  Then status 200
  And print response
  And match response.botEvents.AMBIGUOUS_INTENTS.enabled == true
  And match response.botEvents.AMBIGUOUS_INTENTS.action == 'showMsg'
  And match response.botEvents.AMBIGUOUS_INTENTS.msg[0].channel == 'default'
  And match response.botEvents.AMBIGUOUS_INTENTS.msg[0].text == 'amibiguous event triggered'
  And match response.botEvents.AMBIGUOUS_INTENTS.msg[0].type == 'basic'
  And match response.botEvents.AMBIGUOUS_INTENTS.msg[0].streamId == streamId