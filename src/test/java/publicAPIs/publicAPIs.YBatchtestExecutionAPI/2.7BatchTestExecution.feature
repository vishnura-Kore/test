@runtime
Feature: BatchTest Execution with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId

  Scenario: Positive Scenario -----------> BatchTestSuite Executuion in published version
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    * def Payload = read("JSONUploadFiles/BatchtestExecutioninPublished.json")
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/Developer defined utterances/run'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def batchtestId = response.requestId
    * JavaClass.add('batchtestId',batchtestId)
    And match $..status == ['accepted']
    
  Scenario: Positive Scenario -----------> BatchTestSuite Executuion in published version Status API
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId = JavaClass.get('batchtestId')
    * print SanitystreamId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/Developer defined utterances/'+batchtestId+'/status'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'completed' || response.status == 'failed'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..status contains ["completed"]
    And match $..runType == ["published"]

  

  Scenario: Positive Scenario -----------> BatchTestSuite Executuion in developed version
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    * def Payload = read("JSONUploadFiles/BatchtestExecutioninDevelopmentmode.json")
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/Developer defined utterances/run'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def batchtestId1 = response.requestId
    * JavaClass.add('batchtestId1',batchtestId1)
    And match $..status == ['accepted']
    
    
    
    Scenario: Positive Scenario -----------> BatchTestSuite Executuion in developed version Status API
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId1 = JavaClass.get('batchtestId1')
    * print SanitystreamId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/Developer defined utterances/'+batchtestId1+'/status'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'completed' || response.status == 'failed'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..status contains ["completed"]
    And match $..runType == ["inDevelopment"]
    
    
    
  

Scenario: Negative Scenario -----------> BatchTestSuite Executuion in developed version using invalid StreamId
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    * def Payload = read("JSONUploadFiles/BatchtestExecutioninDevelopmentmode.json")
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/testsuite/Developer defined utterances/run'
    And request Payload
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]



Scenario: Negative  Scenario -----------> BatchTestSuite Executuion in developed version With no JWT Token
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    * def Payload = read("JSONUploadFiles/BatchtestExecutioninDevelopmentmode.json")
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/testsuite/Developer defined utterances/run'
    And request Payload
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]




Scenario: Negative  Scenario -----------> BatchTestSuite Executuion in developed version With Invalid JWT Token
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    * def Payload = read("JSONUploadFiles/BatchtestExecutioninDevelopmentmode.json")
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/testsuite/Developer defined utterances/run'
    And request Payload
     And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]




Scenario: Negative  Scenario -----------> BatchTestSuite Executuion in developed version With Wrong Http Method
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    * def Payload = read("JSONUploadFiles/batchtestWithNOdata.json")
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/testsuite/Developer defined utterances/run'
    And request Payload
     And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 405
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]



Scenario: Negative Scenario -----------> BatchTestSuite Executuion in developed version Status API with invalid StreamId
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId1 = JavaClass.get('batchtestId1')
    * print SanitystreamId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/testsuite/Developer defined utterances/'+batchtestId1+'/status'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    

Scenario: Negative Scenario -----------> BatchTestSuite Executuion in developed version Status API with invalid JWT Token
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId1 = JavaClass.get('batchtestId1')
    * print SanitystreamId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/Developer defined utterances/'+batchtestId1+'/status'
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]


Scenario: Negative Scenario -----------> BatchTestSuite Executuion in developed version Status API with No JWT Token
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId1 = JavaClass.get('batchtestId1')
    * print SanitystreamId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/Developer defined utterances/'+batchtestId1+'/status'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]


Scenario: Negative Scenario -----------> BatchTestSuite Executuion in developed version Status API with Wrong HTTP Method
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def batchtestId1 = JavaClass.get('batchtestId1')
    * print SanitystreamId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite/Developer defined utterances/'+batchtestId1+'/status'
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
     And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]













  #Scenario: Positive Scenario -----------> Get APi
    #* def SanitystreamId = JavaClass.get('SanitystreamId')
    #* print SanitystreamId
    #Given url publicUrl
    #Then path '/public/stream/'+SanitystreamId+'/testsuite'
    #And header auth = BotBuilderJWTToken
    #And header Content-Type = 'application/json'
    #When method get
    #Then status 200
    #And print 'Response is: ', response
    #* def idname1 = response.AllMlUtterances.name
    #* JavaClass.add('idname1',idname1)
#
  #Scenario: delete batch test suite
    #* def SanitystreamId = JavaClass.get('SanitystreamId')
    #* def batchtestId1 = JavaClass.get('batchtestId1')
    #* def idname1 = JavaClass.get('idname1')
    #Given path '/public/stream/'+SanitystreamId+'/testsuite/'+idname1+'/'+batchtestId1
    #And request
      #"""
      #{}
      #"""
    #And header auth = BotBuilderJWTToken
    #And header Content-Type = 'application/json'
    #And header x-http-method-override = 'delete'
    #When method post
    #Then status 200
    #And print 'Response is: ', response

  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
