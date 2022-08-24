@kore2
Feature:Enable channel

Background: 
    * url appUrl
    * def userId = ids.userId
    * def accessToken = ids.accessToken
  
    Scenario: Enabling channel
    
    * def JavaClass = Java.type('data.HashMap')
    * def App1Stream1ClientId1 = JavaClass.get('App1Stream1ClientId1')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    * print SanityBotStreamId
    * print  App1Stream1ClientId1
    * def JavaClass = Java.type('data.commonJava')
    * def name = JavaClass.generateRandom('number')
    * print name 
    * def Payload =
    """
 {
    "app": {
        "clientId": "App1Stream1ClientId1",
        "appName": "App1Stream1"
    },
    "displayName": "new",
    "type": "ivr",
    "isAsync": false,
    "enable": true,
 
}
   """
   * set Payload.app.appName = 'Auto'+name
   * set Payload.app.clientId = App1Stream1ClientId1 
   * print Payload
    Given path '/users/'+userId+'/builder/streams/'+SanityBotStreamId+'/channels/ivr'
    And request  Payload
    And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200