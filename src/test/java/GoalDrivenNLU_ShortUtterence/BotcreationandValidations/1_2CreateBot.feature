@kore
Feature: Feature to creating a bot 

Background: 
    * url appUrl
    * def userId = ids.userId
    * def accessToken = ids.accessToken
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def name = JavaMethods.generateRandom('number')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    
    
    
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    
    
    Scenario: creating a bot
    * def JavaClass = Java.type('data.commonJava')
    * def name = JavaClass.generateRandom('number')
    * print name 
    * def Payload = read('CreateBot.json')
    * set Payload.name = 'SanityBot'+name
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
    
    
    
    
   
    
    Scenario: creating sendemail dialogtask
  
    * def JavaClass = Java.type('data.HashMap')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    * print SanityBotStreamId
    
    Given path 'users/'+userId+'/builder/streams/'+SanityBotStreamId
    And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    
    Scenario: Create Component - Intent_SendEmail
    
    * def JavaClass = Java.type('data.HashMap')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    * print SanityBotStreamId
    
    Given path 'builder/streams/'+SanityBotStreamId+'/components'
    When request {"desc": "Test Automation","type": "intent","intent": "SendEmail"}
     And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    * def SendEmailRefId1 = response._id
    * def SendEmailIntentName1 = response.name
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('SendEmailRefId1', SendEmailRefId1)
    * JavaClass.add('SendEmailIntentName1', SendEmailIntentName1)
    * print SendEmailIntentName1
    * print SendEmailRefId1
    
    Scenario: Add component to Dialog 
    
    * def JavaClass = Java.type('data.HashMap')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    * def SendEmailIntentName1 = JavaClass.get('SendEmailIntentName1')
    * def SendEmailRefId1 = JavaClass.get('SendEmailRefId1')
    * print SanityBotStreamId
    * print SendEmailIntentName1
    * def Payload =
    """
     {
    "name": "SendEmailIntentName1",
    "shortDesc": "Sending Email",
    "nodes": [
        {
            "nodeId": "intent0",
            "type": "intent",
            "componentId": "SendEmailRefId1",
            "transitions": [
                {
                    "default": "",
                    "metadata": {
                        "color": "#299d8e",
                        "connId": "dummy0"
                    }
                }
            ],
            "metadata": {
                "left": 31,
                "top": 18
            }
        }
    ],
    "visibility": {
        "namespace": "private",
        "namespaceIds": [
            ""
        ]
    }
}
     """
     * set Payload.name = SendEmailIntentName1
     * set Payload.nodes[0].componentId = SendEmailRefId1
     * print Payload
    
     Given path 'builder/streams/'+SanityBotStreamId+'/dialogs'
     When request Payload
     And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    * def SendEmailDialogID1 = response._id
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('SendEmailDialogID1', SendEmailDialogID1)
    
    Scenario: Add Dialog to Bot
    
    * def JavaClass = Java.type('data.HashMap')
    * def SendEmailRefId1 = JavaClass.get('SendEmailRefId1')
    * def SendEmailIntentName1 = JavaClass.get('SendEmailIntentName1')
    * def SendEmailDialogID1 = JavaClass.get('SendEmailDialogID1')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    * print SendEmailIntentName1
    * print SendEmailDialogID1
    * def Payload = 
     """
    {
    "name": "email",
    "dialogId": "SendEmailDialogID1"
}
    """
    * set Payload.dialogId = SendEmailDialogID1
    * print Payload
    When path 'builder/streams/'+SanityBotStreamId+'/components/'+SendEmailRefId1
    When request Payload
   
     And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method put
    Then status 200
    
    Scenario: EnitityCreation_Email
    * def JavaClass = Java.type('data.HashMap')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
     When path 'builder/streams/'+SanityBotStreamId+'/components'
     When request  
     """
     {
    "name": "{{email}}",
    "type": "entity",
    "message": [
        {
            "channel": "default",
            "text": "Please provide your email address",
            "type": "basic"
        }
    ],
    "entityType": "email",
    "errorMessage": [
        {
            "text": "I'm sorry, I did not recognize the email you entered. Please enter the email again. An example of an email address is JohnDoe@abc.com.",
            "type": "basic",
            "channel": "default"
        }
    ]
}
   """
    And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    * def SendEmailEntityRefID1 = response._id
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('SendEmailEntityRefID1', SendEmailEntityRefID1)
    
    
    
    
    
     Scenario: create appscope
    * def Payload =
      """
      {
      "appName": "Test",
      "algorithm": "HS256",
      "scope": [
         "anonymouschat",
         "registration"
      ],
      "bots": [
         "PstreamId"
      ],
      "pushNotifications": {
         "enable": false,
         "webhookUrl": ""
      }
      }
      """
    * set Payload.appName = 'Test'+name
    * set Payload.bots[0] = SanityBotStreamId
    * print Payload
    Given path '/users/'+botadminUserID1+'/streams/'+SanityBotStreamId+'/sdk/apps'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def smartclientId1 = response.clientId
    * def smartclientsecret1 = response.clientSecret
    * print 'appList account id is:',smartclientId1
    * JavaClass.add('smartclientId1', smartclientId1)
    * JavaClass.add('smartclientsecret1', smartclientsecret1)
    * print smartclientId1
    * print smartclientsecret1

  Scenario: Enabling a channel 
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    * print smartclientId1
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload =
      """
      {
      "app": {
          "clientId": "smartclientId1",
          "appName": "apppublic"
      },
      "displayName": "webhook",
      "type": "ivr",
      "isAsync": false,
      "enable": true,
      "createInstance": true
      }
      """
    * set Payload.app.appName = 'apppublic'+name
    * set Payload.app.clientId = smartclientId1
    * set Payload.displayName = '	webhook'+name
    * print Payload
    Given path '/users/'+botadminUserID1+'/builder/streams/'+SanityBotStreamId+'/channels/ivr'
    And request  Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    