@runtime
Feature: feature for creating JWT Token
Background:
 * url jwturl


Scenario: Generate JWT Token
    * def JavaClass = Java.type('data.HashMap')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def scopeclientSecret1 = JavaClass.get('scopeclientSecret1')
    * def scopeclientId1 = JavaClass.get('scopeclientId1')
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
   * set Payload.clientId = scopeclientId1
   * set Payload.identity = botadminUserID1
   * set Payload.clientSecret = scopeclientSecret1
   * print Payload
   And request Payload
   And header Content-Type = 'application/json'
   When method post
   Then status 200
   And print 'Response is: ', response
    * def JWTToken = response.jwt
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('JWTToken', JWTToken)
    And print  'Response is ' , response 
   
   