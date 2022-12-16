Feature: KG--Extraction from URL with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
     * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId

    Scenario: Positive Scenario KG--Extraction from URL
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/import'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request 
    """
   {
    "fileUrl": "https://www.icicibank.com/nri-banking/money_transfer/faq/m2i-rewards-program/loyalty-program.page",
    "name": "ConsumerBotKGFileExtraction From URL"
}
    """
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $.status == "success"
    * def KGID = response._id
    * JavaClass.add('KGID', KGID)
    
 
    
     Scenario: Negative Scenario KG--Extraction from Wrong URL
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/import'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request 
    """
   {
    "fileUrl": "what is a chatbot",
    "name": "ConsumerBotKGFileExtraction From URL"
}
    """
    When method post
    Then status 400
    And print 'Response is: ', response
    And match $.errors..msg == ["Please provide http:// in Url"]
    And match $.errors..code == [400]
   
    
      Scenario: Negative Scenario KG--Extraction from Wrong URL
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/import'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request 
    """
   {
    "fileUrl": "https://images.google.com/",
    "name": "Wrong url"
}
    """
    When method post
    Then status 200
    And print 'Response is: ', response
    * def WrongKGID = response._id
    * JavaClass.add('WrongKGID', WrongKGID)
   
    
    
    Scenario: Negative Scenario KG--Extraction from URL with wrong StreamId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/qna/import'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request 
    """
   {
    "fileUrl": "https://www.icicibank.com/nri-banking/money_transfer/faq/m2i-rewards-program/loyalty-program.page",
    "name": "ConsumerBotKGFileExtraction From URL"
}
    """
    When method post
    Then status 400
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]
  
  
  Scenario: Negative Scenario KG--Extraction from URL with wrong http Method
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/qna/import'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request 
    """
   {
    "fileUrl": "https://www.icicibank.com/nri-banking/money_transfer/faq/m2i-rewards-program/loyalty-program.page",
    "name": "ConsumerBotKGFileExtraction From URL"
}
    """
    When method get
    Then status 405
    And print 'Response is: ', response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
   
   
    
    
    Scenario: Negative Scenario KG--Extraction from URL with wrong JWT Token
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/qna/import'
    And param language = 'en'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    And request 
    """
   {
    "fileUrl": "https://www.icicibank.com/nri-banking/money_transfer/faq/m2i-rewards-program/loyalty-program.page",
    "name": "ConsumerBotKGFileExtraction From URL"
}
    """
    When method post
    Then status 401
    And print 'Response is: ', response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
     Scenario: Negative Scenario KG--Extraction from URL with no JWT Token in header
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+name+'/qna/import'
    And param language = 'en'
    And header Content-Type = 'application/json'
    And request 
    """
   {
    "fileUrl": "https://www.icicibank.com/nri-banking/money_transfer/faq/m2i-rewards-program/loyalty-program.page",
    "name": "ConsumerBotKGFileExtraction From URL"
}
    """
    When method post
    Then status 401
    And print 'Response is: ', response
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
   
    
    
    
    Scenario: Negative Scenario KG--Extraction from URL with same name in the body
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/qna/import'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request 
    """
   {
    "fileUrl": "https://www.icicibank.com/nri-banking/money_transfer/faq/m2i-rewards-program/loyalty-program.page",
    "name": "ConsumerBotKGFileExtraction From URL"
}
    """
    When method post
    Then status 400
    And print 'Response is: ', response
     And match $.errors..msg == ["Mentioned knowledge extraction name was duplicate"]
    And match $.errors..code == [400]
    
  
  