Feature: Update user API with Positive and Negative Scenarios

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
    * def GroupId1 = JavaClass.get('GroupId1')


  Scenario: PositiveScenario....>>Update user API 
    * def Payload = read("UpdateuserPayload.json")
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method put
    Then status 200
    And print 'Response is: ', response
    And match response.msg == "Users are updated Successfully"
    
    
     Scenario: PositiveScenario....>>Get user information API 
    * def Payload =
 """
 {
    "emailIds": [
        "karatetesting@zetmail.com"
    ]
}
      """
   
    Given url publicUrl
    Then path '/public/usersInfo'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..emailId == ["karatetesting@zetmail.com"]
     * def UserLastnameUpdate = response[0].userInfo.lastName
     * def UserFirstnameUpdte = response[0].userInfo.firstName
     And match response[0].userInfo.firstName != UserFirstname
    
    
  Scenario: Negative Scenario....>>Update user API  with wrong JWT Token
    * def Payload = read("UpdateuserPayload.json")
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method put
    Then status 401
    And print 'Response is: ', response
       And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
   
   
    Scenario: Negative Scenario....>>Update user API  with no JWT Token
    * def Payload = read("UpdateuserPayload.json")
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header Content-Type = 'application/json'
    When method put
    Then status 401
    And print 'Response is: ', response
       And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
      Scenario: Negative Scenario....>>Update user API  with Wrong HTTP METHOD
    * def Payload = read("UpdateuserPayload.json")
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header Content-Type = 'application/json'
    When method get
    Then status 405
    And print 'Response is: ', response
       And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]