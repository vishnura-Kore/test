Feature: FAQ Training API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
     * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId

    Scenario: Positive Scenario FAQ Training API
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/faqs/train'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request 
    """
    {
    "language": "en"
}
    """
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $..message == ["in-progress"]
   And match $..status == ["in-progress"]
    
   
    * def sleep =
      """
      function(seconds){
        for(i = 0; i <= seconds; i++)
        {
          java.lang.Thread.sleep(1*5000);
          karate.log(i);
        }
      }
      """
* call sleep 10
    
   Scenario: NegativeScenario....>>> FAQ Training API with invlaidStream Id
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+name+'/faqs/train'
    And param state = 'configured'
    And param type = 'csv'
   And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And print 'response is' , response
    And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]

  Scenario: NegativeScenario....>>> FAQ Training API with Invalid JWT Token
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/faqs/train'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'response is' , response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>>> FAQ Training API with Wrong HTTP Method
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/faqs/train'
    And param state = 'configured'
    And param type = 'csv'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 405
    And print 'response is' , response
    And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]

  Scenario: NegativeScenario....>>> FAQ Training API with no JWT Token in Header
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/faqs/train'
    And param state = 'configured'
    And param type = 'csv'
    And header Content-Type = 'application/json'
    When method post
    Then status 401
    And print 'response is' , response
    And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]

  Scenario: NegativeScenario....>>> FAQ Training API without Parameters in header
    Given url publicUrl
    Given path '/public/bot/'+SanitystreamId+'/faqs/train'
   And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 412
    And print 'response is' , response
    And match $.errors..msg == ["Validation errors/ Invalid arguments"]
    And match $.errors..code == [412]
    
    
   