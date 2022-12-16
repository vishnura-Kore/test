Feature: Get User Roles Details API  with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * url publicUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
     
   
    

  Scenario: Positive Scenario Get User Roles Details API
  Given url publicUrl
    Then path 'public/alluserroles'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    
    
    Scenario: Negative Scenario Get User Roles Details API with wrong jwt token
  Given url publicUrl
    Then path 'public/alluserroles'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    Scenario: Negative Scenario Get User Roles Details API with no JWT token
  Given url publicUrl
    Then path 'public/alluserroles'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
    Scenario: Negative Scenario Get User Roles Details API with wrong HTTP Method
  Given url publicUrl
    Then path 'public/alluserroles'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
     And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]