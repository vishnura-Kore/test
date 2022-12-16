Feature: Find Intent API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def Botname = JavaClass.get('Botname')
    * print SanitystreamId
    * print Botname

  Scenario: Positive Scenario Find Intent API for published tasks
    * def Payload =
      """
         {
          "parentIntent": "Book Ticket",
          "input": "booking ticket171",
          "streamName": "PublicConsumerbot5300"
         }
      """
    * set Payload.streamName = Botname
    Given url publicUrl
    Then path '/v1.1/rest/bot/'+SanitystreamId+'/findIntent'
    And param fetchConfiguredTasks = 'false'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.response.intentStatus == "published"

  Scenario: Positive Scenario Find Intent API for configured tasks
    * def Payload =
      """
         {
          "parentIntent": "Book Ticket",
          "input": "booking ticket171",
          "streamName": "PublicConsumerbot5300"
         }
      """
    * set Payload.streamName = Botname
    Given url publicUrl
    Then path '/v1.1/rest/bot/'+SanitystreamId+'/findIntent'
    And param fetchConfiguredTasks = 'true'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.response.intentStatus == "configured"

  Scenario: negative Scenario Find Intent API with invalid StreamId
    * def Payload =
      """
         {
          "parentIntent": "Book Ticket",
          "input": "booking ticket171",
          "streamName": "PublicConsumerbot5300"
         }
      """
    * set Payload.streamName = Botname
    Given url publicUrl
    Then path '/v1.1/rest/bot/'+SanitystreamId+name+'/findIntent'
    And param fetchConfiguredTasks = 'true'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 400
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]

  Scenario: negative Scenario Find Intent API with invalid JWT TOKEN
    * def Payload =
      """
         {
          "parentIntent": "Book Ticket",
          "input": "booking ticket171",
          "streamName": "PublicConsumerbot5300"
         }
      """
    * set Payload.streamName = Botname
    Given url publicUrl
    Then path '/v1.1/rest/bot/'+SanitystreamId+'/findIntent'
    And param fetchConfiguredTasks = 'true'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: negative Scenario Find Intent API with no JWT TOKEN in header
    * def Payload =
      """
         {
          "parentIntent": "Book Ticket",
          "input": "booking ticket171",
          "streamName": "PublicConsumerbot5300"
         }
      """
    * set Payload.streamName = Botname
    Given url publicUrl
    Then path '/v1.1/rest/bot/'+SanitystreamId+'/findIntent'
    And param fetchConfiguredTasks = 'true'
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: negative Scenario Find Intent API with Wrong http method
    * def Payload =
      """
         {
          "parentIntent": "Book Ticket",
          "input": "booking ticket171",
          "streamName": "PublicConsumerbot5300"
         }
      """
    * set Payload.streamName = Botname
    Given url publicUrl
    Then path '/v1.1/rest/bot/'+SanitystreamId+'/findIntent'
    And param fetchConfiguredTasks = 'true'
    And header Content-Type = 'application/json'
    And header auth = JWTToken
    And request Payload
    When method get
    Then status 405
    And print 'Response is: ', response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]

  Scenario: negative Scenario Find Intent API with Wrong Body
    * def Payload =
      """
         {
          "parentIntent": "Book Ticket",
          "input": "booking ticket171",
         
         }
      """
    Given url publicUrl
    Then path '/v1.1/rest/bot/'+SanitystreamId+'/findIntent'
    And param fetchConfiguredTasks = 'true'
    And header Content-Type = 'application/json'
    And header auth = JWTToken
    And request Payload
    When method post
    Then status 400
    And print 'Response is: ', response
    And match $.errors..msg == ["Improper payload"]
    And match $.errors..code == [400]
