@runtime
Feature: feature 
Background:
 * url jwturl


Scenario: Generate JWT Token
    * def JavaClass = Java.type('data.HashMap')
    * def botadminUserID2 = JavaClass.get('botadminUserID2')
    * def scopeclientSecret12 = JavaClass.get('scopeclientSecret12')
    * def scopeclientId12 = JavaClass.get('scopeclientId12')
    * def Payload = 
   """
    {
    "clientId": "scopeclientId12",
    "clientSecret": "scopeclientSecret12",
    "identity": "botadminUserID2",
    "aud": "",
    "isAnonymous": true
}
   """
   * set Payload.clientId = scopeclientId12
   * set Payload.identity = botadminUserID2
   * set Payload.clientSecret = scopeclientSecret12
   * print Payload
   And request Payload
   And header Content-Type = 'application/json'
   When method post
   Then status 200
   And print 'Response is: ', response
    * def JWTTokenSecondAccount = response.jwt
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('JWTTokenSecondAccount', JWTTokenSecondAccount)
    And print  'Response is ' , response 
   
   