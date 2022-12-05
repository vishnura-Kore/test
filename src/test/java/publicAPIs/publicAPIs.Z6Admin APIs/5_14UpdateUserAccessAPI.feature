Feature: Update User Access API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def CustomAdmin1Id = JavaClass.get('CustomAdmin1Id')
     * def Custom1RoleId = JavaClass.get('Custom1RoleId')
    * def SanitystreamId = JavaClass.get('SanitystreamId')

  Scenario: PositiveScenario....>> Update User Access API with all parameters as true
    * def Payload =
      """
    {
    "emailIds": [
        "test3@koreai.in"
    ],
    "canCreateBot": true,
    "isDeveloper": true,
    "hasDataTableAndViewAccess": true
}
      """
   
    Given url publicUrl
    Then path '/public/useraccess'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response[0] == "SUCCESS"
    
    
    
     Scenario: PositiveScenario....>> Update User Access API with  parameters "canCreateBot" as fasle
    * def Payload =
      """
    {
    "emailIds": [
        "test3@koreai.in"
    ],
    "canCreateBot": false,
    "isDeveloper": true,
    "hasDataTableAndViewAccess": true
}
      """
   
    Given url publicUrl
    Then path '/public/useraccess'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response[0] == "SUCCESS"
    
    
    
     Scenario: PositiveScenario....>> Update User Access API with  parameters "isDeveloper" as fasle
    * def Payload =
      """
    {
    "emailIds": [
        "test3@koreai.in"
    ],
    "canCreateBot": true,
    "isDeveloper": false,
    "hasDataTableAndViewAccess": true
}
      """
   
    Given url publicUrl
    Then path '/public/useraccess'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 403
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid values in the body"]
    And match $.errors..code == [403]
    
    
       Scenario: PositiveScenario....>> Update User Access API with  parameters "emailID" is empty
    * def Payload =
      """
    {
    "emailIds": [
        
    ],
    "canCreateBot": true,
    "isDeveloper": true,
    "hasDataTableAndViewAccess": true
}
      """
   
    Given url publicUrl
    Then path '/public/useraccess'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And print 'Response is: ', response
    And match $.errors..msg == ["emailIds cannot be empty"]
    And match $.errors..code == [400]
    
      Scenario: PositiveScenario....>> Update User Access API with  parameters "emailID"  which is not present in DB
    * def Payload =
      """
    {
    "emailIds": [
        "wusonewe@boximail.com"
    ],
    "canCreateBot": true,
    "isDeveloper": true,
    "hasDataTableAndViewAccess": true
}
      """
   
    Given url publicUrl
    Then path '/public/useraccess'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And print 'Response is: ', response
      And match $.errors..msg == ["One or more entered emails not found"]
    And match $.errors..code == [400]