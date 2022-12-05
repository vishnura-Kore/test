Feature: Extraction from file with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
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
    And multipart file file = { read: '500FAQNG.csv', filename: '500FAQNG.csv', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'csv'
    When method post
    Then status 200
    * def CSVFileId = response.fileId
    * JavaClass.add('CSVFileId', CSVFileId)
    * print CSVFileId
    
     Scenario: Positive Scenario KG--Extraction from file
     * def CSVFileId = JavaClass.get('CSVFileId')
     * def Payload = 
    """
    {
    "fileId": "63075bc119048519a0ae0d5e",
    "name": "KGFile"
}
  
    """
    * set Payload.fileId = CSVFileId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/import'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $.status == "success"
     * def KGID1 = response._id
    * JavaClass.add('KGID1', KGID1)
    
    Scenario: Positive Scenario Get Extractions History
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/history'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    
    
     Scenario: Positive Scenario Get Extraction Question
     * def KGID1 = JavaClass.get('KGID1')
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/'+KGID1+'/questions'
    And param limit = '='
    And param offset = '='
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match response.qnaCount == 501
    
    
     Scenario: Positive Scenario Get KnowledgeTasks
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/knowledgeTasks'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    * def KGTaskID = response[0]._id
    * def KGParentId = response[0].parentId
    * JavaClass.add('KGTaskID', KGTaskID)
    * JavaClass.add('KGParentId', KGParentId)
    * print KGTaskID
    And match response[0].faqCount == 3
    
     Scenario: Negative Scenario KG--Extraction from Wrong file
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/import'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request 
    """
   {
    "fileId": "123efefhjefhhu",
    "name": "KGFiles"
}
  
    """
    When method post
    Then status 400
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid file id"]
    And match $.errors..code == [400]
   
   
    
        Scenario: negative Scenario KG--Extraction from file with wrong streamid
     * def CSVFileId = JavaClass.get('CSVFileId')
     * def Payload = 
    """
    {
    "fileId": "63075bc119048519a0ae0d5e",
    "name": "KGFile"
}
  
    """
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/qna/import'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 400
    And print 'Response is: ', response
       And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]
    
    
    
      Scenario: negative Scenario KG--Extraction from file with wrong Http method
     * def CSVFileId = JavaClass.get('CSVFileId')
     * def Payload = 
    """
    {
    "fileId": "63075bc119048519a0ae0d5e",
    "name": "KGFile"
}
  
    """
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/import'
    And param language = 'en'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    And request Payload
    When method get
    Then status 405
    And print 'Response is: ', response
      And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
    
    
       Scenario: negative Scenario KG--Extraction from file with no JWT TOKEN
     * def CSVFileId = JavaClass.get('CSVFileId')
     * def Payload = 
    """
    {
    "fileId": "63075bc119048519a0ae0d5e",
    "name": "KGFile"
}
  
    """
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/import'
    And param language = 'en'
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    