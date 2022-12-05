Feature: Import BotrolesID with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    

  Scenario: CSV File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = BotBuilderJWTToken
    And multipart file file = { read: 'Botroles', filename: 'Botroles', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'json'
    When method post
    Then status 200
    And print response
    * def BotrolesID = response.fileId
    * JavaClass.add('BotrolesID', BotrolesID)
    * print BotrolesID
    

  Scenario: PositiveScenario....>> BotrolesIDImport  with CSV FILE ID
    * def BotrolesID = JavaClass.get('BotrolesID')
    * def Payload = 
    """
    {
    "fileId": "IMportAdminRoles"
}
"""
    * set Payload.fileId = BotrolesID
    Given url publicUrl
    Then path '/public/roles/import'
    And param roleType = 'bot'
    And param fullImport = 'true'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response[1].roleType == "bot"
    
    * def BotDeveloperId = response[0]._id
    * def BotTesterId = response[1]._id
    * JavaClass.add('BotDeveloperId', BotDeveloperId)
    * JavaClass.add('BotTesterId', BotTesterId)
  
    
    
    
  Scenario: Negative....>>Import BotrolesID  with wrong CSV FILE ID
    * def BotrolesID = JavaClass.get('BotrolesID')
    * def Payload = 
    """
    {
    "fileId": "12345678945"
}
"""
    
    Given url publicUrl
    Then path '/public/roles/import'
    And param roleType = 'bot'
    And param fullImport = 'true'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And print 'Response is: ', response
        And match $.errors..msg == ["Invalid file id"]
    And match $.errors..code == [400]
    
    
    
     Scenario: Negative....>> Import BotrolesID  with wrong jwttoken
    * def BotrolesID = JavaClass.get('BotrolesID')
    * def Payload = 
    """
    {
    "fileId": "IMportAdminRoles"
}
"""
    * set Payload.fileId = BotrolesID
    Given url publicUrl
    Then path '/public/roles/import'
    And param roleType = 'bot'
    And param fullImport = 'true'
    And request Payload
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
    
      Scenario: NegativeScenario....>> Import BotrolesID  with no jwttoken
    * def BotrolesID = JavaClass.get('BotrolesID')
    * def Payload = 
    """
    {
    "fileId": "IMportAdminRoles"
}
"""
    * set Payload.fileId = BotrolesID
    Given url publicUrl
    Then path '/public/roles/import'
    And param roleType = 'bot'
    And param fullImport = 'true'
    And request Payload
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    Scenario: NegativeScenario....>> Import BotrolesID with wrong http method
    * def BotrolesID = JavaClass.get('BotrolesID')
    * def Payload = 
    """
    {
    "fileId": "IMportAdminRoles"
}
"""
    * set Payload.fileId = BotrolesID
    Given url publicUrl
    Then path '/public/roles/import'
    And param roleType = 'bot'
    And param fullImport = 'true'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 405
    And print 'Response is: ', response
      And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]