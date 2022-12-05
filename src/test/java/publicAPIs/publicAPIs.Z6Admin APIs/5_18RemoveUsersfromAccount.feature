Feature: Remove user from account API with Positive and Negative Scenarios

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
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')

    
    
    Scenario: PositiveScenario....>> Remove user from account API 
    * def Payload = 
"""
{
     "deleteEmailIds":["testing11@zetmail.com"]
}
"""
    
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method delete
    Then status 200
    And print 'Response is: ', response
    And match response.msg == "Users are removed Successfully"
    
    
      Scenario: PositiveScenario....>> Remove user from account API 
    * def Payload = 
"""
{
     "deleteEmailIds":["karatetesting@zetmail.com"]
}
"""
    
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method delete
    Then status 200
    And print 'Response is: ', response
    And match response.msg == "Users are removed Successfully"
    
        
    Scenario: PositiveScenario....>>To check whether account is deleted or not
    
    Given path '/organization/'+botadminorgID1+'/usersEnrolled'
    And param accID = adminaccountID1
    And param sortBy = 'lName'
    And header authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..emailId !contains 'testing11@zetmail.com'
     And match $..emailId contains 'botdeveloper@zetmail.com'
     And match $..emailId !contains 'karatetesting@zetmail.com'
     
     
     
         
      Scenario: NegativeScenario....>> Remove user from account API with wrong JWT TOKEN
    * def Payload = 
"""
{
     "deleteEmailIds":["karatetesting@zetmail.com"]
}
"""
    
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method delete
    Then status 401
    And print 'Response is: ', response
     
     
           
      Scenario: NegativeScenario....>> Remove user from account API with no JWT TOKEN
    * def Payload = 
"""
{
     "deleteEmailIds":["karatetesting@zetmail.com"]
}
"""
    
    Given url publicUrl
    Then path '/public/users'
    And request Payload
    And header Content-Type = 'application/json'
    When method delete
    Then status 401
    And print 'Response is: ', response
     
  