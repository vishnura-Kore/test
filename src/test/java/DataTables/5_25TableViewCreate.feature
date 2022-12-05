Feature: Creating App for Table

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
      * def Tablename = JavaClass.get('Tablename')
      * def TableclientId = JavaClass.get('TableclientId')
      
    

 
 
 
 Scenario: Creating App for Table
    * def Payload = read("CreateTableView.json")
    * set Payload.query.dataSet = Tablename
    * set Payload.query.filterBy.rules[0].field = Tablename+".EmployeeName"
    * set Payload.query.filterBy.rules[1].rules[0].field = Tablename+".EmployeeDOB"
     * set Payload.query.filterBy.rules[1].rules[1].rules[0].field = Tablename+".EmployeeId"
     * set Payload.name = "SanityTableView"+name
     * set Payload.appScopes[0].appId = TableclientId
    Given path '/users/'+botadminUserID1+'/builder/views'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    * def TableViewname = response.name
    * JavaClass.add('TableViewname', TableViewname)