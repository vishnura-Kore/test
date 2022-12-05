Feature: Get KnowledgeTasks with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
   
    
 Scenario: Positive Scenario Get KnowledgeTasks
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/knowledgeTasks'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    * def KGTaskID = response[0]._id
    * def KGParentId = response[0].parentId
    * JavaClass.add('KGTaskID', KGTaskID)
    * JavaClass.add('KGParentId', KGParentId)
    * print KGTaskID
    * print KGParentId
  
    
    
    Scenario: Negative Scenario Get KnowledgeTasks with wrong StreamId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/knowledgeTasks'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 400
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]
    
     Scenario: Negative Scenario Get KnowledgeTasks with wrong JWT TOKEN
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/knowledgeTasks'
    And param language = 'en'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
        Scenario: Negative Scenario Get KnowledgeTasks with NO JWT TOKEN in header
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/knowledgeTasks'
    And param language = 'en'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
     Scenario: Negative Scenario Get KnowledgeTasks with wrong Http method
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/knowledgeTasks'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
      And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]