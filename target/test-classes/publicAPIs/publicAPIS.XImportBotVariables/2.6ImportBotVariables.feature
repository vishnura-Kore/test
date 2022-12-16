@runtime
Feature: Import BotVariables using Json

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def JWTToken1 = JavaClass.get('JWTToken1')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def name = JavaMethods.generateRandom('number')
    * print SanitystreamId
    * def JWTToken1 = JavaClass.get('JWTToken1')

  Scenario: Positive Scenario -----------> Import BotVariables using Json
    * def Payload = read("uploadJSONFiles/GlobalVariableWithPrepolatedScope.json")
    Given url publicUrl
    Then path '/public/builder/stream/'+SanitystreamId+'/variables/import'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: Negative Scenario -----------> Import BotVariables using Json with invalid StreamId
    * def Payload = read("uploadJSONFiles/GlobalVariableWithPrepolatedScope.json")
    Given url publicUrl
    Then path '/public/builder/stream/'+SanitystreamId+name+'/variables/import'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario -----------> Import BotVariables using Json with No JWT Token
    * def Payload = read("uploadJSONFiles/GlobalVariableWithPrepolatedScope.json")
    Given url publicUrl
    Then path '/public/builder/stream/'+SanitystreamId+'/variables/import'
    And request Payload
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario -----------> Import BotVariables using Json with Wrong JWT Token
    * def Payload = read("uploadJSONFiles/GlobalVariableWithPrepolatedScope.json")
    Given url publicUrl
    Then path '/public/builder/stream/'+SanitystreamId+'/variables/import'
    And request Payload
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario -----------> Import BotVariables using Json with Wrong HTTP Method
    * def Payload = read("uploadJSONFiles/GlobalVariableWithPrepolatedScope.json")
    Given url publicUrl
    Then path '/public/builder/stream/'+SanitystreamId+'/variables/import'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 405
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]

  Scenario: Negative Scenario -----------> Import BotVariables using Json with Wrong body
    * def Payload = read("uploadJSONFiles/BotVariableswithemptyBody.json")
    Given url publicUrl
    Then path '/public/builder/stream/'+SanitystreamId+'/variables/import'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 500
    And match $.errors..msg == ["Internal Server Error"]
    And match $.errors..code == [500]
    
   
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    