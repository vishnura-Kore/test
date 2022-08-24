Feature: MLUtterancesExport with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId

  Scenario: PositiveScenario....>>> MLUtterancesExportAPI IN CSV Format
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/mlexport'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'response is' , response
    * def MlutterenceId = response._id
    * JavaClass.add('MlutterenceId',MlutterenceId);
    And match $..status == ["IN_PROGRESS"]
    And match $..jobType == ["ML_UTTERANCE"]
    And match $..action == ["EXPORT"]
    And match $..fileType == ["CSV"]
    * print MlutterenceId

  Scenario: PositiveScenario....>>> MLUtterancesExportAPI IN JSON Fomat
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/mlexport'
    And param state = 'configured'
    And param type = 'json'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'response is' , response
    * def MlutterenceId1 = response._id
    * JavaClass.add('MlutterenceId1',MlutterenceId1);
    And match $..status == ["IN_PROGRESS"]
    And match $..jobType == ["ML_UTTERANCE"]
    And match $..action == ["EXPORT"]
    And match $..fileType == ["JSON"]
    * print MlutterenceId1

  Scenario: NegativeScenario....>>> MLUtterancesExportAPI with invlaidStream Id
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+name+'/mlexport'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'response is' , response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>>> MLUtterancesExportAPI with Invalid JWT Token
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/mlexport'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'response is' , response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>>> MLUtterancesExportAPI with Wrong HTTP Method
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/mlexport'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 405
    And print 'response is' , response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]

  Scenario: NegativeScenario....>>> MLUtterancesExportAPI with no JWT Token in Header
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/mlexport'
    And param state = 'configured'
    And param type = 'csv'
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'response is' , response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>>> MLUtterancesExportAPI without Parameters in header
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/mlexport'
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'response is' , response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
