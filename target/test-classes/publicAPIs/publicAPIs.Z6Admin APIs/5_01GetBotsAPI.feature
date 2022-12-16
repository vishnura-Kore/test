Feature: GetBots API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    

  Scenario: Positive Scenario --->> GetBots API 
    Given url publicUrl
    Then path '/public/bots'
    And param offset = '0'
    And param limit = '10'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    * def TotalBots = response.total
    Then print TotalBots
    * def number = 0 
    And match response.total != number
    
    
    
     Scenario: Negative Scenario --->> GetBots API 
    Given url publicUrl
    Then path '/public/bots'
    And param offset = '0'
    And param limit = '10'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
   And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
     Scenario: Negative Scenario --->> GetBots API 
    Given url publicUrl
    Then path '/public/bots'
    And param offset = '0'
    And param limit = '10'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
     Scenario: Negative Scenario --->> GetBots API 
    Given url publicUrl
    Then path '/public/bots'
    And param offset = '0'
    And param limit = '10'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
      And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
    