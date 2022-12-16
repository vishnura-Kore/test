@kore
Feature:createbot

Background: 
    * url appUrl
    * def userId = ids.userId
    * def accessToken = ids.accessToken
    * def JavaClass = Java.type('data.HashMap')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
     * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
      * def adminaccountID1 = JavaClass.get('adminaccountID1')
     
      
     Scenario: Getting StreamID 
    Then path '/users/'+botadminUserID1+'/builder/streams'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    * def name = 'PublicConsumerbot1047'
    * def childBotStreamID = response.find(x => x.name == name)._id
    * print childBotStreamID
    * JavaClass.add('childBotStreamID', childBotStreamID)
    
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
      And header AccountId = adminaccountID1
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
      * def childBotStreamID = JavaClass.get('childBotStreamID')
    * def Payload = 
    """
    {
    "invocationNames": [
        "PublicConsumerbot1047"
    ],
    "botId": "st-9e8fa189-cb13-540f-89d0-8ba6bf395947",
    "linkedBotDetails": {
        "_id": "st-9e8fa189-cb13-540f-89d0-8ba6bf395947",
        "displayName": "PublicConsumerbot1047"
    }
}
    """
   * set Payload.botId = childBotStreamID
   * set Payload.linkedBotDetails._id = childBotStreamID
     Given path '/builder/streams/'+SanityBotStreamId+'/triggerPhrase'
    And request Payload
    And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
    Scenario: Changing the version to 1.0
    * def userId = JavaClass.get('userId')
   * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
   * print SanityBotStreamId
   Given path '/users/'+userId+'/builder/streams/'+SanityBotStreamId+'/updateUniversalBotVersion'
    And request 
"""
{
    "universalBotVersion": 1
}
"""
    And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'put'
    When method post
    Then status 400
    And print 'Response is: ', response
    And match $.errors..msg == ["The file contains the definition of the Universal Bots built using an older version. This version is no longer supported and the file cannot be imported."]
    
    
    
   
    
    
    
    
    