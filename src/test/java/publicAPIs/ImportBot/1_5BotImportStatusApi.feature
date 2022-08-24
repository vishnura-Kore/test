@runtime
Feature: Bot import Status API  with positive and negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def JWTToken1 = JavaClass.get('JWTToken1')

  Scenario: Positive Scenario ----> Bot import status with all valid details
    * def ConusmerBotIDBir = JavaClass.get('ConusmerBotIDBir')
    * print ConusmerBotIDBir
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print responseTime
    And print response
    * def PstreamId = response.streamId
    * JavaClass.add('PstreamId', PstreamId)
    * print PstreamId
    And match $..status contains ["success"]
    And match response._id == ConusmerBotIDBir

  Scenario: Negative Scenario ----> Bot import status with wrong BotImportBIR ID
    * def num = JavaMethods.generateRandom('number')
    * def ConusmerBotIDBir = JavaClass.get('ConusmerBotIDBir')
    * print ConusmerBotIDBir
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir+num
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 400
    And print response
    * match response.errors[0].msg == 'Invalid request ID'
    * match response.errors[0].code == 400
    And print 'Response is ', response

  #
  Scenario: Negative Scenario---->  Bot import status with no JWT TOKEN
    * def num = JavaMethods.generateRandom('number')
    * def ConusmerBotIDBir = JavaClass.get('ConusmerBotIDBir')
    * print ConusmerBotIDBir
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir+num
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print response
    * match response.errors[0].msg == 'Invalid SDK credentials'
    * match response.errors[0].code == 4002
    And print 'Response is ', response

  Scenario: Negative Scenario---->  Bot import status with invalid JWT TOKEN
    * def num = JavaMethods.generateRandom('number')
    * def ConusmerBotIDBir = JavaClass.get('ConusmerBotIDBir')
    * print ConusmerBotIDBir
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir+num
    And header auth = JWTToken+num
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print response
    * match response.errors[0].msg == 'Invalid SDK credentials'
    * match response.errors[0].code == 4002
    And print 'Response is ', response

  Scenario: Negative Scenario---->  Bot import status with wrong appscopes
    * def num = JavaMethods.generateRandom('number')
    * def ConusmerBotIDBir = JavaClass.get('ConusmerBotIDBir')
    * print ConusmerBotIDBir
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir+num
    And header auth = JWTToken1
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    * match response.errors[0].msg == 'Permission denied. Scope is incorrect!'
    * match response.errors[0].code == 4002
    And print 'Response is ', response

  Scenario: Negative Scenario---->  Bot import status with wrong Htpp method
    * def num = JavaMethods.generateRandom('number')
    * def ConusmerBotIDBir = JavaClass.get('ConusmerBotIDBir')
    * print ConusmerBotIDBir
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    * match response.errors[0].msg == 'Method Not Allowed'
    * match response.errors[0].code == 405
    And print 'Response is ', response
