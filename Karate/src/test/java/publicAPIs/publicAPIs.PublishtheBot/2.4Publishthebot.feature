@runtime
Feature: Publishing the bot using Public APIs With Positive and Negative Scenario

  Background: 
    * url appUrl
    * url jwturl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def JWTToken1 = JavaClass.get('JWTToken1')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def name = JavaMethods.generateRandom('number')
    * print SanitystreamId
    * def JWTToken1 = JavaClass.get('JWTToken1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    


  Scenario: Positive Scenario ----------->  Publishing  the bot with all valid details
    * def Payload = read("JSONUploadFiles/published.json")
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/publish'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: Negative Scenario  ----------->  Publish the bot with invalid streamId
    * def Payload = read("JSONUploadFiles/published.json")
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+name+'/publish'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]

  Scenario: Negative Scenario  ----------->  Publish the bot with invalid JWT Token
    * def Payload = read("JSONUploadFiles/published.json")
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/publish'
    And request Payload
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario  ----------->  Publish the bot with No JWT Token
    * def Payload = read("JSONUploadFiles/published.json")
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/publish'
    And request Payload
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario  ----------->  Publish the bot with Wrong AppScopes
    * def Payload = read("JSONUploadFiles/published.json")
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/publish'
    And request Payload
    And header auth = JWTToken1
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And match $.errors..msg == ["Permission denied. Scope is incorrect!"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario  ----------->  Publish the bot with No RequestBody
    * def Payload = read("JSONUploadFiles/publishedWithNoBody.json")
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/publish'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 412
    And match $.errors..msg == ["Validation errors/ Invalid arguments"]
    And match $.errors..code == [412]

  Scenario: Positive Scenario ----------->  Publishing  the bot with Wrong HTTP Method
    * def Payload = read("JSONUploadFiles/published.json")
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/publish'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 405
    And print 'Response is: ', response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
    
    
    
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
