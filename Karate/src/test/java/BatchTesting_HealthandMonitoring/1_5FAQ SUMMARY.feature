Feature: Validating FAQ SUMMARY


Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
     * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    * print SanityBotStreamID
    * def FAQTotalCount = JavaClass.get('FAQTotalCount')
    * def FAQTotalCovered = JavaClass.get('FAQTotalCovered')
    * def FaqTPcount = JavaClass.get('FaqTPcount')
    * def FaqFPcount = JavaClass.get('FaqFPcount')
     * def FAQTotalCount = JavaClass.get('FAQTotalCount')
    * print FAQTotalCount
    * print FAQTotalCovered
    * print FaqTPcount
    * print FaqFPcount
    
    
    
      Scenario: Testsuitesummary details
     Given path '/stream/'+SanityBotStreamID+'/testsuitesummary/details'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
  And header accountid = adminaccountID1
   And header bot-language = 'en'
    And request 
    """
 {
    "testRunId": "tr-94d96821-5c45-5817-b7f6-b4143ea3b44e",
    "runType": "inDevelopment",
    "type": "faq"
}
    """
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
    Scenario: FAQ SUMMARY
    Then path '/builder/streams/'+SanityBotStreamID+'/dockStatus'
   And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    * def name1 = 'BATCH_TESTING_DETAILS_QUERY'
    * def FileId = response.find(x => x.action == name1).fileId
    * print FileId
    * JavaClass.add('FileId', FileId)
   
    
    
    
    Scenario:  FAQ SUMMARY
   * def FileId = JavaClass.get('FileId')
    Then path '/attachment/file/'+FileId+'/readfile'
    And param useStream = 'false'
   And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    
      # Validating totaltestCase covered
    * def testcase1 = response.summary[0].data.testcases
    * def testcase2 = response.summary[1].data.testcases
    * def testcase3 = response.summary[2].data.testcases
    * def testcase4 = response.summary[3].data.testcases
    * def testcase5 = response.summary[4].data.testcases
    * def testcase6 = response.summary[5].data.testcases
    * def TotalTestCasesCovered = testcase1+testcase2+testcase3+testcase4+testcase5+testcase6
    * print TotalTestCasesCovered
     And string convert_num_to_string13 = TotalTestCasesCovered
    * def TotalTestCasesCovered = convert_num_to_string13
    And match TotalTestCasesCovered == FAQTotalCount
    
    
     # validating FP COUNT
    * def FP1 = response.summary[1].data.FP
    * def FP2 = response.summary[5].data.FP
    * def TotalFPCoveredCount = FP1+FP2
    * print TotalFPCoveredCount
     And string convert_num_to_string14 = TotalFPCoveredCount
    * def TotalFPCoveredCount = convert_num_to_string14
    And match TotalFPCoveredCount == FaqFPcount
    
    
     #Validating TP Count 
     * def TP1 = response.summary[0].data.TP
    * def TP2 = response.summary[2].data.TP
    * def TP3 = response.summary[3].data.TP
    * def TP4 = response.summary[4].data.TP
    * def TotalTPCoveredCount = TP1+TP2+TP3+TP4
    * print TotalTPCoveredCount
     And string convert_num_to_string33 = TotalTPCoveredCount
    * def TotalTPCoveredCount = convert_num_to_string33
    And match TotalTPCoveredCount == FaqTPcount
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    