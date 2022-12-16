Feature: KG--Extraction from URL with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
     * def name = JavaMethods.generateRandom('number')
     * def KGID = JavaClass.get('KGID')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    
   
    Scenario: Positive Scenario Get Extractions History
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/history'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    
    
     Scenario: Negative Scenario Get Extractions History with wrong streamid
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/qna/history'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 400
    And print 'Response is: ', response
    
    
     Scenario: Negative Scenario Get Extractions History with wrong Http Method
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/qna/history'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
     And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
    
    
     Scenario: Negative Scenario Get Extractions History with wrong JWT Token
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/qna/history'
    And param language = 'en'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
     Scenario: Negative Scenario Get Extractions History with no JWT Token in header
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/qna/history'
    And param language = 'en'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    