@runtime
Feature: Bot Export and Bot Export Status using Public API with Positve and Negative Scenarios

  Background: 
    * url publicUrl
    * print publicUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JWTToken1 = JavaClass.get('JWTToken1')
    * def PstreamId = JavaClass.get('PstreamId')
    * def JavaMethods = Java.type('data.commonJava')
    * print PstreamId

  Scenario: Positive Scenario ----> Full Bot Export in Published Version
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType" : "published"
      }

      """
    When method post
    Then status 200
    And print 'Response is: ', response
    * def ExportrequestId1 = response._id
    * JavaClass.add('ExportrequestId1',ExportrequestId1)
    * def id1 = JavaClass.get('ExportrequestId1')
    * print id1
    * print ExportrequestId1
    And match response.status == "pending"
    And match response.streamId == PstreamId
    And match response.exportType == "published"

  Scenario: Positive Scenario ---->Bot Export Status in Published Version
    * def ExportrequestId1 = JavaClass.get('ExportrequestId1')
    * print ExportrequestId1
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match response.status == "success"
    And match response.streamId == PstreamId
    And match response.exportType == "published"
    And match response._id == ExportrequestId1

  Scenario: Positive Scenario ----> Partial Bot Export with Only BotTasks in Published Version
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType": "published",
      "exportOptions": {
        "tasks": [
            "bottask","knowledgeGraph","smallTalk","forms"
            ]
      }
      }
      """
    When method post
    Then status 200
    And print 'Response is: ', response
    * def ExportrequestId2 = response._id
    * JavaClass.add('ExportrequestId2',ExportrequestId2)
    * print ExportrequestId2
    And match response.status == "pending"
    And match response.streamId == PstreamId
    And match response.exportType == "published"

  Scenario: Positive Scenario ----> Only BotTasks Export Status in Published Version
    Given url publicUrl
    * def ExportrequestId2 = JavaClass.get('ExportrequestId2')
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print 'Response is: ', response
    * print ExportrequestId2
    And match response.status == "success"
    And match response.streamId == PstreamId
    And match response.exportType == "published"
    And match response._id == ExportrequestId2

  Scenario: Positive Scenario ----> Partial  Bot export with Only NLPDATA in Published Version
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType" : "published",
      "exportOptions": {
      "nlpData": [
      "nlpSettings",
      "utterances",
      "patterns",
      "standardResponses"
      ]
      }
      
      }
      """
    When method post
    Then status 200
    And print 'Response is: ', response
    * def ExportrequestId3 = response._id
    * JavaClass.add('ExportrequestId3',ExportrequestId3)
    * print ExportrequestId3
    And match response.status == "pending"
    And match response.streamId == PstreamId
    And match response.exportType == "published"

  Scenario: Positive Scenario ----> Partial  Bot export  Status with Only NLPDATA in Published Version
    Given url publicUrl
    * def ExportrequestId3 = JavaClass.get('ExportrequestId3')
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print 'Response is: ', response
    * print ExportrequestId3
    And match response.status == "success"
    And match response.streamId == PstreamId
    And match response.exportType == "published"
    And match response._id == ExportrequestId3

  Scenario: Positive Scenario ----> Partial  bot Export with Only Settings in Published Version
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType" : "published",
      "exportOptions": {
        "settings": [
            "botSettings",
            "botVariables",
            "ivrSettings"
        ]
      }
      }
      """
    When method post
    Then status 200
    And print 'Response is: ', response
    * def ExportrequestId4 = response._id
    * JavaClass.add('ExportrequestId4',ExportrequestId4)
    * print ExportrequestId4
    And match response.status == "pending"
    And match response.streamId == PstreamId
    And match response.exportType == "published"

  Scenario: Positive Scenario ----> Partial bot Export Status with Only Settings in Published Version
    Given url publicUrl
    * def ExportrequestId4 = JavaClass.get('ExportrequestId4')
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print 'Response is: ', response
    * print ExportrequestId4
    And match response.status == "success"
    And match response.streamId == PstreamId
    And match response.exportType == "published"
    And match response._id == ExportrequestId4

  Scenario: Positive Scenario ----> Full  Bot Export in latest Version
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType" : "latest"
      }

      """
    When method post
    Then status 200
    And print 'Response is: ', response
    * def ExportrequestId5 = response._id
    * JavaClass.add('ExportrequestId5',ExportrequestId5)
    And match response.status == "pending"
    And match response.streamId == PstreamId
    And match response.exportType == "latest"

  Scenario: Positive Scenario ---->  Full Bot Export Status in latest Version
    Given url publicUrl
    * def ExportrequestId5 = JavaClass.get('ExportrequestId5')
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print 'Response is: ', response
    * print ExportrequestId5
    And match response.status == "success"
    And match response.streamId == PstreamId
    And match response.exportType == "latest"
    And match response._id == ExportrequestId5

  Scenario: Positive Scenario ----> Partial Bot Export with Only BotTasks in latest Version
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType": "latest",
      "exportOptions": {
        "tasks": [
            "bottask","knowledgeGraph","smallTalk","forms"
            ]
      }
      }
      """
    When method post
    Then status 200
    And print 'Response is: ', response
    * def ExportrequestId6 = response._id
    * JavaClass.add('ExportrequestId6',ExportrequestId6)
    * print ExportrequestId6
    And match response.status == "pending"
    And match response.streamId == PstreamId
    And match response.exportType == "latest"

  Scenario: Positive Scenario ---->   Partial Bot Export Status with Only BotTasks in latest Version
    Given url publicUrl
    * def ExportrequestId6 = JavaClass.get('ExportrequestId6')
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print 'Response is: ', response
    * print ExportrequestId6
    And match response.status == "success"
    And match response.streamId == PstreamId
    And match response.exportType == "latest"
    And match response._id == ExportrequestId6

  Scenario: Positive Scenario ----> Partial Bot Export withonly NLPDATA in latest Version
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType" : "latest",
      "exportOptions": {
      "nlpData": [
      "nlpSettings",
      "utterances",
      "patterns",
      "standardResponses"
      ]
      }
      
      }
      """
    When method post
    Then status 200
    And print 'Response is: ', response
    * def ExportrequestId7 = response._id
    * JavaClass.add('ExportrequestId7',ExportrequestId7)
    * print ExportrequestId7
    And match response.status == "pending"
    And match response.streamId == PstreamId
    And match response.exportType == "latest"

  Scenario: Positive Scenario ----> Partial Bot Export Status withonly NLPDATA in latest Version
    Given url publicUrl
    * def ExportrequestId7 = JavaClass.get('ExportrequestId7')
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print 'Response is: ', response
    * print ExportrequestId7
    And match response.status == "success"
    And match response.streamId == PstreamId
    And match response.exportType == "latest"
    And match response._id == ExportrequestId7

  Scenario: Positive Scenario ----> Partial Bot Export withonly Settings in latest Version
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType" : "latest",
      "exportOptions": {
        "settings": [
            "botSettings",
            "botVariables",
            "ivrSettings"
        ]
      }
      }
      """
    When method post
    Then status 200
    And print 'Response is: ', response
    * def ExportrequestId8 = response._id
    * JavaClass.add('ExportrequestId8',ExportrequestId8)
    * print ExportrequestId8
    And match response.status == "pending"
    And match response.streamId == PstreamId
    And match response.exportType == "latest"

  Scenario: Positive Scenario ----> Partial Bot Export Status withonly Settings in latest Version
    Given url publicUrl
    * def ExportrequestId8 = JavaClass.get('ExportrequestId8')
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And retry until response.status == 'success' || response.status == 'failure'
    When method get
    Then status 200
    And print 'Response is: ', response
    * print ExportrequestId8
    And match response.status == "success"
    And match response.streamId == PstreamId
    And match response.exportType == "latest"
    And match response._id == ExportrequestId8

  Scenario: Negative Scenario ----> Bot Export in Published Version using invalid Stream id
    * def name = JavaMethods.generateRandom('number')
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+name+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType" : "published"
      }

      """
    When method post
    Then status 400
    And print 'Response is: ', response
    * def ExportrequestId1 = response._id
    * JavaClass.add('ExportrequestId1',ExportrequestId1)
    And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]

  Scenario: Negative Scenario ----> Bot Export in Published Version with wrong body
    * def name = JavaMethods.generateRandom('number')
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "iporttt" : "published",,
      }
      """
    When method post
    Then status 412
    And print 'Response is: ', response
    * def ExportrequestId1 = response._id
    * JavaClass.add('ExportrequestId1',ExportrequestId1)
    And match $.errors..msg == ["Validation errors/ Invalid arguments"]
    And match $.errors..code == [412]

  Scenario: Negative Scenario ----> Bot Export in Published Version without Selecting any components
    * def name = JavaMethods.generateRandom('number')
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType": "published",
      "exportOptions": {
        "tasks": [
            
            ]
      }
      }
      """
    When method post
    Then status 400
    And print 'Response is: ', response
    * def ExportrequestId1 = response._id
    * JavaClass.add('ExportrequestId1',ExportrequestId1)
    And match $.errors..msg == ["Please select at least one component"]
    And match $.errors..code == [400]

  Scenario: Negative Scenario ----> Bot Export in Published Version using Invalid jwt
    * def name = JavaMethods.generateRandom('number')
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType" : "published"
      }

      """
    When method post
    Then status 401
    And print 'Response is: ', response
    * def ExportrequestId1 = response._id
    * JavaClass.add('ExportrequestId1',ExportrequestId1)
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Bot Export in Published Version using Wrong App Scopes
    * def name = JavaMethods.generateRandom('number')
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken1
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType" : "published"
      }

      """
    When method post
    Then status 401
    And print 'Response is: ', response
    * def ExportrequestId1 = response._id
    * JavaClass.add('ExportrequestId1',ExportrequestId1)
    And match $.errors..msg == ["Permission denied. Scope is incorrect!"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Bot Export in Published Version with no JWT Token
    * def name = JavaMethods.generateRandom('number')
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType" : "published"
      }

      """
    When method post
    Then status 401
    And print 'Response is: ', response
    * def ExportrequestId1 = response._id
    * JavaClass.add('ExportrequestId1',ExportrequestId1)
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Bot Export in Published Version with Wrong Http Method
    * def name = JavaMethods.generateRandom('number')
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request
      """
      {
      "exportType" : "published"
      }

      """
    When method get
    Then status 405
    And print 'Response is: ', response
    * def ExportrequestId1 = response._id
    * JavaClass.add('ExportrequestId1',ExportrequestId1)
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]

  Scenario: Negative Scenario ----> Bot Export Status in Published Version using invalid Stream id
    * def ExportrequestId1 = JavaClass.get('ExportrequestId1')
    * print ExportrequestId1
    * def name = JavaMethods.generateRandom('number')
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+name+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 400
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]

  Scenario: Negative Scenario ----> Bot Export Status in Published Version using Wrong AppScopes
    * def ExportrequestId1 = JavaClass.get('ExportrequestId1')
    * print ExportrequestId1
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken1
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Permission denied. Scope is incorrect!"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Bot Export Status in Published Version using Invalid JWT Token
    * def ExportrequestId1 = JavaClass.get('ExportrequestId1')
    * print ExportrequestId1
    * def name = JavaMethods.generateRandom('number')
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export/status'
   And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Bot Export Status in Published Version with no JWT Token
    * def ExportrequestId1 = JavaClass.get('ExportrequestId1')
    * print ExportrequestId1
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario ----> Bot Export Status in Published Version with wrong Http Method
    * def ExportrequestId1 = JavaClass.get('ExportrequestId1')
    * print ExportrequestId1
    Given url publicUrl
    Given path '/public/bot/'+PstreamId+'/export/status'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
