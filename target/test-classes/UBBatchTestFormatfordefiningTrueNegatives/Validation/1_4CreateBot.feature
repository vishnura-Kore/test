@kore
Feature: Creating a bot and linking Child Bot 

Background: 
    * url appUrl
    * def userId = ids.userId
    * def accessToken = ids.accessToken
    * def JavaClass = Java.type('data.HashMap')
    
    
    Scenario: creating a Universalbot
    * def JavaClass = Java.type('data.commonJava')
    * def name = JavaClass.generateRandom('number')
    * print name 
    * def Payload = read('CreateBot.json')
    * set Payload.name = "UniversalBot"+name
    * print  Payload
    Given path 'users/'+userId+'/builder/streams' 
    And request Payload
    And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.name == Payload.name
    * def SanityBotStreamId = response._id
    * print 'SanityBot streamID is:',SanityBotStreamId
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('SanityBotStreamId', SanityBotStreamId)
    * JavaClass.add('userId', userId)
   
    Scenario: create appscope
    
    * def JavaClass = Java.type('data.HashMap')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
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
        "SanityBotStreamId"
    ]
}
    """
    * set Payload.bots[0] = SanityBotStreamId
    * print Payload
    Given path '/users/'+userId+'/streams/'+SanityBotStreamId+'/sdk/apps'
    And request Payload
    And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def App1Stream1ClientId1 = response.clientId
    * print 'appList account id is:',App1Stream1ClientId1
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('App1Stream1ClientId1', App1Stream1ClientId1)
    * print App1Stream1ClientId1
    
    
    Scenario: Linking childbot to UB Bot
      * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    * def Payload = 
    """
    {
    "invocationNames": [
        "PublicConsumerbot1047"
    ],
    "botId": "st-15810e6e-305c-54c2-8da9-d6c67f1a70d1",
    "linkedBotDetails": {
        "_id": "st-15810e6e-305c-54c2-8da9-d6c67f1a70d1",
        "displayName": "PublicConsumerbot1047"
    }
}
    """
   
     Given path '/builder/streams/'+SanityBotStreamId+'/triggerPhrase'
    And request Payload
    And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
 
    
   
    
    
    
    
    