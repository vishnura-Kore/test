Feature: Import Bot

  Background: 
    * url appUrl
    * url publicUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')

  Scenario: BotDefinition File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = JWTToken
    And multipart file file = { read: '..\\..\\..\\Downloads\\botDefinition.json', filename: '..\\..\\..\\Downloads\\botDefinition.json', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'json'
    When method post
    Then status 200
    * def ConusmerBotDefinitionFileID = response.fileId
    * JavaClass.add('ConusmerBotDefinitionFileID', ConusmerBotDefinitionFileID)
    * print ConusmerBotDefinitionFileID

  Scenario: BotDefinition File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = JWTToken
    And multipart file file = { read: '..\\..\\..\\Downloads\\config.json', filename: '..\\..\\..\\Downloads\\config.json', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'json'
    When method post
    Then status 200
    * def ConusmerBotconfigFileID = response.fileId
    * JavaClass.add('ConusmerBotconfigFileID', ConusmerBotconfigFileID)
    * print ConusmerBotconfigFileID

  Scenario: BotbotFunctionFileID File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = JWTToken
    And multipart file file = { read: '..\\..\\..\\Downloads\\botFunction.js', filename: '..\\..\\..\\Downloads\\botFunction.js', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'json'
    When method post
    Then status 200
    * def ConusmerBotbotFunctionFileID = response.fileId
    * JavaClass.add('ConusmerBotbotFunctionFileID', ConusmerBotbotFunctionFileID)
    * print ConusmerBotbotFunctionFileID

  Scenario: Positive Scenario ----> Bot import with all valid fields
    * def name = JavaMethods.generateRandom('number')
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotconfigFileID = JavaClass.get('ConusmerBotconfigFileID')
    * def ConusmerBotbotFunctionFileID = JavaClass.get('ConusmerBotbotFunctionFileID')
    * def Payload = read('botimportpayload.json')
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.botFunctions[0] = ConusmerBotbotFunctionFileID
    * set Payload.configInfo = ConusmerBotconfigFileID
    * set Payload.name = 'ImportScenario'+name
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    * print JWTToken
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is ', response
    * def ConusmerBotIDBir = response._id
    * def Botname = response.statusLogs[0].taskName
    * JavaClass.add('ConusmerBotIDBir', ConusmerBotIDBir)
    * JavaClass.add('Botname', Botname)
    * print ConusmerBotIDBir
    * print Botname
    And match response.status == "pending"
    And match response.statusLogs[0].status == "success"
    And match response.requestType == "Botimport"

  Scenario: Positive Scenario ----> Bot import status with all valid details
    * def ConusmerBotIDBir = JavaClass.get('ConusmerBotIDBir')
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print response
    * def streamId = response.streamId
    * JavaClass.add('streamId', streamId)
    And match $..status contains ["success"]
    And match response._id == ConusmerBotIDBir

  Scenario: Getting summary details
    Given url appUrl
    * def streamId = JavaClass.get('streamId')
    Then path '/builder/streams/'+streamId+'/details'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    And match $..botSentimentEvents..name == ["Anger"]
    And match $..botSentimentEvents..emotionConfig.messageTone.angry.min == [1]
    And match $..botSentimentEvents..emotionConfig.messageTone.angry.max == [3]
    And match $..botSentimentEvents..emotionConfig.messageTone.angry.label == ['Anger-Message Level']
    And match $..nlMeta.synonyms == [1679]
    And match $..nlMeta.patterns == [55]
    And match $..nlMeta.mlUtterances == [2284]
    And match $.supportedLanguages == '#[4]'
    And match $.pii_patterns == '#[4]'
    And match $.botVariables.locale.count == [795]
    And match $.botVariables.env.count == [349]
    And match $.botFunction == '#[1]'
    And match $.taskCounts.faqCount == [58]
    And match $.idpConfigurations == '#[1]'
    And match $.idpConfigurations..sso_type == ["basic"]
    And match $.linkedBotUtterances == '#[25]'
  
    And match $.ivrSettings.enable == true
    And match $.enable_pii.enable == true
    And match $.enableNameSpace == true
      And match $.synonyms == '#[200]'
