Feature: get data in data table

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def DataTableJWTToken = JavaClass.get('DataTableJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def Tablename = JavaClass.get('Tablename')
   
  
 
 Scenario: Positive Scenario--------->>get data  in the Table
     Given url publicUrl
    * def Payload = read("GetTableData.json")
    Given path '/public/tables/'+Tablename+'/query'
    And header auth = DataTableJWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..EmployeeName contains "Dhoni"
    And match $..EmployeeName contains "Raina"
    
    
    
  