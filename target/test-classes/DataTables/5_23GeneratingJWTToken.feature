@runtime
Feature: feature for generating JWT Token
Background:
 * url jwturl

Scenario: Generate JWT Token
    * def JavaClass = Java.type('data.HashMap')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def TableclientId = JavaClass.get('TableclientId')
    * def TableclientSecret = JavaClass.get('TableclientSecret')
    * def Payload = 
   """
    {
    "clientId": "scopeclientId1",
    "clientSecret": "scopeclientSecret1",
    "identity": "botadminUserID1",
    "aud": "",
    "isAnonymous": true
}
   """
   * set Payload.clientId = TableclientId
   * set Payload.identity = botadminUserID1
   * set Payload.clientSecret = TableclientSecret
   * print Payload
   And request Payload
   And header Content-Type = 'application/json'
   When method post
   Then status 200
   And print 'Response is: ', response
    * def DataTableJWTToken = response.jwt
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('DataTableJWTToken', DataTableJWTToken)
    And print  'Response is ' , response 
   
    