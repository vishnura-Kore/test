Feature: FAQ Training Status API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
     * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    
    Scenario: Positive Scenario FAQ Training Status API 
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/faqs/train/status'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
   And match $..message == ["success"]
   And match $..status == ["success"]
    
    
    Scenario: NegativeScenario....>>> FAQTraining Status API with invalid StreamId
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+name+'/faqs/train/status'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 400
    And print 'response is' , response
    And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]

  Scenario: NegativeScenario....>>> FAQTraining Status API with invalid JWT Token
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/faqs/train/status'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'response is' , response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>>> FAQTraining Status API with no JWT Token in header
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/faqs/train/status'
    And param state = 'configured'
    And param type = 'csv'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'response is' , response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>>> FAQTraining Status API with Wrong HTTP Method
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/faqs/train/status'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'response is' , response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]