@R10.0
Feature: Bot import Status API  with positive and negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def JWTToken1 = JavaClass.get('JWTToken1')
     * def ConusmerBotIDBir = JavaClass.get('ConusmerBotIDBir')
  Scenario: Positive Scenario ----> Bot import status with all valid details
    Given url publicUrl
    Then path 'public/bot/import/status/'+ConusmerBotIDBir
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print response
    * def streamId = response.streamId
    * JavaClass.add('streamId', streamId)
    And match $..status contains ["success"]
    And match response._id == ConusmerBotIDBir
   
 

 