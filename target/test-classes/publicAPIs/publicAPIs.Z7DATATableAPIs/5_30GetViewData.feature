  
  Feature: get view data in data table

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def DataTableJWTToken = JavaClass.get('DataTableJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def TableViewname = JavaClass.get('TableViewname')
  
  Scenario: Positive Scenario--------->>get view data  in the Table
     Given url publicUrl
    * def Payload = read("GetViewData.json")
    Given path '/public/views/'+TableViewname+'/query'
    And param sys_limit = '5'
    And param sys_offset = '0'
    And header auth = DataTableJWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
   