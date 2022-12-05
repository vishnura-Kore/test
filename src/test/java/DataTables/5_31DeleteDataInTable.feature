
  Feature: Delete data in data table

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def DataTableJWTToken = JavaClass.get('DataTableJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
   * def Tablename = JavaClass.get('Tablename')
   
  Scenario: Positive Scenario--------->>Delete data  in the Table
     Given url publicUrl
    * def Payload = read("Deletedata.json")
    Given path '/public/tables/'+Tablename
    And header auth = DataTableJWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method delete
    Then status 200
    And print 'Response is: ', response
    
   
   
 Scenario: Positive Scenario--------->> checking whether deleted data is present in table or not
     Given url publicUrl
    * def Payload = read("GetTabledataafterDeletion.json")
    Given path '/public/tables/'+Tablename+'/query'
    And header auth = DataTableJWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
      And match $..queryResult !contains "Jadeja"
    