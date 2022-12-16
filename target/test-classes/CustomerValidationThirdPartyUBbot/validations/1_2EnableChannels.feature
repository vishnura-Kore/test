@runtime
Feature: Enabling Webhook channel and creating app

  Background: 
    * url appUrl
    * url publicUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    
    Scenario: Getting StreamID 
    Then path '/users/'+botadminUserID1+'/builder/streams'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    * def name = 'CustomerBotThirdPartyLink'
    * def SanityBotStreamID = response.find(x => x.name == name)._id
    * print SanityBotStreamID
    * JavaClass.add('SanityBotStreamID', SanityBotStreamID)
    

  Scenario: create appscope
    * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload = read("createAppScope.json")
    * set Payload.appName = 'Test'+name
    * set Payload.bots[0] = SanityBotStreamID
    * print Payload
    Given path '/users/'+botadminUserID1+'/streams/'+SanityBotStreamID+'/sdk/apps'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def smartclientId1 = response.clientId
    * def appname = response.appName
    * def smartclientsecret1 = response.clientSecret
    * print 'appList account id is:',smartclientId1
    * JavaClass.add('smartclientId1', smartclientId1)
    * JavaClass.add('appname', appname)
    * JavaClass.add('smartclientsecret1', smartclientsecret1)
    * print smartclientId1
    * print smartclientsecret1
    
    
    Scenario: Delete channel in bot
    
     * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    Given path '/users/'+botadminUserID1+'/builder/streams/'+SanityBotStreamID+'/channel/ivr'
    And request 
    """
    {}
    """
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'delete'
    When method post
    Then status 200
    And print 'Response is: ', response
 
    
    

  Scenario: Positive Scenario ----> Enabling Webhook channel
    * def appname = JavaClass.get('appname')
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    * print smartclientId1
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload = read("EnableWebhookChannel.json")
    * set Payload.streamId = SanityBotStreamID
    * set Payload.channelDetails.app.appName = appname
    * set Payload.channelDetails.app.clientId = smartclientId1
    * set Payload.channelDetails.displayName = 'webhook1'+name
    * print Payload
    Given url publicUrl
    Given path 'public/channels'
    And request  Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200

  Scenario: Publish
    * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    Given url publicUrl
    Then path '/public/bot/'+SanityBotStreamID+'/publish'
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
