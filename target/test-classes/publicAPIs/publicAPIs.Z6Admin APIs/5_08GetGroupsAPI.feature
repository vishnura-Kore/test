Feature: Get Groups API  with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * url publicUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
     
   
    

  Scenario: Positive Scenario Get Groups API
  Given url publicUrl
    Then path 'public/groups'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
   * def GroupId1 = response.groups[0]._id
   * def GroupID2 = response.groups[2]._id
   * JavaClass.add('GroupId1', GroupId1)
   * JavaClass.add('GroupID2', GroupID2)
   
    
    
    
  Scenario: Negative Scenario Get Groups API with wrong JWT Token
  Given url publicUrl
    Then path 'public/groups'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
  Scenario: Negative Scenario Get Groups API with no JWT Token 
  Given url publicUrl
    Then path 'public/groups'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
    
    
  Scenario: Negative Scenario Get Groups API with wrong http method
  Given url publicUrl
    Then path 'public/groups'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
     And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]