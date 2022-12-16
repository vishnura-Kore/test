Feature: Import AdminRoles with Positive and Negative Scenarios

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
    And multipart file file = { read: 'AdminRolesProd', filename: 'AdminRolesProd', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'json'
    When method post
    Then status 200
    * def AdminRolesId = response.fileId
    * JavaClass.add('AdminRolesId', AdminRolesId)
    * print AdminRolesId
    

  Scenario: PositiveScenario....>>  Import AdminRoles
    * def AdminRolesId = JavaClass.get('AdminRolesId')
    * def Payload = 
    """
    {
    "fileId": "IMportAdminRoles"
}
"""
    * set Payload.fileId = AdminRolesId
    Given url publicUrl
    Then path '/public/roles/import'
    And param roleType = 'admin'
    And param fullImport = 'true'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response[1].roleType == "admin"
    And match response[1].rDesc == "Testing Admin Role"
    * def Custom1RoleId = response[0]._id
    * def CustomAdmin1Id = response[1]._id
    * JavaClass.add('Custom1RoleId', Custom1RoleId)
    * JavaClass.add('CustomAdmin1Id', CustomAdmin1Id)
    
    
    
  Scenario: Negative....>> Import AdminRoles with wrong CSV FILE ID
    * def AdminRolesId = JavaClass.get('AdminRolesId')
    * def Payload = 
    """
    {
    "fileId": "12345678945"
}
"""
    
    Given url publicUrl
    Then path '/public/roles/import'
    And param roleType = 'admin'
    And param fullImport = 'true'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And print 'Response is: ', response
        And match $.errors..msg == ["Invalid file id"]
    And match $.errors..code == [400]
    
    
    
     Scenario: PositiveScenario....>>  Import AdminRoles with wrong jwttoken
    * def AdminRolesId = JavaClass.get('AdminRolesId')
    * def Payload = 
    """
    {
    "fileId": "IMportAdminRoles"
}
"""
    * set Payload.fileId = AdminRolesId
    Given url publicUrl
    Then path '/public/roles/import'
    And param roleType = 'admin'
    And param fullImport = 'true'
    And request Payload
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
    
      Scenario: PositiveScenario....>>  Import AdminRoles  with no jwttoken
    * def AdminRolesId = JavaClass.get('AdminRolesId')
    * def Payload = 
    """
    {
    "fileId": "IMportAdminRoles"
}
"""
    * set Payload.fileId = AdminRolesId
    Given url publicUrl
    Then path '/public/roles/import'
    And param roleType = 'admin'
    And param fullImport = 'true'
    And request Payload
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    Scenario: PositiveScenario....>>  Import AdminRoles with wrong http method
    * def AdminRolesId = JavaClass.get('AdminRolesId')
    * def Payload = 
    """
    {
    "fileId": "IMportAdminRoles"
}
"""
    * set Payload.fileId = AdminRolesId
    Given url publicUrl
    Then path '/public/roles/import'
    And param roleType = 'admin'
    And param fullImport = 'true'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 405
    And print 'Response is: ', response
      And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]