Feature: Creating App for Table

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def botName = JavaClass.get('botName')
    * def TableclientId = JavaClass.get('TableclientId')
    * def TableclientSecret = JavaClass.get('TableclientSecret')
    * def TableAppName = JavaClass.get('TableAppName')
    

  Scenario: Creating App for Table
    * def Payload = read("CreateTable.json")
    * set Payload.name = 'SanityTable'+name
    * set Payload.fields[0].name = "EmployeeDOB"
    * set Payload.fields[0].type = "date"
    * set Payload.fields[1].name = "EmployeeId"
    * set Payload.fields[1].type = "number"
    * set Payload.fields[2].name = "EmployeeName"
     * set Payload.fields[2].type = "string"
    * set Payload.indexes[0].name = "Employee Id index"
    * set Payload.indexes[0].key[0].column = "EmployeeId"
    * set Payload.appScopes[0].appName = TableAppName
    * set Payload.appScopes[0].appId = TableclientId
    * set Payload.description = "DataTableCreating"
    * set Payload.botScopes[0].streamId = SanitystreamId
    * set Payload.botScopes[0].botName = botName
    Given path '/users/'+botadminUserID1+'/builder/tables'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    * def Tablename = response.name
    * JavaClass.add('Tablename', Tablename)
    
