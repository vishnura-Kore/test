@R10.0
Feature: RunTime Scenarios

  Background: 
    * url jwturl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def streamId = JavaClass.get('streamId')
    * def JWTToken = JavaClass.get('JWTToken')
    * def completedTaskId = JavaClass.get('completedTaskId')
    * def dialogRefID = JavaClass.get('dialogRefID')

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
    And match response.text[0] == 'Book a Flight from Hyderabad to Delhi'
    And match response.completedTaskId == completedTaskId
    And match response.completedTaskName == 'book a flight from hyderabad to delhi'
    
    Scenario: Disable the Amibiguous event with Dialog Task
    * def JavaClass = Java.type('data.HashMap')
    * def accountID = JavaClass.get('accountID')
    * def userId = JavaClass.get('userId')
    * def accessToken = JavaClass.get('accessToken')
    * def dialogRefID = JavaClass.get('dialogRefID')
  
    Given url appUrl
    Then path 'users/'+userId+'/builder/streams/'+streamId+'/events'
    * def Payload = read('EventWithDialog.json')
    * set Payload.botEvent.AMBIGUOUS_INTENTS.task = dialogRefID
    * set Payload.botEvent.AMBIGUOUS_INTENTS.enabled = false
    * print Payload
    And request Payload
    And header Content-Type = 'application/json'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountID
    And header X-HTTP-Method-Override = 'put'
    When method post
    Then status 200
    And print response
    And match response.botEvents.AMBIGUOUS_INTENTS.enabled == false
    And match response.botEvents.AMBIGUOUS_INTENTS.action == 'triggerDialog'
    And match response.botEvents.AMBIGUOUS_INTENTS.task == dialogRefID
    And match response.botEvents.AMBIGUOUS_INTENTS.linkedBotStreamId == null
    And match response.botEvents.AMBIGUOUS_INTENTS.script == '.'
    
    
    
    
    
    
    
    
