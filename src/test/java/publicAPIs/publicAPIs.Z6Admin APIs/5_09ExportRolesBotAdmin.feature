Feature: Export Roles API of admin  with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * url publicUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
     
  
  Scenario: Positive Scenario Export Roles API of admin
  Given url publicUrl
    Then path 'public/roles/export'
    And param roleType = 'admin'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    
    
    
     Scenario: Negative Scenario Export Roles API of admin with wrong JWT Token
  Given url publicUrl
    Then path 'public/roles/export'
    And param roleType = 'admin'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
     Scenario: Negative Scenario Export Roles API of admin with No JWT Token
  Given url publicUrl
    Then path 'public/roles/export'
    And param roleType = 'admin'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
      
     Scenario: Negative Scenario Export Roles API of admin with worng http method
    Given url publicUrl
    Then path 'public/roles/export'
    And param roleType = 'admin'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
      And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
      
    