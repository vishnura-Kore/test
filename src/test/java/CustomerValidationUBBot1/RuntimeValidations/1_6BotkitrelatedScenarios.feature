
@runtime
Feature: Interacting with the bot using webhook channel

  Background: 
    * url runtimeUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    

  Scenario: input discard
    * def Payload =
      """
        {
        "message": {
            "text": "hi"
        },
        "from": {
            "id": "Kore123"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanityBotStreamID
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
 #
#
 #Scenario: input discard
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "discard all"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #
    #
#
#Scenario: This test is to verify the functionality of Session closure from botkit
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "SessionClosureBotKit"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
   #
   #
   #
   #Scenario: input discard
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "discard all"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
      #
  #Scenario: This test is to verify the functionaltiy of on_user_message event in botkit
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "TriggerOnUserMessage"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == "On User Message Triggered Successfully"
   #
   #
   #
    #Scenario: This test is to verify the functionaltiy of on_bot_message event in botkit
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "TriggerOnBotMessage"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == ["On Bot Message Triggered Successfully"]
    #
    #
    #
    #
    #Scenario: This test is to verify the functionaltiy of on_event event in botkit
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "TriggerOnEvent"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == ["On Event Dialog Executed"]
    #
    #
    #
    #
     #Scenario: This test is to verify the functionaltiy of on_agent_transfer event in botkit
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "AgentTransferEventforBotkit"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == ["AgentTransfer Dialog triggered","Agent Transfer event triggered successfully"]
     #To stop the flow
    #
      #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "ClearAgentSession"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == "Agent Session Cleared"
    #
    #
    #
    #Scenario: input discard
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "hi"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #
    #
    #
    #
    #
      #Scenario: This test is to verify the functionality of on_webhook event in botkit
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "TriggerOnWebhook"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == "On Webhook Event Triggered Successfully"
    #
    #
    #
    #
      #Scenario: This test is to verify the functionality of Start Agent Session from Botkit
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "StartAgentSession"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == "Started Agent Session"
    #
     # Scenario: input hi
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "Hi"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == "Agent Message"
    #
    #
    #
 #
    #
    #
       #Scenario: This test is to verify the functionality of Clearing Agent Session from Botkit
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "ClearAgentSession"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == "Agent Session Cleared"
    #
      #Scenario: input hi
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "Hi"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #
    #
    #
    #
    #
       #Scenario: This test is to verify the functionality of Skipping User Message functionality from Botkit
    #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "TriggerSkipUserMessage"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == ["Skip User Message validation message1","Skip User Message validation message3"]
    #
    #
    #
  #
    #
    #
    #Scenario: This test is to verify the functionality of Skipping Bot Message functionality from Botkit
    #
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "TriggerSkipBotMessage"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #
    #
    #
     #
    #Scenario: This test is to verify NL Meta functionality from Botkit
    #
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "Send NL Meta"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == ["This dialog triggered from NL Meta"]
    #
    #
    #
    #Scenario: This test is to verify channel specific response override functionality when customer validation bot specific botkit is Enabled
    #
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "TriggerChannelSpecificResponse"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == ["This is Webhook channel response"]
    #
    #
    #
      #Scenario: This test is to verify context variable creation from botkit and accessing it in the bot dialog task
    #
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "SetContextVariablesFromBotkit"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == ["Context variable value set for the key *botkitBotUserSessionVariable1* is *botkitBotUserSessionValue1*"]
    #
    #
     #Scenario: This test is to verify language override functionality from botkit (SwitchLanguageSpanish)
    #
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "SwitchLanguageSpanish"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == ["Hola bienvenido"]
    #
    #
    #Scenario: This test is to verify language override functionality from botkit (SwitchLanguageEnglish)
    #
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "SwitchLanguageEnglish"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
     #And match $.text == ["Hi... Welcome"]
    #
    #
     #
    #Scenario: This test is to verify message payload override from botkit
    #
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "OverrideMessagePayloadWithButtonTemplateFromBotkit"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $..text == ["{\"type\":\"template\",\"payload\":{\"template_type\":\"button\",\"text\":\"This is an example to demonstrate message templates sent from bot kit\",\"buttons\":[{\"type\":\"postback\",\"title\":\"Yes\",\"payload\":\"Yes\"},{\"type\":\"postback\",\"title\":\"No\",\"payload\":\"No\"}]}}"]
    #
    #
     #Scenario: This test is to verify webhook node sync functionality 
    #
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "WebhookNodeValidation"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #
    #input WebhookSync
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "WebhookSync"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == ["This message from sync webhook"]
    #
    #
    #
     #Scenario: This test is to verify webhook node async and botkit sdk.AsyncResponse functionality 
    #
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "WebhookNodeValidation"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #
    #input WebhookAsync
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "WebhookAsync"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == ["This message from async webhook"]
    #
    #
    #Scenario: This test is to verify meta tags addition functionality from Botkit
    #
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "MetaTagsFromBotkit"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == ["Setting Meta Tags from BotKit","This task failure event message rendered from environment variables"]
    #
    #
    #
     #Scenario: This test is to verify meta tags addition functionality from Bot
    #
     #* def Payload =
      #"""
        #{
        #"message": {
            #"text": "MetaTagsFromBot"
        #},
        #"from": {
            #"id": "Kore123"
        #},
        #"to": {
            #"id": "4321"
        #}
        #}
      #"""
    #* def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    #* print ConsumerWebHookJWT
    #Given url runtimeUrl
    #Then path '/chatbot/hooks/'+SanityBotStreamID
    #And request Payload
    #And header Authorization = 'bearer '+ConsumerWebHookJWT
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response
    #And match $.text == ["Setting Meta Tags from Bot","This task failure event message rendered from environment variables"]