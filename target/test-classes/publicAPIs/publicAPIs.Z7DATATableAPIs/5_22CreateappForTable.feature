 
 
 Feature: Creating App for Table

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
     * def adminaccountID1 = JavaClass.get('adminaccountID1')
   
 
 
 
 
 Scenario: Creating App for Table
    * def Payload =
      """
     {
    "appName": "TableAPP",
    "isAdminApp": false,
    "algorithm": "HS256"
}
      """
    * set Payload.appName = 'Tableapp'+name
    Given path '/users/'+botadminUserID1+'/builder/apps'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    * def TableAppName = response.appName
    * def TableclientId = response.clientId 
    * def TableclientSecret = response.clientSecret
    * JavaClass.add('TableAppName', TableAppName)
    * JavaClass.add('TableclientId', TableclientId)
    * JavaClass.add('TableclientSecret', TableclientSecret)