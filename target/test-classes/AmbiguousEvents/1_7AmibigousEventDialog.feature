@R10.0
Feature: Enable the Amibigous Event with the show message

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def streamId = JavaClass.get('streamId')
    * def JWTToken = JavaClass.get('JWTToken')
    * def Botname = JavaClass.get('Botname')
  
  Scenario: Disable the Amibiguous event
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
  * set Payload.botEvent.AMBIGUOUS_INTENTS.enabled = false
  * print Payload
  And request Payload
  When method post
  Then status 200
  And print response
  And match response.botEvents.AMBIGUOUS_INTENTS.enabled == false
  And match response.botEvents.AMBIGUOUS_INTENTS.action == 'showMsg'
  And match response.botEvents.AMBIGUOUS_INTENTS.msg[0].channel == 'default'
  And match response.botEvents.AMBIGUOUS_INTENTS.msg[0].text == 'amibiguous event triggered'
  And match response.botEvents.AMBIGUOUS_INTENTS.msg[0].type == 'basic'
  And match response.botEvents.AMBIGUOUS_INTENTS.msg[0].streamId == streamId
   
  Scenario: Getting the Dialog Task ID
  Given path 'builder/streams/'+streamId+'/dialogs'
  * def JavaClass = Java.type('data.HashMap')
  * def accountID = JavaClass.get('accountID')
  * def userId = JavaClass.get('userId')
  * def orgID = JavaClass.get('orgID')
  * def accessToken = JavaClass.get('accessToken')
  * def completedTaskId = JavaClass.get('completedTaskId')
  * print completedTaskId
  
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountID
  When method get
  Then status 200
  And print response
  
  * def dialogname = 'Book a Flight from Hyderabad to Delhi'
	* def id = response.find(x => x.name == dialogname)._id
	* print id
  And match id == completedTaskId
    
  * def dialogRefID = response.find(x => x.name == dialogname).refId
  * print dialogRefID
  * JavaClass.add('dialogRefID', dialogRefID)
  
  Scenario: Enable the Amibiguous event with Dialog Task
  * def JavaClass = Java.type('data.HashMap')
  * def accountID = JavaClass.get('accountID')
  * def userId = JavaClass.get('userId')
  * def accessToken = JavaClass.get('accessToken')
  * def dialogRefID = JavaClass.get('dialogRefID')
  
  Given path 'users/'+userId+'/builder/streams/'+streamId+'/events'
  * def Payload = read('EventWithDialog.json')
  * set Payload.botEvent.AMBIGUOUS_INTENTS.task = dialogRefID
  * set Payload.botEvent.AMBIGUOUS_INTENTS.enabled = true
  * print Payload
  And request Payload
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountID
  And header X-HTTP-Method-Override = 'put'
  When method post
  Then status 200
  And print response
  And match response.botEvents.AMBIGUOUS_INTENTS.enabled == true
  And match response.botEvents.AMBIGUOUS_INTENTS.action == 'triggerDialog'
  And match response.botEvents.AMBIGUOUS_INTENTS.task == dialogRefID
  And match response.botEvents.AMBIGUOUS_INTENTS.linkedBotStreamId == null
  And match response.botEvents.AMBIGUOUS_INTENTS.script == '.'  