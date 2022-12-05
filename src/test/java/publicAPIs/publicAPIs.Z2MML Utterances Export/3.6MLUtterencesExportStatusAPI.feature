Feature: MLUtterancesExportStatusAPI with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')

  Scenario: PositiveScenario....>>> MLUtterancesExportStatus API in CSV Format
    * def MlutterenceId = JavaClass.get('MlutterenceId')
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/mlexport/status'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'response is', response
    And match $..status == ["SUCCESS"]
    And match $..percentageComplete == [100]
    #And match response.downloadUrl contains "https://staging-bots.korebots.com/api/getMediaStream/market/"

  Scenario: PositiveScenario....>>> MLUtterancesExportStatus API in CSV Format
    * def MlutterenceId1 = JavaClass.get('MlutterenceId1')
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/mlexport/status'
    And param state = 'configured'
    And param type = 'json'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'response is', response
    And match $..status == ["SUCCESS"]
    And match $..percentageComplete == [100]
    #And match response.downloadUrl contains "https://staging-bots.korebots.com/api/getMediaStream/market/"

  Scenario: NegativeScenario....>>> MLUtterancesExportStatus API with invalid StreamId
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+name+'/mlexport/status'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'response is' , response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>>> MLUtterancesExportStatus API with invalid JWT Token
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/mlexport/status'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'response is' , response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>>> MLUtterancesExportStatus API with no JWT Token in header
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/mlexport/status'
    And param state = 'configured'
    And param type = 'csv'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'response is' , response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>>> MLUtterancesExportStatus API with Wrong HTTP Method
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/mlexport/status'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = BotBuilderJWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'response is' , response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
