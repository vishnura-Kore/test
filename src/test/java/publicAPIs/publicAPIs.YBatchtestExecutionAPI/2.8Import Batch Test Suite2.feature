Feature: Batch Test Execution Status API with Positive and Negative Scenarios
Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    
    Scenario: BotDefinition File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = BotBuilderJWTToken
    And multipart file file = { read: 'JSONUploadFiles/BatchtestingKarate50.csv', filename: 'JSONUploadFiles/BatchtestingKarate50.csv', contentType: 'JSONUploadFiles/BatchtestingKarate50.csv' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'json'
    When method post
    Then status 200
    * def FileId = response.fileId
    * JavaClass.add('FileId', FileId)
    * print FileId

  Scenario: Import testSuite
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def FileId = JavaClass.get('FileId')
    * def Payload = read('JSONUploadFiles/importtestsuitePayload2.json')
    * set Payload.fileName = FileId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/import'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def BatchtestID = response._id
    * def BatchTestName = response.name
    * JavaClass.add('BatchtestID', BatchtestID)
    * JavaClass.add('BatchTestName', BatchTestName)
    * print BatchtestID
    * print BatchTestName

  Scenario: Positive Scenario -----------> BatchTestSuite Execution  in Developed version 
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    * def BatchTestName = JavaClass.get('BatchTestName')
    * def fileId = JavaClass.get('fileId')
    * def Payload = read("JSONUploadFiles/BatchtestExecutioninDevelopmentmode.json")
    * set Payload.fileName = fileId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/'+BatchTestName+'/run'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def batchtestId2 = response.requestId
    * JavaClass.add('batchtestId2',batchtestId2)
    And match $..status == ['accepted']
    
    
    Scenario: Positive Scenario -----------> BatchTestSuite Execution in developed version Status API
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId2 = JavaClass.get('batchtestId2')
     * def BatchTestName = JavaClass.get('BatchTestName')
    * print SanitystreamId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/'+BatchTestName+'/'+batchtestId2+'/status'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'completed' || response.status == 'failed'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..status contains ["completed"]
    And match $..runType == ["inDevelopment"]
    
    
    
    
    
    Scenario: Positive Scenario -----------> BatchTestSuite Execution in publish version
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    * def BatchTestName = JavaClass.get('BatchTestName')
    * def fileId = JavaClass.get('fileId')
    * def Payload = read("JSONUploadFiles/BatchtestExecutioninPublished.json")
    * set Payload.fileName = fileId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/'+BatchTestName+'/run'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def batchtestId3 = response.requestId
    * JavaClass.add('batchtestId3',batchtestId3)
    And match $..status == ['accepted']
    
    
    Scenario: Positive Scenario -----------> BatchTestSuite in published version Status API
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId3 = JavaClass.get('batchtestId3')
     * def BatchTestName = JavaClass.get('BatchTestName')
    * print SanitystreamId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/'+BatchTestName+'/'+batchtestId3+'/status'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'completed' || response.status == 'failed'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..status contains ["completed"]
    And match $..runType == ["published"]
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    