@runtime
Feature: Publishing the bot using Public APIs With Positive and Negative Scenario

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def JWTToken1 = JavaClass.get('JWTToken1')
     * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def name = JavaMethods.generateRandom('number')
    * print SanitystreamId
    
    Scenario: Positive Scenario ----> publishing bot Status API
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/publish/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response 
    
    
    
    
     Scenario: Negative Scenario ----> publishing bot Status API with invalid StreamId
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+name+'/publish/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
   Then status 400
    And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]
   
    
     Scenario: Negative Scenario  ----------->  Publishing the bot Status API with invalid JWT Token
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/publish/status'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario  ----------->  Publish the bot Status API with No JWT Token
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/publish/status'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
    Scenario: Positive Scenario ----------->  Publishing  the bot Status API with Wrong HTTP Method
    Given url publicUrl
   Then path '/public/bot/'+SanitystreamId+'/publish/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method put
    Then status 405
    And print 'Response is: ', response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
    
    Scenario: Negative Scenario  ----------->  Publishing  the bot status API  with Wrong AppScopes
    Given url publicUrl
   Then path '/public/bot/'+SanitystreamId+'/publish/status'
    And header auth = JWTToken1
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And match $.errors..msg == ["Permission denied. Scope is incorrect!"]
    And match $.errors..code == [4002]
    
    