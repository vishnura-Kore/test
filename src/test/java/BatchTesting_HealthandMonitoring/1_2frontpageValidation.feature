@runtime
Feature: validating summary Details

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')

  Scenario: Getting StreamID
    Then path '/users/'+botadminUserID1+'/builder/streams'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    * def name = 'BotHealthMonitoringValidation'
    * def SanityBotStreamID = response.find(x => x.name == name)._id
    * print SanityBotStreamID
    * JavaClass.add('SanityBotStreamID', SanityBotStreamID)
    * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    * print SanityBotStreamID
    
    
     Scenario: getting TestSuiteId
    * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    Given path '/stream/'+SanityBotStreamID+'/testsuite'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And param runType = 'inDevelopment'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print 'Response is: ', response
    * def TestSuiteId = response[0]._id
    * JavaClass.add('TestSuiteId', TestSuiteId)
    * print TestSuiteId
    
    
    
    Scenario: getting testRunId 
    * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
     * def TestSuiteId = JavaClass.get('TestSuiteId')
    Given path '/stream/'+SanityBotStreamID+'/testsuite/'+TestSuiteId+'/history'
    And param offset = '0'
    And param limit = '5'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And param runType = 'inDevelopment'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print 'Response is: ', response
     * def testRunId = response.results[0]._id
     * JavaClass.add('testRunId', testRunId)
     * print testRunId
    
    
 
  Scenario: Summary of testsuite
   * def testRunId = JavaClass.get('testRunId')
    * def SanityBotStreamID = JavaClass.get('SanityBotStreamID')
    Given path '/stream/'+SanityBotStreamID+'/testsuitesummary/runs/'+testRunId
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And param runType = 'inDevelopment'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print 'Response is: ', response
    
    
    # ---------- Getting Intent TF Values -----------------
    * def intentTP = response.summary.intent.TP
    * def intentTN = response.summary.intent.TN
    * def intentFP = response.summary.intent.FP
    * def intentFN = response.summary.intent.FN
    * print intentTP
    * print intentTN
    * print intentFP
    * print intentFN
    #Getting the Intent Scores
    * def intentPrecision = response.summary.intent.precision
    * def intentRecall = response.summary.intent.recall
    * def intentF1 = response.summary.intent.f1
    * def intentaccuracy = response.summary.intent.accuracy
    * print intentPrecision
    * print intentRecall
    * print intentF1
    * print intentaccuracy
    #Matching the Intent Scores
    #Precision
    * def precisionValue = intentTP/(intentTP+intentFP)
    * def expectedPrecision = Math.round(precisionValue*100)/100
    And match expectedPrecision == intentPrecision
    #Recall
    * def recallValue = intentTP/(intentTP+intentFN)
    * def expectedrecall = Math.round(recallValue*100)/100
    And match expectedrecall == intentRecall
    #F1
    * def F1Value = (2*intentPrecision*intentRecall)/(intentPrecision+intentRecall)
    * def expectedF1Value = Math.round(F1Value*100)/100
    And match expectedF1Value == intentF1
    #Accuracy
    * def accuracyValue = (intentTP+intentTN)/(intentTP+intentTN+intentFP+intentFN)
    * def expectedAccuracyValue = Math.round(accuracyValue*100)/100
    And match expectedAccuracyValue == intentaccuracy
    #----------------- Getting FAQ TF Values --------------------
    * def faqTP = response.summary.faq.TP
    * def faqTN = response.summary.faq.TN
    * def faqFP = response.summary.faq.FP
    * def faqFN = response.summary.faq.FN
    #Getting the FAQ Scores
    * def faqPrecision = response.summary.faq.precision
    * def faqRecall = response.summary.faq.recall
    * def faqF1 = response.summary.faq.f1
    * def faqaccuracy = response.summary.faq.accuracy
    #Matching the FAQ Scores
    #Precision
    * def precisionValue = faqTP/(faqTP+faqFP)
    * def expectedPrecision = Math.round(precisionValue*100)/100
    And match expectedPrecision == faqPrecision
    #Recall
    * def recallValue = faqTP/(faqTP+faqFN)
    * def expectedrecall = Math.round(recallValue*100)/100
    And match expectedrecall == faqRecall
    #F1
    * def F1Value = (2*faqPrecision*faqRecall)/(faqPrecision+faqRecall)
    * def expectedF1Value = Math.round(F1Value*10)/10
    #And match expectedF1Value == faqF1
    #Accuracy
    * def accuracyValue = (faqTP+faqTN)/(faqTP+faqTN+faqFP+faqFN)
    * def expectedAccuracyValue = Math.round(accuracyValue*100)/100
    #And match expectedAccuracyValue == faqaccuracy
    # ----------------- Getting Small Talk TF Values --------------------
    * def smalltalkTP = response.summary.smalltalk.TP
    * def smalltalkTN = response.summary.smalltalk.TN
    * def smalltalkFP = response.summary.smalltalk.FP
    * def smalltalkFN = response.summary.smalltalk.FN
    #Getting the Small Talk Scores
    * def smalltalkPrecision = response.summary.smalltalk.precision
    * def smalltalkRecall = response.summary.smalltalk.recall
    * def smalltalkF1 = response.summary.smalltalk.f1
    * def smalltalkaccuracy = response.summary.smalltalk.accuracy
    #Matching the Small Talk Scores
    #Precision
    * def precisionValue = smalltalkTP/(smalltalkTP+smalltalkFP)
    * def expectedPrecision = Math.round(precisionValue*100)/100
    And match expectedPrecision == smalltalkPrecision
    #Recall
    * def recallValue = smalltalkTP/(smalltalkTP+smalltalkFN)
    * def expectedrecall = Math.round(recallValue*100)/100
    And match expectedrecall == smalltalkRecall
    #F1
    * def F1Value = (2*smalltalkPrecision*smalltalkRecall)/(smalltalkPrecision+smalltalkRecall)
    * def expectedF1Value = Math.round(F1Value*10)/10
    And match expectedF1Value == smalltalkF1
    #Accuracy
    * def accuracyValue = (smalltalkTP+smalltalkTN)/(smalltalkTP+smalltalkTN+smalltalkFP+smalltalkFN)
    * def expectedAccuracyValue = Math.round(accuracyValue*100)/100
    And match expectedAccuracyValue == smalltalkaccuracy
    # ----------------- Getting Traits TF Values --------------------
    * def traitTP = response.summary.trait.TP
    * def traitTN = response.summary.trait.TN
    * def traitFP = response.summary.trait.FP
    * def traitFN = response.summary.trait.FN
    #Getting the Traits Scores
    * def traitPrecision = response.summary.trait.precision
    * def traitRecall = response.summary.trait.recall
    * def traitF1 = response.summary.trait.f1
    * def traitaccuracy = response.summary.trait.accuracy
    #Matching the Traits Scores
    #Precision
    * def precisionValue = traitTP/(traitTP+traitFP)
    * def expectedPrecision = Math.round(precisionValue*100)/100
    And match expectedPrecision == traitPrecision
    #Recall
    * def recallValue = traitTP/(traitTP+traitFN)
    * def expectedrecall = Math.round(recallValue*100)/100
    And match expectedrecall == traitRecall
    #F1
    * def F1Value = (2*traitPrecision*traitRecall)/(traitPrecision+traitRecall)
    * def expectedF1Value = Math.round(F1Value*100)/100
    And match expectedF1Value == traitF1
    #Accuracy
    * def accuracyValue = (traitTP+traitTN)/(traitTP+smalltalkTN+traitFP+traitFN)
    * def expectedAccuracyValue = Math.round(accuracyValue*100)/100
    And match expectedAccuracyValue == traitaccuracy
    
    
    # Validating   Dialog Intent Details Details 
    * def IntentTotal = response.summary.intent.total
    * def IntentTPCount = response.summary.intent.TP
    * def IntentFPCount = response.summary.intent.FP
    * def IntentTestcasesCount = response.summary.intent.testcases
    * def IntentTestcasesCoveredCount = response.summary.intent.covered
    * print IntentTestcasesCount
    And string convert_num_to_string19 = IntentTotal
    And string convert_num_to_string24 = IntentTPCount
    And string convert_num_to_string33 = IntentFPCount
    And string convert_num_to_string45 = IntentTestcasesCount
    And string convert_num_to_string56 = IntentTestcasesCoveredCount
    * def IntentFPCount = convert_num_to_string33
    * def IntentTotal = convert_num_to_string19
    * def IntentTPCount = convert_num_to_string24
    * def IntentTestcasesCount = convert_num_to_string45
    * def IntentTestcasesCoveredCount = convert_num_to_string56
    * JavaClass.add('IntentTPCount', IntentTPCount)
    * JavaClass.add('IntentFPCount', IntentFPCount)
    * JavaClass.add('IntentTotal', IntentTotal)
    * JavaClass.add('IntentTestcasesCount', IntentTestcasesCount)
    * JavaClass.add('IntentTestcasesCoveredCount', IntentTestcasesCoveredCount)
    
    
    
    
    
    
    
    # Validating  SmallTalk Details 
    * def smallTalkTotal = response.summary.smalltalk.total
    * def smallTalkTPCount = response.summary.smalltalk.TP
    * def smallTalkFPCount = response.summary.smalltalk.FP
    * def smallTalkTestcasesCount = response.summary.smalltalk.testcases
    * def smallTalkTestcasesCoveredCount = response.summary.smalltalk.covered
    * print smallTalkTestcasesCount
    * print smallTalkTotal
    And string convert_num_to_string1 = smallTalkTotal
    And string convert_num_to_string2 = smallTalkTPCount
    And string convert_num_to_string3 = smallTalkFPCount
    And string convert_num_to_string4 = smallTalkTestcasesCount
    And string convert_num_to_string5 = smallTalkTestcasesCoveredCount
    * def smallTalkFPCount = convert_num_to_string3
    * def smallTalkTotal = convert_num_to_string1
    * def smallTalkTPCount = convert_num_to_string2
    * def smallTalkTestcasesCount = convert_num_to_string4
    * def smallTalkTestcasesCoveredCount = convert_num_to_string5
    * JavaClass.add('smallTalkTPCount', smallTalkTPCount)
    * JavaClass.add('smallTalkFPCount', smallTalkFPCount)
    * JavaClass.add('smallTalkTotal', smallTalkTotal)
    * JavaClass.add('smallTalkTestcasesCount', smallTalkTestcasesCount)
    * JavaClass.add('smallTalkTestcasesCoveredCount', smallTalkTestcasesCoveredCount)
    
   # Validating  FAQ Details 
   * def FAQTotalTestCasesCount = response.summary.faq.testcases
   * def FAQTotalCount = response.summary.faq.total
   * def FAQTotalCovered = response.summary.faq.covered
   * def FaqTPcount = response.summary.faq.TP
   * def FaqFPcount = response.summary.faq.FP
    And string convert_num_to_string7 = FAQTotalTestCasesCount
    And string convert_num_to_string8 = FAQTotalCount
    And string convert_num_to_string9 = FAQTotalCovered
    And string convert_num_to_string10 = FaqTPcount
    And string convert_num_to_string11 = FaqFPcount
    * def FAQTotalTestCasesCount = convert_num_to_string7
    * def FAQTotalCount = convert_num_to_string8
    * def FAQTotalCovered = convert_num_to_string9
    * def FaqFPcount = convert_num_to_string11
    * def FaqTPcount = convert_num_to_string10
    * JavaClass.add('FAQTotalTestCasesCount', FAQTotalTestCasesCount)
    * JavaClass.add('FAQTotalCount', FAQTotalCount)
    * JavaClass.add('FaqTPcount', FaqTPcount)
    * JavaClass.add('FaqFPcount', FaqFPcount)
    * JavaClass.add('FAQTotalCovered', FAQTotalCovered)
    
 
   
       #Total Coverage
    * def intentTotal = response.summary.intent.total
    * def faqTotal = response.summary.faq.total
    * def intentCovered = response.summary.intent.covered
    * def faqCovered = response.summary.faq.covered
    * def smallTalkCovered = response.summary.smalltalk.covered
    * def actualTotalCoverage = response.summary.coverage
    * def totalCoverage = (intentCovered+faqCovered+smallTalkCovered)/(intentTotal+faqTotal+smallTalkTotal)
    * def totalCvrg = totalCoverage*100
    * def expectedtotalCoverage = Math.round(totalCvrg*100)/100
    #And match expectedtotalCoverage == actualTotalCoverage
