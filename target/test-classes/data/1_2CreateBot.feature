@kore
Feature:createbot

Background: 
    * url appUrl
    * def userId = ids.userId
    * def accessToken = ids.accessToken
    Scenario:creating a bot
    * def JavaClass = Java.type('data.commonJava')
    * def name = JavaClass.generateRandom('string')
    * def today = getDate()
    * print today
    * print name 
    * def Payload = read('CreateBot.json')
    * set Payload.name = name
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    