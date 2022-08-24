@kore2
Feature: SendEnail DialogTask

Background: 
    * url appUrl
    * def userId = ids.userId
    * def accessToken = ids.accessToken
    
    
  Scenario:sendemail
  
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
    
    
    Scenario: AddEntityComponent
    
    * def JavaClass = Java.type('data.HashMap')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    * def SendEmailDialogID1 = JavaClass.get('SendEmailDialogID1')
    * def SendEmailEntityRefID1 = JavaClass.get('SendEmailEntityRefID1')
    * def SendEmailRefId1 = JavaClass.get('SendEmailRefId1')
    * def SendEmailIntentName1 = JavaClass.get('SendEmailIntentName1')
    * print SendEmailEntityRefID1
    * print SendEmailRefId1
    * print SendEmailDialogID1
    * def Payload = 
    """
     {
    "streamId": "SanityBotStreamId",
    "name": "SendEmailIntentName1",
    "nodes": [
        {
            "nodeOptions": {
                "customTags": {
                    "session": [],
                    "message": [],
                    "user": []
                },
                "transitionType": "auto",
                "promptOptions": "required",
                "reuseMarkedupPhrases": false,
                "interruptOptions": {
                    "priority": "task"
                },
                "transitionMode": "initiateCurrentTask",
                "inputHandlingOptions": "useAsEntityValue",
                "reuseOptions": "1",
                "userInputCorrection": true,
                "notForReuse": false,
                "contextTags": []
            },
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
                "left": 30,
                "top": 170
            }
        },
        {
            "nodeId": "entity1",
            "type": "entity",
            "componentId": "SendEmailEntityRefID1",
            "transitions": [
                {
                    "default": "",
                    "metadata": {
                        "color": "#299d8e",
                        "connId": "dummy1"
                    }
                }
            ],
            "nodeOptions": {
                "transitionType": "auto",
                "isOptional": false,
                "promptOptions": "required",
                "interruptOptions": {
                    "interruptsEnabled": true,
                    "priority": "task"
                }
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
     * set Payload.streamId = SanityBotStreamId
     * set Payload.name = SendEmailIntentName1
     * set Payload.nodes[0].componentId = SendEmailRefId1
     * set Payload.nodes[1].componentId = SendEmailEntityRefID1
     * print Payload
     When path 'builder/streams/'+SanityBotStreamId+'/dialogs/'+SendEmailDialogID1
     When request Payload
     And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
     
     
     Scenario: AddEntityComponent1
    * def JavaClass = Java.type('data.HashMap')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    * def SendEmailDialogID1 = JavaClass.get('SendEmailDialogID1')
    * def SendEmailEntityRefID1 = JavaClass.get('SendEmailEntityRefID1')
    * def SendEmailRefId1 = JavaClass.get('SendEmailRefId1')
    * def SendEmailIntentName1 = JavaClass.get('SendEmailIntentName1')
    * print SendEmailEntityRefID1
    * print SendEmailRefId1
    * print SendEmailDialogID1
    * def Payload =
    """
    {
    "streamId": "SanityBotStreamId",
    "name": "{{SendEmailIntentName1}}",
    "nodes": [
        {
            "nodeOptions": {
                "customTags": {
                    "session": [],
                    "message": [],
                    "user": []
                },
                "transitionType": "auto",
                "promptOptions": "required",
                "reuseMarkedupPhrases": false,
                "interruptOptions": {
                    "priority": "task"
                },
                "transitionMode": "initiateCurrentTask",
                "inputHandlingOptions": "useAsEntityValue",
                "reuseOptions": "1",
                "userInputCorrection": true,
                "notForReuse": false,
                "contextTags": [],
                "isOptional": false
            },
            "nodeId": "intent0",
            "type": "intent",
            "componentId": "SendEmailRefId1",
            "transitions": [
                {
                    "default": "entity1",
                    "metadata": {
                        "color": "#299d8e",
                        "connId": "dummy0"
                    }
                }
            ],
            "metadata": {
                "left": 30,
                "top": 170
            }
        },
        {
            "nodeOptions": {
                "customTags": {
                    "session": [],
                    "message": [],
                    "user": []
                },
                "transitionType": "auto",
                "promptOptions": "required",
                "reuseMarkedupPhrases": false,
                "interruptOptions": {
                    "interruptsEnabled": true,
                    "priority": "task"
                },
                "transitionMode": "initiateCurrentTask",
                "inputHandlingOptions": "useAsEntityValue",
                "reuseOptions": "1",
                "userInputCorrection": true,
                "notForReuse": false,
                "contextTags": [],
                "precedence": "entityOverIntent"
            },
            "nodeId": "entity1",
            "type": "entity",
            "componentId": "SendEmailEntityRefID1",
            "transitions": [
                {
                    "default": "",
                    "metadata": {
                        "color": "#299d8e",
                        "connId": "dummy1"
                    }
                }
            ]
        }
    ],
    "visibility": {
        "namespace": "private",
        "namespaceIds": [
            "{{SanityUserID1}}"
        ]
    }
}
    """
     * set Payload.streamId = SanityBotStreamId
     * set Payload.nodes[0].componentId =SendEmailRefId1 
     * set Payload.nodes[1].componentId=SendEmailEntityRefID1
     * print Payload
     Given path '/builder/streams/'+SanityBotStreamId+'/dialogs/'+SendEmailDialogID1
     When request Payload
     And header Authorization = 'bearer '+accessToken
     And header Content-Type = 'application/json'
     When method post
     Then status 200
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    