Feature: Get Extraction Question with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
     * def name = JavaMethods.generateRandom('number')
     * def KGID = JavaClass.get('KGID')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    * def KGID = JavaClass.get('KGID')
     * def WrongKGID = JavaClass.get('WrongKGID')
    
    
 Scenario: Positive Scenario Get Extraction Question
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/'+KGID+'/questions'
    And param limit = '='
    And param offset = '='
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    * def ConsumerBotQnId1 = response.extractions[0]._id
    * def ConsumerBotQn1 = response.extractions[0].question
    * def ConsumerBotAns1 = response.extractions[0].answer
    * JavaClass.add('ConsumerBotQnId1', ConsumerBotQnId1)
    * JavaClass.add('ConsumerBotQn1', ConsumerBotQn1)
    * JavaClass.add('ConsumerBotAns1', ConsumerBotAns1)
     And match $..qnaCount == [12]
    

 Scenario: Negative Scenario  Get Extraction Question with Wrong url id
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/'+WrongKGID+'/questions'
    And param limit = '='
    And param offset = '='
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 400
    And print 'Response is: ', response
     And match $.errors..msg == ["Could not find any questions"]
    And match $.errors..code == [400]
    
  
   Scenario: Negative Scenario Get Extraction Question with wrong streamid
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/qna/'+KGID+'/questions'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 400
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]
    
    
     Scenario: Negative Scenario Get Extraction Question with wrong Http Method
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/'+KGID+'/questions'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print 'Response is: ', response
     And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
    
    
     Scenario: Negative Scenario Get Extraction Question with wrong JWT Token
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/'+KGID+'/questions'
    And param language = 'en'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
     Scenario: Negative Scenario Get Extraction Question with no JWT Token in header
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/'+KGID+'/questions'
    And param language = 'en'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print 'Response is: ', response
      And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
      Scenario: Negative Scenario Get Extraction Question with wrong KGID
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/'+KGID+name+'/questions'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 400
    And print 'Response is: ', response
    And match $.errors..msg == ["resource not found"]
    