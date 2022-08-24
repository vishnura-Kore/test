Feature: Validating Small Talk Details

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
     * def streamId = JavaClass.get('streamId')
     * def smallTalkTotal = JavaClass.get('smallTalkTotal')
    * def smallTalkTPCount = JavaClass.get('smallTalkTPCount')
    * def smallTalkFPCount = JavaClass.get('smallTalkFPCount')
    * def smallTalkTestcasesCount = JavaClass.get('smallTalkTestcasesCount')
    * def smallTalkTestcasesCoveredCount = JavaClass.get('smallTalkTestcasesCoveredCount')
    * print smallTalkTestcasesCoveredCount

  Scenario: Testsuitesummary details
    Given path '/stream/'+streamId+'/testsuitesummary/details'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID1
    And header bot-language = 'en'
    And request
      """
      {
      "type": "smalltalk"
      }
      """
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: Small Talk Details
    Then path '/builder/streams/'+streamId+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    * def name1 = 'smalltalk'
    * def FileId = response.find(x => x.store.type == name1).fileId
    * print FileId
    * JavaClass.add('FileId', FileId)

  Scenario: Small Talk Details
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
    * def testcase7 = response.summary[6].data.testcases
    * def testcase8 = response.summary[7].data.testcases
    * def testcase9 = response.summary[8].data.testcases
    * def testcase10 = response.summary[9].data.testcases
    * def testcase11 = response.summary[10].data.testcases
    * def testcase12 = response.summary[11].data.testcases
    * def TotalTestCasesCovered = testcase1+testcase2+testcase3+testcase4+testcase5+testcase6+testcase7+testcase8+testcase9+testcase10+testcase11+testcase12
    * print TotalTestCasesCovered
      And string convert_num_to_string1 = TotalTestCasesCovered
    
    * def TotalTestCasesCovered = convert_num_to_string1
    And match TotalTestCasesCovered == smallTalkTestcasesCount
    # validating FP COUNT
    * def FP1 = response.summary[0].data.FP
    * def FP2 = response.summary[1].data.FP
    * def FP3 = response.summary[3].data.FP
    * def FP4 = response.summary[4].data.FP
    * def FP5 = response.summary[7].data.FP
    * def FP6 = response.summary[10].data.FP
    * def FP7 = response.summary[11].data.FP
    * def TotalFPCoveredCount = FP1+FP2+FP3+FP4+FP5+FP6+FP7
    * print TotalFPCoveredCount
     And string convert_num_to_string2 = TotalFPCoveredCount
    * def TotalFPCoveredCount = convert_num_to_string2
    And match TotalFPCoveredCount == smallTalkFPCount
    
    #Validating TP Count 
     * def TP1 = response.summary[1].data.TP
    * def TP2 = response.summary[2].data.TP
    * def TP3 = response.summary[5].data.TP
    * def TP4 = response.summary[6].data.TP
    * def TP5 = response.summary[8].data.TP
    * def TP6 = response.summary[9].data.TP
    * def TotalTPCoveredCount = TP1+TP2+TP3+TP4+TP5+TP6
    * print TotalTPCoveredCount
     And string convert_num_to_string3 = TotalTPCoveredCount
    * def TotalTPCoveredCount = convert_num_to_string3
    And match TotalTPCoveredCount == smallTalkTPCount
    
    
    
    
     #And match expectedAccuracyValue == faqaccuracy
    # ----------------- Getting Small Talk TF Values --------------------
    * def smalltalkTP = response.summary[1].data.TP
    * def smalltalkTN = response.summary[1].data.TN
    * def smalltalkFP = response.summary[1].data.FP
    * def smalltalkFN = response.summary[1].data.FN
    * print smalltalkTP
    * print smalltalkTN
    * print smalltalkFP
    * print smalltalkFN
    #Getting the Small Talk Scores
    * def smalltalkPrecision = response.summary[1].data.precision
    * def smalltalkRecall = response.summary[1].data.recall
    * def smalltalkF1 = response.summary[1].data.f1
    * def smalltalkaccuracy = response.summary[1].data.accuracy
    * print smalltalkPrecision
    * print smalltalkRecall
    * print smalltalkF1
    * print smalltalkaccuracy
    
    #Matching the Small Talk Scores
    #Precision
    * def precisionValue = smalltalkTP/(smalltalkTP+smalltalkFP)
    * print precisionValue
    * def expectedPrecision = Math.round(precisionValue*100)/100
    * print expectedPrecision
    And match expectedPrecision == smalltalkPrecision
    #Recall
    * def recallValue = smalltalkTP/(smalltalkTP+smalltalkFN)
    * def expectedrecall = Math.round(recallValue*100)/100
    * print expectedrecall
    And match expectedrecall == smalltalkRecall
    #F1
    * def F1Value = (2*smalltalkPrecision*smalltalkRecall)/(smalltalkPrecision+smalltalkRecall)
    * def expectedF1Value = Math.round(F1Value*100)/100
    And match expectedF1Value == smalltalkF1
    #Accuracy
    * def accuracyValue = (smalltalkTP+smalltalkTN)/(smalltalkTP+smalltalkTN+smalltalkFP+smalltalkFN)
    * def expectedAccuracyValue = Math.round(accuracyValue*100)/100
    And match expectedAccuracyValue == smalltalkaccuracy
    
