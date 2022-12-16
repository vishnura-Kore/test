@runtime
Feature: Export Bot Scenarios 

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
    * def name = 'BotForImportExportScenarios'
    * def SanityBotStreamID = response.find(x => x.name == name)._id
    * print SanityBotStreamID
    * JavaClass.add('SanityBotStreamID', SanityBotStreamID)

  Scenario: Positive Scenario ----> Full  Bot Export in latest Version
    * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    Given url publicUrl
    Given path '/public/bot/'+SanityBotStreamID+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType" : "latest"
      }

      """
    When method post
    Then status 200
    And print 'Response is: ', response
    * def ExportrequestId = response._id
    * JavaClass.add('ExportrequestId',ExportrequestId)
    And match response.status == "pending"
    And match response.streamId == SanityBotStreamID
    And match response.exportType == "latest"

  Scenario: Positive Scenario ---->  Full Bot Export Status in latest Version
    * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    Given url publicUrl
    * def ExportrequestId = JavaClass.get('ExportrequestId')
    Given path '/public/bot/'+SanityBotStreamID+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print 'Response is: ', response
    * string DownloadUrl = response.downloadURL
    * JavaClass.add('DownloadUrl', DownloadUrl)
    * print DownloadUrl
    And match response.status == "success"
    And match response.streamId == SanityBotStreamID
    And match response.exportType == "latest"
    * def downloadurl = JavaMethods.downloadUsingStream(DownloadUrl,"BotForImportExportScenarios.zip")
    * def Unzip = JavaMethods.unzip("BotForImportExportScenarios.zip","Downloads")
    * def BodyOfRequest = read("..\\..\\..\\Downloads\\botDefinition.json")
    * def BodyOfConfig = read("..\\..\\..\\Downloads\\config.json")
    * print BodyOfRequest
    # Assertions
    And match BodyOfRequest.dialogs == '#[41]'
    And match BodyOfRequest.supportedLanguages == '#[4]'
    And match BodyOfRequest.knowledgeTasks[0].faqs.faqs == '#[58]'
    And match BodyOfRequest.knowledgeTasks[0].faqs.nodes == '#[83]'
    And match BodyOfRequest.knowledgeTasks[0].language == 'en'
    And match BodyOfRequest.alerts == '#[1]'
    And match BodyOfRequest.idpConfigurations == '#[1]'
    And match BodyOfRequest.smallTalk[0].groups == '#[2]'
    And match BodyOfRequest.smallTalk[0].groups[0].groupName == 'greetings'
    And match BodyOfRequest.smallTalk[0].groups[0].nodes == '#[10]'
    And match BodyOfRequest.smallTalk[0].groups[0].count == 9
    And match BodyOfRequest.smallTalk[0].groups[1].groupName == 'custom_smalltalk'
    And match BodyOfRequest.smallTalk[0].groups[1].nodes == '#[1]'
    And match BodyOfRequest.forms == '#[7]'
    And match BodyOfRequest.widgets == '#[1]'
    And match BodyOfRequest.panels == '#[1]'
    And match BodyOfRequest.panels[0].widgets == '#[1]'
    And match BodyOfRequest.widgets[0].name == 'Test Widget'
    And match BodyOfRequest.panels[0].name == 'Test Panel'
    And match BodyOfRequest.pii_patterns == '#[4]'
    And match BodyOfRequest.pii_patterns[0].pii_type == 'Email'
    And match BodyOfRequest.pii_patterns[0].enabled == true
    And match BodyOfRequest.pii_patterns[1].pii_type == 'Phone'
    And match BodyOfRequest.pii_patterns[1].enabled == true
    And match BodyOfRequest.pii_patterns[2].pii_type == 'SSN'
    And match BodyOfRequest.pii_patterns[2].enabled == false
    And match BodyOfRequest.pii_patterns[3].pii_type == 'Credit Card Number'
    And match BodyOfRequest.pii_patterns[3].enabled == false
    And match BodyOfRequest.contentVariables == '#[795]'
    And match BodyOfRequest.namespaces == '#[267]'
    And match BodyOfRequest.traits == '#[94]'
    And match BodyOfRequest.languageConfigurations.en.enabled == true
    And match BodyOfRequest.languageConfigurations.ko.enabled == true
    And match BodyOfRequest.languageConfigurations.de.enabled == true
    And match BodyOfRequest.languageConfigurations.ja.enabled == true
    And match BodyOfRequest.translationEngines[0].name == 'Google'
    And match BodyOfRequest.translationEngines[0].apiKey == 'AIzaSyBnk4hBmHuLjeIzScNAxAdhy0REpeW4xa0'
    And match BodyOfRequest.advancedNLSettings == '#[14]'
    And match BodyOfRequest.botEvents.CONVERSATION_END.enabled == true
    And match BodyOfRequest.botEvents.WELCOME_MESSAGE_EVENT.enabled == true
    And match BodyOfRequest.botEvents.ON_CONNECT_EVENT.enabled == true
    And match BodyOfRequest.botEvents.TASK_FAILURE_EVENT.enabled == true
    And match BodyOfRequest.botEvents.INTENT_UNIDENTIFIED.enabled == true
    And match BodyOfRequest.botEvents.FB_WELCOME_EVENT.enabled == true
    And match BodyOfRequest.botEvents.TELEPHONY_WELCOME_EVENT.enabled == true
    And match BodyOfRequest.botEvents.TELEGRAM_WELCOME_EVENT.enabled == true
    And match BodyOfRequest.botEvents.RCS_OPTIN_EVENT.enabled == true
    And match BodyOfRequest.botEvents.RCS_OPTOUT_EVENT.enabled == true
    And match BodyOfConfig.envVariables == '#[349]'
    And match BodyOfRequest.koraResponses == '#[33]'
    And match BodyOfRequest.botSentimentEvents == '#[1]'
    And match BodyOfRequest.botSentimentEvents[0].name == 'Anger'
    And match BodyOfRequest.botSentimentEvents[0].setting == 'onTaskCompletion'
    And match BodyOfRequest.botSentimentEvents[0].emotionConfig.messageTone.angry.min == 1
    And match BodyOfRequest.botSentimentEvents[0].emotionConfig.messageTone.angry.max == 3
    And match BodyOfRequest.advancedNLSettings == '#[14]'
    And match BodyOfRequest.advancedNLSettings[1].configurationKeyName == 'batch_size'
    And match BodyOfRequest.advancedNLSettings[1].configurationValue == 131
    And match BodyOfRequest.advancedNLSettings[5].configurationKeyName == 'epochs'
    And match BodyOfRequest.advancedNLSettings[5].configurationValue == 173
    And match BodyOfRequest.advancedNLSettings[7].configurationKeyName == 'cosineSimilarityDampening'
    And match BodyOfRequest.advancedNLSettings[9].configurationKeyName == 'eliminationRules'
    And match BodyOfRequest.advancedNLSettings[9].configurationValue == true
    And match BodyOfRequest.advancedNLSettings[3].configurationKeyName == 'ML_KAENNEW'
    And match BodyOfRequest.advancedNLSettings[3].configurationValue == '0.3'
    And match BodyOfRequest.advancedNLSettings[4].configurationKeyName == 'dropout'
    #And match BodyOfRequest.advancedNLSettings[4].configurationValue == '0.1'
    And match BodyOfRequest.advancedNLSettings[6].configurationKeyName == 'ML_spell_correction'
    And match BodyOfRequest.advancedNLSettings[6].configurationValue == 'enabled'
    And match BodyOfRequest.advancedNLSettings[11].configurationKeyName == 'ML_TRAIN_NER_WITH_TAGGED_UTTERANCES'
    And match BodyOfRequest.advancedNLSettings[11].configurationValue == true
    And match BodyOfRequest.advancedNLSettings[0].configurationKeyName == 'TestPlaceHolders'
    And match BodyOfRequest.advancedNLSettings[0].configurationValue == true
     And match BodyOfRequest.localeData.en.nlMeta.mlUtterances == 2284
     And match BodyOfRequest.localeData.en.nlMeta.patterns == 55
      And match BodyOfRequest.localeData.en.nlMeta.synonyms == 1679
       And match $..en.nlMeta.synonyms contains 1679
  And match $..en.nlMeta.patterns == [55]
  And match $..en.nlMeta.mlUtterances == [2284]

 
    
