Feature: Get user information API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
   

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
    * def UserLastname = response[0].userInfo.lastName
    * def UserFirstname = response[0].userInfo.firstName
      * JavaClass.add('UserFirstname', UserFirstname)
      * JavaClass.add('UserLastname', UserLastname)
      * print UserLastname
    
    
    
      Scenario: Negative SCENARIO....>>Get user information API with wrong JWT Token
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
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
       And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
  
       Scenario: Negative SCENARIO....>>Get user information API with no JWT Token
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
 And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
    
  Scenario: PositiveScenario....>>Get user information API with wrong email id
    * def Payload =
 """
 {
    "emailIds": [
        "Kore@123.com"
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
    
    And match $..status == [ "failure",400 ]
    And match $..msg == ["Invalid emailId"]
   
    
    
    
  #Scenario: PositiveScenario....>>Get user information API with orgid
    #* def Payload =
 #"""
 #{
    #"orgUserIds": [
        #"OrgUserID"
    #]
#}
      #"""
   #* set Payload.orgUserIds[0] = botadminUserID1
    #Given url publicUrl
    #Then path '/public/usersInfo'
    #And request Payload
    #And header auth = JWTToken
    #And header Content-Type = 'application/json'
    #When method post
    #Then status 200
    #And print 'Response is: ', response