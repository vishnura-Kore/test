
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

  Scenario: CSV File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = BotBuilderJWTToken
    And multipart file file = { read: 'UploadFiles/fileupload_MLUtterances.csv', filename: 'UploadFiles/fileupload_MLUtterances.csv', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'csv'
    When method post
    Then status 200
    * def CSVFileId = response.fileId
    * JavaClass.add('CSVFileId', CSVFileId)
    * print CSVFileId
    

  Scenario: PositiveScenario....>> MLUtterancesImport  with CSV FILE ID
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def CSVFileId = JavaClass.get('CSVFileId')
    * def Payload = read('UploadFiles/payloadCSV.json')
    * set Payload.fileId = CSVFileId
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/mlimport'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def MLUtterenceID = response._id
    * JavaClass.add('MLUtterenceID', MLUtterenceID)
    * print MLUtterenceID
    And match $..status == ["pending"]
    And match $..requestType == ["MLimport"]
    
    
     * def sleep =
      """
      function(seconds){
        for(i = 0; i <= seconds; i++)
        {
          java.lang.Thread.sleep(1*5000);
          karate.log(i);
        }
      }
      """
* call sleep 10 

    Scenario: PositiveScenario...>>MLUtterancesImportStatus With CSV File
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/mlimport/status/'+MLUtterenceID
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..status == ["success"]
    And match $..requestType == ["MLimport"]
    And match $..message == ["File imported completed. 124 utterances copied successfully"]
    
    


  Scenario: Positive Scenario MLUtteranceTrain API With CSV File
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
    
    * def sleep =
      """
      function(seconds){
        for(i = 0; i <= seconds; i++)
        {
          java.lang.Thread.sleep(1*5000);
          karate.log(i);
        }
      }
      """
* call sleep 10

  Scenario: Positive Scenario MLUtteranceTrainStatus With csv File
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/ml/train/status'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    #And retry until response.status == 'Finished' || response.status == 'failed'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..trainingStatus == ["Finished"]
    
    
    Scenario: CSV JunkFile upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = BotBuilderJWTToken
    And multipart file file = { read: 'UploadFiles/ImportFile_emptydata.csv', filename: 'UploadFiles/ImportFile_emptydata.csv', contentType: 'UploadFiles/ImportFile_emptydata.csv' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'csv'
    When method post
    Then status 200
    * def CSVJUNKFileId = response.fileId
    * JavaClass.add('CSVJUNKFileId', CSVJUNKFileId)
    * print CSVJUNKFileId
    
    
    Scenario: NegativeScenario....>> MLUtterancesImport with CSV JUNK FILE ID
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def CSVJUNKFileId = JavaClass.get('CSVJUNKFileId')
    * def Payload = read('UploadFiles/junkpayload3.json')
    * set Payload.fileId = CSVJUNKFileId
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/mlimport'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And print 'Response is: ', response
   And match $.errors..msg == ["CSV format is incorrect"]
    
    
    
   

  Scenario: NegativeScenario....>> MLUtterancesImport with CSV FILE ID with invalid StreamId
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def CSVFileId = JavaClass.get('CSVFileId')
    * def Payload = read('UploadFiles/payload.json')
    * set Payload.fileId = CSVFileId
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+name+'/mlimport'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
    
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative  Scenario MLUtterancesImport with CSV FILE ID with invalid JWTToken
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def CSVFileId = JavaClass.get('CSVFileId')
    * def Payload = read('UploadFiles/payload.json')
    * set Payload.fileId = CSVFileId
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/mlimport'
    And request Payload
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative  Scenario MLUtterancesImport with CSV FILE ID with no JWTToken in header
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def CSVFileId = JavaClass.get('CSVFileId')
    * def Payload = read('UploadFiles/payload.json')
    * set Payload.fileId = CSVFileId
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/mlimport'
    And request Payload
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario MLUtterancesImport with CSV FILE ID with Wrong HTTP Method
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def CSVFileId = JavaClass.get('CSVFileId')
    * def Payload = read('UploadFiles/payload.json')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/mlimport'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 405
    And print 'Response is: ', response

  #Scenario: PositiveScenario...>>MLUtterancesImportStatus With CSV File
    #* def SanitystreamId = JavaClass.get('SanitystreamId')
    #* def MLUtterenceID = JavaClass.get('MLUtterenceID')
    #Given url publicUrl
    #Then path '/public/bot/'+SanitystreamId+'/mlimport/status/'+MLUtterenceID
    #And header auth = BotBuilderJWTToken
    #And header Content-Type = 'application/json'
    #And retry until response.status == 'success' || response.status == 'failure'
    #When method get
    #Then status 200
    #And print 'Response is: ', response
    #And match $..status == ["success"]
    #And match $..requestType == ["MLimport"]
    #And match $..message == ["File imported completed. 48 utterances copied successfully"]

  Scenario: NegativeScenario...>>MLUtterancesImportStatus With CSV File with invalid StreamId
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+name+'/mlimport/status/'+MLUtterenceID
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  
  Scenario: NegativeScenario...>>MLUtterancesImportStatus With CSV File with invalid JWT Token
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/mlimport/status/'+MLUtterenceID
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario...>>MLUtterancesImportStatus With CSV File with No JWT Token in Header
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/mlimport/status/'+MLUtterenceID
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario...>>MLUtterancesImportStatus With CSV File with Wrong HTTP Method
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/mlimport/status/'+MLUtterenceID
     And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response

  Scenario: PositiveScenario...>> MLUtteranceTrain With CSV File
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

  Scenario: NegativeScenario...>> MLUtteranceTrain With CSV File with invalid StreamId
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+name+'/ml/train'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario...>> MLUtteranceTrain With CSV File with invalid JWT Token
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/ml/train'
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario...>> MLUtteranceTrain With CSV File with invalid JWT Token
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/ml/train'
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario...>> MLUtteranceTrain With CSV File with no JWT Token in header
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/ml/train'
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario...>> MLUtteranceTrain With CSV File with Wrong HTTP Method
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/ml/train'
    And header Content-Type = 'application/json'
    When method get
    Then status 405
    And print 'Response is: ', response
   And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]

  Scenario: PositiveScenario....>> MLUtterancesImportAPI With CSV File
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/ml/train/status'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..trainingStatus == ["Finished"]

  Scenario: NegativeScenario....>> MLUtterancesImportAPI With CSV File with invalid StreamId
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+name+'/ml/train/status'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>> MLUtterancesImportAPI With CSV File with invalid JWT Token
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/ml/train/status'
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>> MLUtterancesImportAPI With CSV File with no JWT Token header
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/ml/train/status'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>> MLUtterancesImportAPI With CSV File with Wrong HTTP Method
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def MLUtterenceID = JavaClass.get('MLUtterenceID')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/ml/train/status'
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
