@runtime
Feature: Import Bot into an Existing Bot with positive and negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def JWTToken1 = JavaClass.get('JWTToken1')
    * def PstreamId = JavaClass.get('PstreamId')
    * def name = JavaMethods.generateRandom('number')

  Scenario: BotDefinition File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = JWTToken
    And multipart file file = { read: 'botuploadfiles/botDefinition.json', filename: 'botDefinition.json', contentType: 'application/json' }
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
    And multipart file file = { read: 'botuploadfiles/config.json', filename: 'config.json', contentType: 'application/json' }
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
    Then path '/public/bot/'+PstreamId+'/import'
    * print JWTToken
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is ', response
    * def ConusmerBotIDBir1 = response._id
    * JavaClass.add('ConusmerBotIDBir1', ConusmerBotIDBir1)

  Scenario: Positive Scenario ----> Bot import status with all valid details
    * def ConusmerBotIDBir1 = JavaClass.get('ConusmerBotIDBir1')
    * print ConusmerBotIDBir1
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir1
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failed'
    When method get
    Then status 200
    And print responseTime
    And print response
    * def PstreamId = response.streamId
    * JavaClass.add('PstreamId', PstreamId)

  Scenario: Positive Scenario ----> Import Bot into an Existing Bot As Incremental Import with only Bot tasks
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * print ConusmerBotDefinitionFileID
    * print ConusmerBotConfigFileID
    * def Payload = read('botuploadfiles/PayloadTask.json')
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * print Payload
    Given url publicUrl
    Then path '/public/bot/'+PstreamId+'/import'
    * print JWTToken
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is ', response
    * def ConusmerBotIDBir2 = response._id
    * JavaClass.add('ConusmerBotIDBir2', ConusmerBotIDBir2)
    And match response.status == "pending"

  Scenario: Positive Scenario ----> Import Bot into an Existing Bot As Incremental Import Status  with only Bot tasks
    * def ConusmerBotIDBir2 = JavaClass.get('ConusmerBotIDBir2')
    * print ConusmerBotIDBir2
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir2
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failed'
    When method get
    Then status 200
    And print responseTime
    And print response
    * def PstreamId = response.streamId
    * JavaClass.add('PstreamId', PstreamId)
    * print PstreamId
    And match $.statusLogs..taskType contains ["KnowledgeTasks"]
    And match $.statusLogs..taskType contains ["SmallTalk"]
    And match $.statusLogs..taskType contains ["Dialog"]

  Scenario: Positive Scenario ----> Import Bot into an Existing Bot As Incremental Import with only NLP DATA
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def Payload = read('botuploadfiles/PayloadNLP.json')
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * print Payload
    Given url publicUrl
    Then path '/public/bot/'+PstreamId+'/import'
    * print JWTToken
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is ', response
    * def ConusmerBotIDBir3 = response._id
    * JavaClass.add('ConusmerBotIDBir3', ConusmerBotIDBir3)
    And match response.status == "pending"

  Scenario: Positive Scenario ---->  Import Bot into an Existing Bot As Incremental Import status with only NLP DATA
    * def ConusmerBotIDBir3 = JavaClass.get('ConusmerBotIDBir3')
    * print ConusmerBotIDBir3
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir3
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failed'
    When method get
    Then status 200
    And print responseTime
    And print response
    * def PstreamId = response.streamId
    * JavaClass.add('PstreamId', PstreamId)
    * print PstreamId
    And match $.statusLogs..taskType contains ["Patterns"]
    And match $.statusLogs..taskType contains ["Standard Responses"]
    And match $.statusLogs..taskType contains ["Utterences"]

  Scenario: Positive Scenario ----> Import Bot into an Existing Bot As Incremental Import with only Settings Components
    * def ConusmerBotDefinitionFileID = JavaClass.get('ConusmerBotDefinitionFileID')
    * def ConusmerBotConfigFileID = JavaClass.get('ConusmerBotConfigFileID')
    * def Payload = read('botuploadfiles/PayloadSettings.json')
    * set Payload.botDefinition = ConusmerBotDefinitionFileID
    * set Payload.configInfo = ConusmerBotConfigFileID
    * print Payload
    Given url publicUrl
    Then path '/public/bot/'+PstreamId+'/import'
    * print JWTToken
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is ', response
    * def ConusmerBotIDBir4 = response._id
    * JavaClass.add('ConusmerBotIDBir4', ConusmerBotIDBir4)
    And match response.status == "pending"

  Scenario: Positive Scenario ----> Import Bot into an Existing Bot As Incremental Import status with only Settings
    * def ConusmerBotIDBir4 = JavaClass.get('ConusmerBotIDBir4')
    * print ConusmerBotIDBir4
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir4
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failed'
    When method get
    Then status 200
    And print responseTime
    And print response
    * def SanitystreamId = response.streamId
    * JavaClass.add('SanitystreamId', SanitystreamId)
    * print SanitystreamId
    And match $.statusLogs[8]..taskType contains ["BotVariables"]
    And match $.statusLogs..taskType contains ["CustomTemplates"]

  Scenario: Negative Scenario ----> Import Bot into an Existing Bot As FullImport With invalid StreamID
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
    Then path '/public/bot/'+PstreamId+name+'/import'
    * print JWTToken
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 400
    And print 'Response is ', response
    * def ConusmerBotIDBir1 = response._id
    * JavaClass.add('ConusmerBotIDBir1', ConusmerBotIDBir1)
    And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]

  Scenario: Negative Scenario ----> Import Bot into an Existing Bot As FullImport With No JWTToken
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
    Then path '/public/bot/'+PstreamId+'/import'
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 401
    And print 'Response is ', response
    * def ConusmerBotIDBir1 = response._id
    * JavaClass.add('ConusmerBotIDBir1', ConusmerBotIDBir1)
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Import Bot into an Existing Bot As FullImport With Invalid AppScopes
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
    Then path '/public/bot/'+PstreamId+'/import'
    And header auth = JWTToken1
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 401
    And print 'Response is ', response
    * def ConusmerBotIDBir1 = response._id
    * JavaClass.add('ConusmerBotIDBir1', ConusmerBotIDBir1)
    And match $.errors..msg == ["Permission denied. Scope is incorrect!"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Import Bot into an Existing Bot As FullImport With Invalid JWT Token
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
    Then path '/public/bot/'+PstreamId+'/import'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 401
    And print 'Response is ', response
    * def ConusmerBotIDBir1 = response._id
    * JavaClass.add('ConusmerBotIDBir1', ConusmerBotIDBir1)
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Import Bot into an Existing Bot As FullImport With Wrong HTTP METHOD
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
    Then path '/public/bot/'+PstreamId+'/import'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method get
    Then status 405
    And print 'Response is ', response
    * def ConusmerBotIDBir1 = response._id
    * JavaClass.add('ConusmerBotIDBir1', ConusmerBotIDBir1)
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]

  Scenario: Negative Scenario ----> Import Bot into an Existing Bot Status with Invalid Id
    * def ConusmerBotIDBir1 = JavaClass.get('ConusmerBotIDBir1')
    * print ConusmerBotIDBir1
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir1+name
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 400
    And print responseTime
    And print response
    * def PstreamId = response.streamId
    * JavaClass.add('PstreamId', PstreamId)
    * print PstreamId
    And match $.errors..msg == ["Invalid request ID"]
    And match $.errors..code == [400]

  Scenario: Negative Scenario ----> Import Bot into an Existing Bot Status with No JWT Token
    * def ConusmerBotIDBir1 = JavaClass.get('ConusmerBotIDBir1')
    * print ConusmerBotIDBir1
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir1+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print responseTime
    And print response
    * def PstreamId = response.streamId
    * JavaClass.add('PstreamId', PstreamId)
    * print PstreamId
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Import Bot into an Existing Bot Status with Wrong Appscopes
    * def ConusmerBotIDBir1 = JavaClass.get('ConusmerBotIDBir1')
    * print ConusmerBotIDBir1
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir1
    And header auth = JWTToken1
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print responseTime
    And print response
    * def PstreamId = response.streamId
    * JavaClass.add('PstreamId', PstreamId)
    * print PstreamId
    And match $.errors..msg == ["Permission denied. Scope is incorrect!"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Import Bot into an Existing Bot Status with Wrong HTTP Method
    * def ConusmerBotIDBir1 = JavaClass.get('ConusmerBotIDBir1')
    * print ConusmerBotIDBir1
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir1+name
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print responseTime
    And print response
    * def PstreamId = response.streamId
    * JavaClass.add('PstreamId', PstreamId)
    * print PstreamId
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]

  
