Feature: GetRoles with roletype ADMIN API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
     * def Custom1RoleId = JavaClass.get('Custom1RoleId')
     * def CustomAdmin1Id = JavaClass.get('CustomAdmin1Id')
    
   
    

  Scenario: Positive Scenario GetRoles with roletype ADMIN
  Given url publicUrl
    Then path '/public/roles'
    And param roleType = 'admin'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match response.roles[1]._id == Custom1RoleId
    And match response.roles[2]._id == CustomAdmin1Id
    
    Scenario: Negative Scenario GetRoles with roletype ADMIN with wrong JWT token
    Given url publicUrl
    Then path '/public/roles'
    And param roleType = 'admin'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
      Scenario: Negative Scenario GGetRoles with roletype ADMIN with no JWT token
      Given url publicUrl
    Then path '/public/roles'
    And param roleType = 'admin'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
     
      Scenario: Negative Scenario GGetRoles with roletype ADMIN with With wrong http method
      Given url publicUrl
    Then path '/public/roles'
    And param roleType = 'admin'
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
    