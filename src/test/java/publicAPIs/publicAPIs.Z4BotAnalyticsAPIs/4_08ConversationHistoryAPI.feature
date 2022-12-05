Feature: Conversation History API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
     * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def Botname = JavaClass.get('Botname')
    * print SanitystreamId
    * print Botname

  Scenario: Positive Scenario Conversation History API 
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/getMessages'
    And param userId = botadminUserID1
    And param skip = '0'
    And param limit = '10'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
  
