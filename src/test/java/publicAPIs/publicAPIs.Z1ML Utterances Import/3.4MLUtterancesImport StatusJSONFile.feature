Feature: MLUtterancesImportAPI with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId

  Scenario: JSON File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = BotBuilderJWTToken
    And multipart file file = { read: 'UploadFiles/Import_MLUtterances50.json', filename: 'UploadFiles/Import_MLUtterances50.json', contentType: 'UploadFiles/Import_MLUtterances50.json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'JSON'
    When method post
    Then status 200
    * def JSONFileId = response.fileId
    * JavaClass.add('JSONFileId', JSONFileId)
    * print JSONFileId

  Scenario: Positive Scenario MLUtterancesImportAPI with JSON File Id
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def JSONFileId = JavaClass.get('JSONFileId')
    * def Payload = read('UploadFiles/payload.json')
    * set Payload.fileId = JSONFileId
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/mlimport'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def MLUtterenceID1 = response._id
    * JavaClass.add('MLUtterenceID1', MLUtterenceID1)
    * print MLUtterenceID1
    And match $..status == ["pending"]
    And match $..requestType == ["MLimport"]

  Scenario: Positive Scenario MLUtteranceTrain WithJSON File
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID1 = JavaClass.get('MLUtterenceID1')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/mlimport/status/'+MLUtterenceID1
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..status == ["pending"]
    And match $..requestType == ["MLimport"]

  Scenario: Positive Scenario MLUtteranceTrainStatusAPI With CSV File
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/ml/train'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..message == ["Training Queued."]

  Scenario: Positive Scenario MLUtteranceTrainStatus With JSON File
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/ml/train/status'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'Finished' || response.status == 'failed'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..trainingStatus == ["Finished"]
   