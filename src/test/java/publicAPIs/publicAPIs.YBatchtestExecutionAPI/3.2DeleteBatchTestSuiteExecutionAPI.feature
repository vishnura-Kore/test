Feature: DeleteBatchTestSuiteExecutionAPI with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    * def batchtestId = JavaClass.get('batchtestId')
    * print batchtestId

  Scenario: Positive Scenario---> DeleteBatchTestSuiteExecutionAPI
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId = JavaClass.get('batchtestId')
    Given path '/public/stream/'+SanitystreamId+'/testsuite/Developer defined utterances/'+batchtestId
    And request
      """
      {}
      """
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'delete'
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: Negative Scenario--->> DeleteBatchTestSuiteExecutionAPI with invalid StreamId
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId = JavaClass.get('batchtestId')
    Given path '/public/stream/'+SanitystreamId+name+'/testsuite/Developer defined utterances/'+batchtestId
    And request
      """
      {}
      """
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'delete'
    When method post
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    Scenario: Negative Scenario---> DeleteBatchTestSuiteExecutionAPI with invalid batchtestId
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId = JavaClass.get('batchtestId')
    Given path '/public/stream/'+SanitystreamId+'/testsuite/Developer defined utterances/'+batchtestId+name
    And request
      """
      {}
      """
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'delete'
    When method post
    Then status 400
    And print 'Response is: ', response
     And match $.errors..msg == ["Test Result not found."]
    And match $.errors..code == [400]
    
    
    
    
    Scenario: Negative Scenario--->> DeleteBatchTestSuiteExecutionAPI with invalid JWT Token
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId = JavaClass.get('batchtestId')
    Given path '/public/stream/'+SanitystreamId+name+'/testsuite/Developer defined utterances/'+batchtestId
    And request
      """
      {}
      """
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'delete'
    When method post
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
    Scenario: Negative Scenario--->> DeleteBatchTestSuiteExecutionAPI with no JWT Token in header
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId = JavaClass.get('batchtestId')
    Given path '/public/stream/'+SanitystreamId+name+'/testsuite/Developer defined utterances/'+batchtestId
    And request
      """
      {}
      """
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'delete'
    When method post
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    Scenario: Negative Scenario--->> DeleteBatchTestSuiteExecutionAPI with missing  in header
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId = JavaClass.get('batchtestId')
    Given path '/public/stream/'+SanitystreamId+name+'/testsuite/Developer defined utterances/'+batchtestId
    And request
      """
      {}
      """
     And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
      And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
    
    
    
     Scenario: Negative Scenario--->> DeleteBatchTestSuiteExecutionAPI with Wrong HTTP Method
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId = JavaClass.get('batchtestId')
    Given path '/public/stream/'+SanitystreamId+name+'/testsuite/Developer defined utterances/'+batchtestId
    And request
      """
      {}
      """
       And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'delete'
    When method get
    Then status 405
    And print 'Response is: ', response
     And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
    

 
  