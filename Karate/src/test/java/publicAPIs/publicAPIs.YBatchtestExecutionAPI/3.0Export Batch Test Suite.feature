Feature: Export Batch Test Suite API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    * def BatchTestName = JavaClass.get('BatchTestName')
    * print BatchTestName

  Scenario: Positive Scenario-------->Export Batch Test Suite API
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/'+BatchTestName+'/export'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..name == ["Batch Testing123"]

  Scenario: Negative Scenario-------->Export Batch Test Suite API with invalid StreamId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/testsuite/'+BatchTestName+'/export'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    

  Scenario: Negative Scenario-------->Export Batch Test Suite API with invalid JWT Token
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/'+BatchTestName+'/export'
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario-------->Export Batch Test Suite API with no JWT Token in header
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/'+BatchTestName+'/export'
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario-------->Export Batch Test Suite API with Wrong HTTP Method
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/'+BatchTestName+'/export'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 405
    And print 'Response is: ', response
     And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]

  Scenario: Negative Scenario-------->Export Batch Test Suite API with invalidTest Name
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/'+BatchTestName+name+'/export'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And print 'Response is: ', response
     And match $.errors..msg == ["Test Suite not found"]
    And match $.errors..code == [400]
