
Feature: updating data in data table

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def DataTableJWTToken = JavaClass.get('DataTableJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def Tablename = JavaClass.get('Tablename')
  
 
 Scenario: Positive Scenario--------->>updating data  in the Table
     Given url publicUrl
    * def Payload = read("updateData.json")
    Given path '/public/tables/'+Tablename
    And header auth = DataTableJWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method put
    Then status 200
    And print 'Response is: ', response
    