@runtime
Feature: BotImport As a NewBot Using Public API with Positive and negative Scenarios

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

  Scenario: BotFunction File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = JWTToken
    And multipart file file = { read: 'temp.js', filename: 'temp.js', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'js'
    When method post
    Then status 200
    * def BotFunctionFIleID = response.fileId
    * JavaClass.add('BotFunctionFIleID', BotFunctionFIleID )
    * print BotFunctionFIleID

  Scenario: Positive Scenario ----> Bot import with all valid fields
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * print ConusmerBotDefinitionFileID
    * print ConusmerBotConfigFileID
    * print BotFunctionFIleID
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID",
      "botFunctions": [ "BotFunctionFIleID" ],
      "icon" : "5fcb2ebfbbab2c550c2b1707",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * set Payload.name = 'PublicConsumerbot'+name
    * set Payload.botFunctions[0] = BotFunctionFIleID
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

  Scenario: Negative Scenarios --->  Bot import with no configInfo Id
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * def name = JavaMethods.generateRandom('number')
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "botFunctions": [ "BotFunctionFIleID" ],
      "icon" : "5fcb2ebfbbab2c550c2b1707",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.botFunctions[0] = BotFunctionFIleID
    * set Payload.name = 'PublicConsumerbot'+name
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 412
    * match response.errors[0].msg == 'Validation errors/ Invalid arguments'
    * match response.errors[0].code == 412
    And print 'Response is ', response

  Scenario: Negative Scenarios --->  Bot import with no  Botdefinition File id
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * def Payload =
      """
       {
      "configInfo" : "ConusmerBotConfigFileID",
      "botFunctions": [ "BotFunctionFIleID" ],
      "icon" : "5fcb2ebfbbab2c550c2b1707",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.configInfo = ConusmerBotConfigFileID
    * set Payload.botFunctions[0] = BotFunctionFIleID
    * set Payload.name = 'PublicConsumerbot'
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    * print JWTToken
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 412
    * match response.errors[0].msg == 'Validation errors/ Invalid arguments'
    * match response.errors[0].code == 412
    And print 'Response is ', response

  Scenario: Negative Scenarios --->  Bot import with no  BotIcon  id
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * def Payload =
      """
       {
       "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID",
       "botFunctions": [ "BotFunctionFIleID" ],
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * set Payload.botFunctions[0] = BotFunctionFIleID
    * set Payload.name = 'PublicConsumerbot'
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 412
    * match response.errors[0].msg == 'Validation errors/ Invalid arguments'
    * match response.errors[0].code == 412
    And print 'Response is ', response

  Scenario: Negative Scenarios --->  Bot import with no  botFunctions File id
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
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
    * set Payload.configInfo = ConusmerBotConfigFileID
    * set Payload.name = 'PublicConsumerbot'
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is ', response

  Scenario: Negative Scenarios --->  Bot import with invalid config file id
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * print ConusmerBotDefinitionFileID
    * print ConusmerBotConfigFileID
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID",
      "botFunctions": [ "BotFunctionFIleID" ],
      "icon" : "5fcb2ebfbbab2c550c2b1707",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = 'ConusmerBotConfigFileID'
    * set Payload.botFunctions[0] = BotFunctionFIleID
    * set Payload.name = 'PublicConsumerbot'
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 400
    * match response.errors[0].msg == 'Invalid file id'
    * match response.errors[0].code == 400
    And print 'Response is ', response

  Scenario: Negative Scenarios ---> Bot import with invalid Botdefinition  file id
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID",
      "botFunctions": [ "BotFunctionFIleID" ],
      "icon" : "5fcb2ebfbbab2c550c2b1707",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = 'ConusmerBotDefinitionFileID'
    * set Payload.configInfo = ConusmerBotConfigFileID
    * set Payload.botFunctions[0] = BotFunctionFIleID
    * set Payload.name = 'PublicConsumerbot'
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 400
    * match response.errors[0].msg == 'Invalid file id'
    * match response.errors[0].code == 400
    And print 'Response is ', response

  Scenario: Negative Scenarios --->  Bot import with invalid BotIcon  id
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID",
      "botFunctions": [ "BotFunctionFIleID" ],
      "icon" : "korewerd",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * set Payload.botFunctions[0] = BotFunctionFIleID
    * set Payload.name = 'PublicConsumerbot'
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 400
    * match response.errors[0].msg == 'Invalid file id'
    * match response.errors[0].code == 400
    And print 'Response is ', response

  Scenario: Negative Scenarios --->  Bot import with invalid BotFunction  id
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID",
      "botFunctions": [ "BotFunctionFIleID" ],
      "icon" : "5fcb2ebfbbab2c550c2b1707",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * set Payload.botFunctions[0] = 'BotFunctionFIleID'
    * set Payload.name = 'PublicConsumerbot'
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 400
    * match response.errors[0].msg == 'Invalid file id'
    * match response.errors[0].code == 400
    And print 'Response is ', response

  Scenario: Negative Scenarios --->   Bot import with wrong JWT Token
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID",
       "botFunctions": [ "BotFunctionFIleID" ],
      "icon" : "5fcb2ebfbbab2c550c2b1707",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * set Payload.botFunctions[0] = BotFunctionFIleID
    * set Payload.name = 'PublicConsumerbot12'
    Given url publicUrl
    Then path '/public/bot/import'
    * print JWTToken
    And header auth = 'JWTToken'
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 401
    * match response.errors[0].msg == 'Invalid JWT token'
    * match response.errors[0].code ==  4002
    And print 'Response is ', response

  Scenario: Negative Scenarios --->  Bot import with no  JWT Token
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID",
       "botFunctions": [ "BotFunctionFIleID" ],
      "icon" : "5fcb2ebfbbab2c550c2b1707",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * set Payload.name = 'PublicConsumerbot12'
    * set Payload.botFunctions[0] = BotFunctionFIleID
    Given url publicUrl
    Then path '/public/bot/import'
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 401
    * match response.errors[0].msg == 'Invalid SDK credentials'
    * match response.errors[0].code ==  4002
    And print 'Response is ', response

  Scenario: Negative Scenarios --->  Bot import with incorrect AppScopes
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * def JWTToken1 = JavaClass.get('JWTToken1')
    * print JWTToken1
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID",
       "botFunctions": [ "BotFunctionFIleID" ],
      "icon" : "5fcb2ebfbbab2c550c2b1707",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * set Payload.name = 'PublicConsumerbot12'
    * set Payload.botFunctions[0] = BotFunctionFIleID
    Given url publicUrl
    Then path '/public/bot/import'
    And header auth = JWTToken1
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 401
    * match response.errors[0].msg == 'Permission denied. Scope is incorrect!'
    * match response.errors[0].code ==  4002
    And print 'Response is ', response

  Scenario: Negative Scenarios --->  Bot Import With only Bot Defnition File Id
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * print ConusmerBotDefinitionFileID
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    * print JWTToken
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 412
    * match response.errors[0].msg == 'Validation errors/ Invalid arguments'
    * match response.errors[0].code == 412
    And print 'Response is ', response

  Scenario: Negative Scenarios --->  Bot Import with only Bot Config File Id
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def Payload =
      """
       {
      "configInfo" : "ConusmerBotConfigFileID"
      }
      """
    * set Payload.configInfo = ConusmerBotConfigFileID
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 412
    * match response.errors[0].msg == 'Validation errors/ Invalid arguments'
    * match response.errors[0].code == 412
    And print 'Response is ', response

  Scenario: Negative Scenarios ---> 14  With only Bot Icon  Id
    * def Payload =
      """
      {
      
      "icon" : "5fcb2ebfbbab2c550c2b1707"
      }
      """
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 412
    * match response.errors[0].msg == 'Validation errors/ Invalid arguments'
    * match response.errors[0].code == 412
    And print 'Response is ', response

  Scenario: Negative Scenarios ---> Bot Import with only Bot FunctionfileId
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * def Payload =
      """
      {
      
      "botFunctions": [ "BotFunctionFIleID" ]
      }
      """
    * set Payload.botFunctions[0] = BotFunctionFIleID
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 412
    * match response.errors[0].msg == 'Validation errors/ Invalid arguments'
    * match response.errors[0].code == 412
    And print 'Response is ', response

  Scenario: Negative Scenarios ---> 14  All ids are invalid
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def Payload =
      """
      {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID",
      "botFunctions": [ "BotFunctionFIleID" ],
      "icon" : "abcd",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = 'ConusmerBotDefinitionFileID'
    * set Payload.configInfo = 'ConusmerBotConfigFileID'
    * set Payload.botFunctions[0] = 'BotFunctionFIleID'
    * set Payload.name = 'PublicConsumerbot'
    * print Payload
    Given url publicUrl
    Then path '/public/bot/import'
    And header auth = 'JWTToken'
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 401
    * match response.errors[0].msg == 'Invalid JWT token'
    * match response.errors[0].code == 4002
    And print 'Response is ', response

  Scenario: Negative Scenarios --->   Bot import with wrong  method
    * def BotFunctionFIleID = JavaClass.get('BotFunctionFIleID')
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def Payload =
      """
       {
      "botDefinition" : "ConusmerBotDefinitionFileID",
      "configInfo" : "ConusmerBotConfigFileID",
      "botFunctions": [ "BotFunctionFIleID" ],
      "icon" : "5fcb2ebfbbab2c550c2b1707",
      "name" : "PublicConsumerbot",
      "purpose" : "customer",
      "color" : "#009dab"
      }
      """
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * set Payload.botFunctions[0] = BotFunctionFIleID
    * set Payload.name = 'PublicConsumerbot12'
    Given url publicUrl
    Then path '/public/bot/import'
    * print JWTToken
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method get
    Then status 405
    * match response.errors[0].msg == 'Method Not Allowed'
    * match response.errors[0].code ==  405
    And print 'Response is ', response
    
   
    
    
