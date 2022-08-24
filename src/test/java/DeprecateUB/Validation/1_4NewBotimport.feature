@runtime
Feature: BotImport As a NewBot 

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def EERSJWT1 = JavaClass.get('JWTToken1')

  Scenario: BotDefinition File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = JWTToken
    And multipart file file = { read: 'botDefinition.json', filename: 'botDefinition.json', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'json'
    When method post
    Then status 200
    * def ConusmerBotDefinitionFileID = response.fileId
    * JavaClass.add('ConusmerBotDefinitionFileID', ConusmerBotDefinitionFileID)
    * print ConusmerBotDefinitionFileID

  Scenario: BotConfig File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = JWTToken
    And multipart file file = { read: 'config.json', filename: 'config.json', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'json'
    When method post
    Then status 200
    * def ConusmerBotConfigFileID = response.fileId
    * JavaClass.add('ConusmerBotConfigFileID', ConusmerBotConfigFileID )
    * print ConusmerBotConfigFileID
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * print ConusmerBotDefinitionFileID
    * print ConusmerBotConfigFileID


  Scenario: Positive Scenario ----> Bot import with all valid fields
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * print ConusmerBotDefinitionFileID
    * print ConusmerBotConfigFileID
    * def Payload = read('botimportpayload.json')
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * set Payload.name = 'PublicConsumerbot'+name
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    * print JWTToken
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 400
    And print 'Response is ', response
    And match $.errors..msg == ["The file contains the definition of the Universal Bots built using an older version. This version is no longer supported and the file cannot be imported."]
  

    
