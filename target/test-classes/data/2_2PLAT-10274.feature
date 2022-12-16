@public1
Feature: PLAT-10274

  Background: 
    * url appUrl
 * def JavaClass = Java.type('data.HashMap')
 * def EERSJWT = JavaClass.get('EERSJWT')
 * def JavaMethods = Java.type('data.commonJava')
  Scenario: upload
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = EERSJWT
    And multipart file file = { read: 'bot2Definition.json', filename: 'bot2Definition.json', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'json'
    When method post
    Then status 200
    * def ConusmerBotDefinitionFileID = response.fileId
    * JavaClass.add('ConusmerBotDefinitionFileID', ConusmerBotDefinitionFileID)
    * print ConusmerBotDefinitionFileID
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = EERSJWT
    And multipart file file = { read: 'config2.json', filename: 'config2.json', contentType: 'application/json' }
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
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID",
      "icon" : "5fcb2ebfbbab2c550c2b1707",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = 'ConusmerBotConfigFileID'+name
    * set Payload.name = 'PublicConsumerbot'+name
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    * print EERSJWT
    And header auth = EERSJWT
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 400
   * match response.errors[0].msg == 'Invalid file id'
   * match response.errors[0].code == 400
    And print 'Response is ', response
   
  
   

 