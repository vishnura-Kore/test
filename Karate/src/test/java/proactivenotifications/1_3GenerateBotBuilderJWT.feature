@runtime
Feature: Generate Bot Builder JWT Token
Background:
 * url jwturl


Scenario: Generate JWT Token
    * def JavaClass = Java.type('data.HashMap')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def scopeclientSecret2 = JavaClass.get('scopeclientSecret2')
    * def scopeclientId2 = JavaClass.get('scopeclientId2')
    * def Payload = 
   """
    {
    "clientId": "scopeclientId2",
    "clientSecret": "scopeclientSecret2",
    "identity": "botadminUserID1",
    "aud": "",
    "isAnonymous": true
}
   """
   * set Payload.clientId = scopeclientId2
   * set Payload.identity = botadminUserID1
   * set Payload.clientSecret = scopeclientSecret2
   * print Payload
   And request Payload
   And header Content-Type = 'application/json'
   When method post
   Then status 200
   And print 'Response is: ', response
    * def BotBuilderJWTToken = response.jwt
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('BotBuilderJWTToken', BotBuilderJWTToken)
    And print  'Response is ' , response 
   
   