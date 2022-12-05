Feature: GetRoleswithRoletypeBot API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
     * def BotDeveloperId = JavaClass.get('BotDeveloperId')
     * def BotTesterId = JavaClass.get('BotTesterId')
    
  
    

  Scenario: Positive Scenario GetRolesAPI with RoletypeBot
   Given url publicUrl
    Then path '/public/roles'
    And param roleType = 'bot'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    #And match response.roles[0]._id == BotDeveloperId
    #And match response.roles[1]._id == BotTesterId
   
    
    
    Scenario: Negative Scenario GetRolesAPI with RoletypeBot with wrong JWT token
     Given url publicUrl
    Then path '/public/roles'
    And param roleType = 'bot'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
      Scenario: Negative Scenario GetRolesAPI with RoletypeBot with no JWT token
       Given url publicUrl
    Then path '/public/roles'
    And param roleType = 'bot'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
      Scenario: Negative Scenario GetRolesAPI with RoletypeBot with wrong httpmethod
       Given url publicUrl
    Then path '/public/roles'
    And param roleType = 'bot'
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
     And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
    