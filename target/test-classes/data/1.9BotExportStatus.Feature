@runtime12
Feature: Bot Export Status using Public API with Positve and Negative Scenarios
  Background: 
    * url publicUrl
    * print publicUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def PstreamId = JavaClass.get('PstreamId')
    * print PstreamId

Scenario: Positive Scenario ---->  Bot Export Status in Published Version
    Given url publicUrl
    * def ExportrequestId1 = JavaClass.get('ExportrequestId1')
    * print ExportrequestId1
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    * print ExportrequestId1
    And match response.status == "success"
    And match response.streamId == PstreamId
    And match response.exportType == "published"
    And match response._id == ExportrequestId1
    
    Scenario: Positive Scenario ----> Only BotTasks Export Status in Published Version
    Given url publicUrl
    * def ExportrequestId2 = JavaClass.get('ExportrequestId2')
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    * print ExportrequestId2
    And match response.status == "success"
    And match response.streamId == PstreamId
    And match response.exportType == "published"
    And match response._id == ExportrequestId2
    
      Scenario: Positive Scenario ----> Only NLP bot Export Status in Published Version
    Given url publicUrl
    * def ExportrequestId3 = JavaClass.get('ExportrequestId3')
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    * print ExportrequestId3
    And match response.status == "success"
    And match response.streamId == PstreamId
    And match response.exportType == "published"
    And match response._id == ExportrequestId3
    
    
     
    Scenario: Positive Scenario ----> Only Settings bot Export Status in Published Version
    Given url publicUrl
    * def ExportrequestId4 = JavaClass.get('ExportrequestId4')
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    * print ExportrequestId4
    And match response.status == "success"
    And match response.streamId == PstreamId
    And match response.exportType == "published"
    And match response._id == ExportrequestId4
    