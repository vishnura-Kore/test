@runtime
Feature: Enable channel and creating app

  Background: 
    * url appUrl
    * url publicUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JWTToken1 = JavaClass.get('JWTToken1')
    * def JavaMethods = Java.type('data.commonJava')
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def Botname = JavaClass.get('Botname')

  Scenario: create appscope
    * def PstreamId = JavaClass.get('PstreamId')
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload = read("JsonUploadFiles/createAppScope.json")
    * set Payload.appName = 'Test'+name
    * set Payload.bots[0] = PstreamId
    * print Payload
    Given path '/users/'+botadminUserID1+'/streams/'+PstreamId+'/sdk/apps'
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
    
     * def PstreamId = JavaClass.get('PstreamId')
    Given path '/users/'+botadminUserID1+'/builder/streams/'+PstreamId+'/channel/ivr'
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
    * def PstreamId = JavaClass.get('PstreamId')
    * print PstreamId
    * print smartclientId1
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload = read("JsonUploadFiles/EnableWebhookChannel.json")
    * set Payload.streamId = PstreamId
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

  Scenario: Positive Scenario ----> Enabling Web/Mobile channel
    * def appname = JavaClass.get('appname')
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def PstreamId = JavaClass.get('PstreamId')
    * print PstreamId
    * print smartclientId1
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload = read("JsonUploadFiles/EnableWebOrMobileChannel.json")
    * set Payload.streamId = PstreamId
    * set Payload.channelDetails.app.appName = appname
    * set Payload.channelDetails.app.clientId = smartclientId1
    * set Payload.channelDetails.displayName = 'Web/Mobile'+name
    * print Payload
    Given url publicUrl
    Given path 'public/channels'
    And request  Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200

  Scenario: Positive Scenario ----> Enabling MS TEAM channel
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def PstreamId = JavaClass.get('PstreamId')
    * def Botname = JavaClass.get('Botname')
    * print PstreamId
    * print smartclientId1
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload = read("JsonUploadFiles/EnableMSChannel.json")
    * set Payload.streamId = PstreamId
    * set Payload.channelDetails.botName =  Botname
    * print Payload
    Given url publicUrl
    Given path 'public/channels'
    And request  Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200

  Scenario: Positive Scenario ----> Enabling Slack channel
    * def appname = JavaClass.get('appname')
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def Botname = JavaClass.get('Botname')
    * def smartclientsecret1 = JavaClass.get('smartclientsecret1')
    * def PstreamId = JavaClass.get('PstreamId')
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload = read("JsonUploadFiles/EnableSlackChannel.json")
    * set Payload.streamId = PstreamId
    * set Payload.channelDetails.botName = Botname
    * set Payload.channelDetails.clientId = smartclientId1
    * set Payload.channelDetails.clientSecret = smartclientsecret1
    * set Payload.channelDetails.accessToken = botadminaccesstokenuser1
    * set Payload.channelDetails.verificationToken = 'a'+name
    * print Payload
    Given url publicUrl
    Given path 'public/channels'
    And request  Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200

  Scenario: Negative Scenario ----> Enabling Webhook channel with no JWT Token
    * def name = JavaMethods.generateRandom('number')
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def PstreamId = JavaClass.get('PstreamId')
    * print PstreamId
    * print smartclientId1
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload = read("JsonUploadFiles/EnableWebhookChannelWithNoJWT.json")
    * set Payload.app.appName = 'apppublic'+name
    * set Payload.app.clientId = smartclientId1
    * set Payload.displayName = 'WebSDKName'+name
    * print Payload
    Given url publicUrl
    Given path 'public/channels'
    And request  Payload
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Enabling Webhook channel using Invalid JWTToken
    * def name = JavaMethods.generateRandom('number')
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def PstreamId = JavaClass.get('PstreamId')
    * print PstreamId
    * print smartclientId1
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload = read("JsonUploadFiles/EnableChannelwithInvalidJWTToken.json")
    * set Payload.app.appName = 'apppublic'+name
    * set Payload.app.clientId = smartclientId1
    * set Payload.displayName = 'WebSDKName'+name
    * print Payload
    Given url publicUrl
    Given path 'public/channels'
    And request  Payload
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Enabling Webhook channel using Incorrect JWT Token
    * def name = JavaMethods.generateRandom('number')
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def PstreamId = JavaClass.get('PstreamId')
    * print PstreamId
    * print smartclientId1
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload = read("JsonUploadFiles/EnableChannelIncorrectJWTToken.json")
    * set Payload.app.appName = 'apppublic'+name
    * set Payload.app.clientId = smartclientId1
    * set Payload.displayName = 'WebSDKName'+name
    * print Payload
    Given url publicUrl
    Given path 'public/channels'
    And request  Payload
    And header auth = JWTToken1
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And match $.errors..msg == ["Permission denied. Scope is incorrect!"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Enabling Webhook channel using Incorrect Body
    * def name = JavaMethods.generateRandom('number')
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def PstreamId = JavaClass.get('PstreamId')
    * print PstreamId
    * print smartclientId1
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload = read("JsonUploadFiles/EnableChannelWithIncorrectBody.json")
    * set Payload.app.appName = 'apppublic'+name
    * set Payload.displayName = 'WebSDKName'+name
    * print Payload
    Given url publicUrl
    Given path 'public/channels'
    And request  Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 412
    And match $.errors..msg == ["Missing app details in the payload"]
    And match $.errors..code == ["ValidationError"]

  #Scenario: Publish
    #* def PstreamId = JavaClass.get('PstreamId')
    #Given url publicUrl
    #Then path '/public/bot/'+PstreamId+'/publish'
    #And request
      #"""
      #{
      #"versionComment": "new update"
      #}
      #"""
    #And header auth = JWTToken
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
