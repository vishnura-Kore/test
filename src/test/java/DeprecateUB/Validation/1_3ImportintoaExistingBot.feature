Feature: Import Bot into an Existing Bot with positive and negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    * def name = JavaMethods.generateRandom('number')
    * print SanityBotStreamId

  Scenario: BotDefinition File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = JWTToken
    And multipart file file = { read: 'botDefinition1.json', filename: 'botDefinition1.json', contentType: 'application/json' }
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
    And multipart file file = { read: 'config1.json', filename: 'config1.json', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'json'
    When method post
    Then status 200
    * def ConusmerBotConfigFileID = response.fileId
    * JavaClass.add('ConusmerBotConfigFileID', ConusmerBotConfigFileID )
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * print ConusmerBotConfigFileID

  Scenario: Positive Scenario ----> Import Bot into an Existing Bot As FullImport With all valid fields
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * print ConusmerBotDefinitionFileID
    * print ConusmerBotConfigFileID
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * print Payload
    Given url publicUrl
    Then path '/public/bot/'+SanityBotStreamId+'/import'
    * print JWTToken
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 422
    And print 'Response is ', response
    And match $.errors..msg == ["The file contains the definition of the Universal Bots built using an older version. This version is no longer supported and the file cannot be imported."]
  

  

  