Feature: Creating App for Table

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def DataTableJWTToken = JavaClass.get('DataTableJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def Tablename = JavaClass.get('Tablename')
  
 
 Scenario: Positive Scenario--------->>Inserting data  for the Table
     Given url publicUrl
    * def Payload = read("InsertDataAPI.json")
    Given path '/public/tables/'+Tablename
    And header auth = DataTableJWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..EmployeeName contains "john"
    
    
   Scenario: Positive Scenario--------->>Checking whether insert data is present or not
     Given url publicUrl
    Given path '/public/tables/'+Tablename+'/query'
    And header auth = DataTableJWTToken
    And header Content-Type = 'application/json'
    And request 
    """
    {
    "query": {
        "expressions": [
            {
                "field": "EmployeeName",
                "operand": "=",
                "value": john
            },
        ],
        "operator": "or"
    }
}
    """
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..EmployeeName contains "john"
  
    
    
    
    
    #Scenario: Negative Scenario----->>Inserting data  for the Table with invalidtablename
     #Given url publicUrl
    #* def Payload = read("InsertDataAPI.json")
    #Given path '/public/tables/'+Tablename+name
    #And header auth = DataTableJWTToken
    #And header Content-Type = 'application/json'
    #And request Payload
    #When method post
    #Then status 400
    #And print 'Response is: ', response
    
    #
     #Scenario: Negative Scenario----->>Inserting data  for the Table with Invalid JWT Token
     #Given url publicUrl
    #* def Payload = read("InsertDataAPI.json")
    #Given path '/public/tables/'+Tablename
    #And header auth = DataTableJWTToken+name
    #And header Content-Type = 'application/json'
    #And request Payload
    #When method post
    #Then status 401
    #And print 'Response is: ', response
    #
    #
    #
     #Scenario: Negative Scenario----->>Inserting data  for the Table with no JWT Token
     #Given url publicUrl
    #* def Payload = read("InsertDataAPI.json")
    #Given path '/public/tables/'+Tablename
    #And header Content-Type = 'application/json'
    #And request Payload
    #When method post
    #Then status 401
    #And print 'Response is: ', response
    #
    #
    #
    #
    #Scenario: Negative Scenario----->>Inserting data  for the Table with Valid body arguments
     #Given url publicUrl
    #* def Payload = 
    #"""
    #{
      #"data": {
        #"EmployeeName": "john",
        #"": 1234557,
        #"EmployeeDOB": "12/05/1997"
    #}
#}
    #"""
    #Given path '/public/tables/'+Tablename
     #And header auth = DataTableJWTToken
    #And header Content-Type = 'application/json'
    #And request Payload
    #When method post
    #Then status 400
    #And print 'Response is: ', response