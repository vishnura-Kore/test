@runtime
Feature: Validating BATCHTESTING Detailed Summary

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
     * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    
    
    
      Scenario: Summary Details
       * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
     Given path '/stream/'+SanityBotStreamID+'/testsuitesummary/testcases'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
  And header AccountId = adminaccountID1
  And header bot-language = 'en'
    And request 
    """
   {

  "testRunId": "tr-94d96821-5c45-5817-b7f6-b4143ea3b44e" 
}
    """
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
    Scenario: BATCH_TESTING_TESTCASES_QUERY
     * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    Then path '/builder/streams/'+SanityBotStreamID+'/dockStatus'
   And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    * def name = 'BATCH_TESTING_TESTCASES_QUERY'
    * def FileId = response.find(x => x.action == name).fileId
    * print FileId
    * JavaClass.add('FileId', FileId)
  
    
    Scenario: BATCH_TESTING_TESTCASES_QUERY
   * def FileId = JavaClass.get('FileId')
    Then path '/attachment/file/'+FileId+'/readfile'
    And param useStream = 'false'
   And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header bot-language = 'en'
    When method get
    Then status 200
    And print responseTime
    And print response
   * def Utterence1 = response.summary[0].utterance
   * JavaClass.add('Utterence1', Utterence1)
   * print Utterence1
   * def logSequenceId = response.summary[0].logSequenceId
   * JavaClass.add('logSequenceId',logSequenceId)
   * print logSequenceId
    And match response.summary[0].matchedIntent[0] == "why is my account locked?"
    And match response.summary[0].expectedIntent[0] == "Why is my account locked?"
     * def Utterence2 = response.summary[8].utterance
   * JavaClass.add('Utterence2', Utterence2)
   * print Utterence2
   * def logSequenceId2 = response.summary[8].logSequenceId
   * JavaClass.add('logSequenceId2',logSequenceId2)
   * print logSequenceId2
    And match response.summary[8].matchedIntent[0] == "place order" 
    And match response.summary[8].expectedIntent[0] == "Place Order"
    
    
    
    
  Scenario: BATCH_TESTING_TESTCASES_QUERY
   * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
   * def logSequenceId = JavaClass.get('logSequenceId')
   * def Utterence1 = JavaClass.get('Utterence1')
    Then path '/builder/streams/'+SanityBotStreamID+'/analysis/detail/'+logSequenceId
   And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header bot-language = 'en'
    When method get
    Then status 200
    And print responseTime
    And print response
  And match response.input[0] == Utterence1
  And match response.NLAnalysis.faq.definitive[0].faqScore == 100
 
    
     Scenario: BATCH_TESTING_TESTCASES_QUERY
      * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
   * def logSequenceId2 = JavaClass.get('logSequenceId2')
   * def Utterence2 = JavaClass.get('Utterence2')
    Then path '/builder/streams/'+SanityBotStreamID+'/analysis/detail/'+logSequenceId2
   And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header bot-language = 'en'
    When method get
    Then status 200
    And print responseTime
    And print response
  And match response.input[0] == Utterence2
 
    
    
    
    