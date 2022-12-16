Feature: Export Roles API of bot  with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * url publicUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')

  Scenario: Positive Scenario Export Roles API of bot
    Given url publicUrl
    Then path 'public/roles/export'
    And param roleType = 'bot'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response

  Scenario: Positive Scenario Export Roles API of bot with wrong JWT token
    Given url publicUrl
    Then path 'public/roles/export'
    And param roleType = 'bot'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Positive Scenario Export Roles API of bot with no jwt token
    Given url publicUrl
    Then path 'public/roles/export'
    And param roleType = 'bot'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Positive Scenario Export Roles API of bot with wrong HTTP Method
    Given url publicUrl
    Then path 'public/roles/export'
    And param roleType = 'bot'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
