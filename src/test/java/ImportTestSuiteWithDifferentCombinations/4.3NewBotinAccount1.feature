@runtime
Feature:createbot

Background: 
    * url appUrl
    * def userId = ids.userId
    * def accessToken = ids.accessToken
    Scenario:creating a bot
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
    * def SanityStreamId1 = response._id
    * print 'SanityBot streamID is:',SanityStreamId1
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('SanityStreamId1', SanityStreamId1)
    * JavaClass.add('userId', userId)
   
    Scenario: create appscope
    
    * def JavaClass = Java.type('data.HashMap')
    * def SanityStreamId1 = JavaClass.get('SanityStreamId1')
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
        "SanityStreamId1"
    ]
}
    """
    * set Payload.bots[0] = SanityStreamId1
    * print Payload
    Given path '/users/'+userId+'/streams/'+SanityStreamId1+'/sdk/apps'
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
    
    
    
    
   
    
    
  Scenario:sendemail
  
    * def JavaClass = Java.type('data.HashMap')
    * def SanityStreamId1 = JavaClass.get('SanityStreamId1')
    * print SanityStreamId1
    
    Given path 'users/'+userId+'/builder/streams/'+SanityStreamId1
    And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    
    Scenario: Create Component - Intent_SendEmail
    
    * def JavaClass = Java.type('data.HashMap')
    * def SanityStreamId1 = JavaClass.get('SanityStreamId1')
    * print SanityStreamId1
    
    Given path 'builder/streams/'+SanityStreamId1+'/components'
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
    * def SanityStreamId1 = JavaClass.get('SanityStreamId1')
    * def SendEmailIntentName1 = JavaClass.get('SendEmailIntentName1')
    * def SendEmailRefId1 = JavaClass.get('SendEmailRefId1')
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
    
     Given path 'builder/streams/'+SanityStreamId1+'/dialogs'
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
    * def SanityStreamId1 = JavaClass.get('SanityStreamId1')
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
    When path 'builder/streams/'+SanityStreamId1+'/components/'+SendEmailRefId1
    When request Payload
   
     And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method put
    Then status 200
    
    Scenario: EnitityCreation_Email
    * def JavaClass = Java.type('data.HashMap')
    * def SanityStreamId1 = JavaClass.get('SanityStreamId1')
     When path 'builder/streams/'+SanityStreamId1+'/components'
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
    
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        