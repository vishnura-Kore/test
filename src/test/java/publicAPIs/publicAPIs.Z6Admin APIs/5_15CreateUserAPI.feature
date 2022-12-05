Feature: Create user API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def CustomAdmin1Id = JavaClass.get('CustomAdmin1Id')
     * def GroupId1 = JavaClass.get('GroupId1')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')

  Scenario: PositiveScenario....>>Create user API 
    * def Payload = read("createuserPayload.json")
    * set Payload.users[0].userInfo.orgUserId = botadminorgID1
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.msg == "Users are created Successfully"
    
    
    
    
    Scenario: PositiveScenario....>>Create user API 
    * def Payload = 
"""
{
    "users": [
        {
            "userInfo": {
                "emailId": "testing11@zetmail.com"
            }
        }
 ]
}
"""
    
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.msg == "Users are created Successfully"
      
      
    
    
    
    Scenario: Negative Scenario----->> With invalid email id
    * def Payload =
      """
   {
    "users": [
        {
            "userInfo": {
                "emailId": "12335"
            }
        }
 ]
}
      """
   
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..reason == ["Invalid emailId"]
    And match $..status == ["failure"]
    
    
    
    
    
    
    
    
     Scenario: Negative scenario....>>Create user API with invalid JWT Token
    * def Payload = 
"""
{
    "users": [
        {
            "userInfo": {
                "emailId": "testing11@zetmail.com"
            }
        }
 ]
}
"""
    
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

       Scenario: Negative scenario....>>Create user API with no JWT Token
    * def Payload = 
"""
{
    "users": [
        {
            "userInfo": {
                "emailId": "testing11@zetmail.com"
            }
        }
 ]
}
"""
    
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]