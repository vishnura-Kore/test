Feature: Validating BATCH_TESTING_ DETAILS_QUERY

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
    * def IntentTestcasesCount = JavaClass.get('IntentTestcasesCount')
    * def IntentTotalCovered = JavaClass.get('IntentTotalCovered')
    * def IntentTPCount = JavaClass.get('IntentTPCount')
    * def IntentFPCount = JavaClass.get('IntentFPCount')
    * def IntentTestcasesCoveredCount = JavaClass.get('IntentTestcasesCoveredCount')
    * print IntentTestcasesCount
 * def testRunId = JavaClass.get('testRunId')

  Scenario: Testsuitesummary details
  * def Payload =
  """
      {
      "testRunId": "tr-94d96821-5c45-5817-b7f6-b4143ea3b44e",
      "runType": "inDevelopment",
      "type": "intent"
      }
      """
      * set Payload.testRunId = testRunId
    Given path '/stream/'+SanityBotStreamID+'/testsuitesummary/details'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID1
    And header bot-language = 'en'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: BATCH_TESTING_DETAILS_QUERY
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

  Scenario: BATCH_TESTING_DETAILS_QUERY
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
    And string convert_num_to_string38 = TotalTestCasesCovered
    * def TotalTestCasesCovered = convert_num_to_string38
    And match TotalTestCasesCovered == IntentTestcasesCount
    
    
    # validating FP COUNT
     * def IntentFPCount = JavaClass.get('IntentFPCount')
    * def FP1 = response.summary[0].data.FP
    * def FP2 = response.summary[4].data.FP
    * def TotalFPCovered = FP1+FP2
    * print TotalFPCovered
    And string convert_num_to_string39 = TotalFPCovered
    * def TotalFPCovered = convert_num_to_string39
    And match TotalFPCovered == IntentFPCount
   
   
    #Validating TP Count
    * def TP1 = response.summary[0].data.TP
    * def TP2 = response.summary[1].data.TP
    * def TP3 = response.summary[2].data.TP
    * def TP4 = response.summary[3].data.TP
    * def TP5 = response.summary[4].data.TP
    * def TP6 = response.summary[5].data.TP
    
    * def TotalTPCoveredCount = TP1+TP2+TP3+TP4+TP5+TP6
    * print TotalTPCoveredCount
    And string convert_num_to_string40 = TotalTPCoveredCount
    * def TotalTPCoveredCount = convert_num_to_string40
    And match TotalTPCoveredCount == IntentTPCount
