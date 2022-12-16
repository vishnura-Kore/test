@runtime
Feature: Installing SampleBots using Public APIs with positive and negative scenarios

  Background: 
    * url appUrl
    * url publicUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def JavaMethods = Java.type('data.commonJava')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def userID1 = JavaClass.get('userID1')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JWTToken1 = JavaClass.get('JWTToken1')

  Scenario: Getting All Sample Bots Details
    Given path '/builder/samplebots'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    When method get
    Then status 200
    And print  'Response is ' , response
    * def StreamId = response[5].id
    * JavaClass.add('StreamId', StreamId)
    * def StreamId = JavaClass.get('StreamId')
    * print StreamId
    * def name = response[5].name
    * JavaClass.add('name', name)
    * def name = JavaClass.get('name')
    * print name
    And match $..name contains ["Airlines Travel Planning"]

  Scenario: Positive Scenario----> Installing Sample Bots
    * def name = JavaClass.get('name')
    * def StreamId = JavaClass.get('StreamId')
    Given url publicUrl
    Given path '/public/samplebots/'+StreamId+'/add'
    And header Host = '<calculated when request is sent>'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And header userId = userID1
    When method get
    Then status 200
    And print  'Response is ' , response
    And match $..originalName == ["Airlines Travel Planning"]

  Scenario: Negative Scenario----> Installing Sample Bots with wrong StreamId
    * def name = JavaMethods.generateRandom('number')
    * def StreamId = JavaClass.get('StreamId')
    Given url publicUrl
    Given path '/public/samplebots/'+StreamId+name+'/add'
    And header Host = '<calculated when request is sent>'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And header userId = userID1
    When method get
    Then status 400
    And print  'Response is ' , response
    And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]

  Scenario: Negative Scenario----> Installing Sample Bots with Wrong Http Method
    * def name = JavaMethods.generateRandom('number')
    * def StreamId = JavaClass.get('StreamId')
    Given url publicUrl
    Given path '/public/samplebots/'+StreamId+'/add'
    And header Host = '<calculated when request is sent>'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And header userId = userID1
    When method post
    Then status 405
    And print  'Response is ' , response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]

  Scenario: Negative Scenario----> Installing Sample Bots with Wrong AppScopes
    * def name = JavaMethods.generateRandom('number')
    * def StreamId = JavaClass.get('StreamId')
    Given url publicUrl
    Given path '/public/samplebots/'+StreamId+'/add'
    And header Host = '<calculated when request is sent>'
    And header auth = JWTToken1
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And header userId = userID1
    When method get
    Then status 401
    And print  'Response is ' , response
    And match $.errors..msg == ["Permission denied. Scope is incorrect!"]
    And match $.errors..code == [4002]

  Scenario: Negative Scenario----> Installing Sample Bots with no JWT TOKEN
    * def name = JavaMethods.generateRandom('number')
    * def StreamId = JavaClass.get('StreamId')
    Given url publicUrl
    Given path '/public/samplebots/'+StreamId+'/add'
    And header Host = '<calculated when request is sent>'
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And header userId = userID1
    When method get
    Then status 401
    And print  'Response is ' , response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
