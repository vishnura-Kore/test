Feature: UB- BatchTest-Format for defining True Negatives
Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    * print SanityBotStreamId

  Scenario: CSV File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
     And header auth = BotBuilderJWTToken
    And multipart file file = { read: 'PDM12725allCasescoverd.csv', filename: 'PDM12725allCasescoverd.csv', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'json'
    When method post
    Then status 200
    * def CSVFileId = response.fileId
    * JavaClass.add('CSVFileId', CSVFileId)
    * print CSVFileId
    

  Scenario: PositiveScenario....>> Batchtest with CSV FILE ID
   * def CSVFileId = JavaClass.get('CSVFileId')
  * def Payload = 
  """
  {
    "importType": "update",
    "delimiter": ",",
    "fileType": "csv",
    "fileName": "62daa06738982a5db93ad0a9",
    "name": "check2",
    "description": "are"
}
  """
  
    * set Payload.fileName = CSVFileId
Given path '/stream/'+SanityBotStreamId+'/testsuite/import'
    And request Payload
      And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And print 'Response is: ', response
   
    
    
    
    
    