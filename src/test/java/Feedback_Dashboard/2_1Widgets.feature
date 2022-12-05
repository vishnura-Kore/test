@R10.0
Feature: Enabling Webhook channel and creating app

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def streamId = JavaClass.get('streamId')
    * def accountId = JavaClass.get('accountID')
    * def accessToken = JavaClass.get('accessToken')
    * def userID = JavaClass.get('userId')
    * def feedbackNameNPS = JavaClass.get('feedbackNameNPS')
    * def feedbackNameCSAT = JavaClass.get('feedbackNameCSAT') 
    * def feedbackNameThumbs = JavaClass.get('feedbackNameThumbs') 
  
  Scenario: Validating the widgets data
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def streamId = JavaClass.get('streamId')
    * def pattern = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    * def getDate =
      """
      function() {
        var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
        var sdf = new SimpleDateFormat(pattern);
        var date = new java.util.Date();
        return sdf.format(date);
      } 
      """
    * def today = getDate()
    * def Appenddays = JavaMethods.getRequiredDate(7,'yyyy-MM-dd',"HH:mm:ss")
    * def decrease = JavaMethods.getdecrementdays(-7,'yyyy-MM-dd',"'T'HH:mm:ss.SSS'Z'")
    * def Threedays = JavaMethods.getdecrementdays(-3,'yyyy-MM-dd',"'T'HH:mm:ss.SSS'Z'")
    * def Oneday = JavaMethods.getdecrementdays(-1,'yyyy-MM-dd',"'T'HH:mm:ss.SSS'Z'")
    * def future = JavaMethods.ConvertDateFormat(Appenddays,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    * def SevenDays = JavaMethods.ConvertDateFormat(decrease,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    * def ThreedaysFilter = JavaMethods.ConvertDateFormat(Threedays,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    * def OnedaysFilter = JavaMethods.ConvertDateFormat(Oneday,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    * print today
    * print decrease
    * print Appenddays
    * print future
    * print SevenDays
    * print ThreedaysFilter
    * JavaClass.add('today', today )
    * JavaClass.add('ThreedaysFilter', ThreedaysFilter )
    
    Given path 'builder/streams/'+streamId+'/feedBack/widgets'
    * def Payload = read('WidgetsPayload.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.feedbackName = feedbackNameNPS
    And param mode = 'async'
    And header Content-Type = 'application/json'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    And method post
    Then status 200
    And print response
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('dockStatusID', response._id)
    
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
		* call sleep 5
		
		Scenario: Dock Status call to get the data
		* def dockStatusID = JavaClass.get('dockStatusID')
		* def feedbackNameNPS = JavaClass.get('feedbackNameNPS')
		* print dockStatusID
		Given path 'builder/streams/'+streamId+'/dockStatus'
		And header Authorization = 'bearer '+accessToken
		And method get
    Then status 200
    And print response
    
    * def name = 'FEEDBACK_WIDGET_API'
		* def id = response.find(x => x.jobType == name)._id
		* print id
    
    And match id == dockStatusID
    
    * def surveyType = response.find(x => x.jobType == name).response.filters.surveyType
    * def surveyName = response.find(x => x.jobType == name).response.filters.feedbackName
    * def feedbackcount = response.find(x => x.jobType == name).response.result.totalFeedback
    
    And match surveyType == 'NPS'
    And match surveyName == feedbackNameNPS
    And match feedbackcount == 3
    
    * def promotorCurrentCount = response.find(x => x.jobType == name).response.result.promoters.currentCount
    * def passiveCurrentCount = response.find(x => x.jobType == name).response.result.passives.currentCount
    * def detractorCurrentCount = response.find(x => x.jobType == name).response.result.detractors.currentCount
    
    And match promotorCurrentCount == 1
    And match passiveCurrentCount == 1
    And match detractorCurrentCount == 1
    
    * def promotorPreviousCount = response.find(x => x.jobType == name).response.result.promoters.previousCount
    * def passivePreviousCount = response.find(x => x.jobType == name).response.result.passives.previousCount
    * def detractorPreviousCount = response.find(x => x.jobType == name).response.result.detractors.previousCount
    
    And match promotorPreviousCount == 0
    And match passivePreviousCount == 0
    And match detractorPreviousCount == 0
    
    * def promotorDisplayName = response.find(x => x.jobType == name).response.result.promoters.displayName
    * def passiveDisplayName = response.find(x => x.jobType == name).response.result.passives.displayName
    * def detractorDisplayName = response.find(x => x.jobType == name).response.result.detractors.displayName
    
    And match promotorDisplayName == 'Promoters'
    And match passiveDisplayName == 'Passives'
    And match detractorDisplayName == 'Detractors'
    
    * def scoreRangePromotor = response.find(x => x.jobType == name).response.result.promoters.scoreRange
    * def scoreRangepassive = response.find(x => x.jobType == name).response.result.passives.scoreRange
    * def scoreRangedetractor = response.find(x => x.jobType == name).response.result.detractors.scoreRange
    
    And match scoreRangePromotor == '9-10'
    And match scoreRangepassive == '6-8'
    And match scoreRangedetractor == '0-5'
    
    * def promotorProTip = response.find(x => x.jobType == name).response.result.promoters.proTipValue
    * def passiveProTip = response.find(x => x.jobType == name).response.result.passives.proTipValue
    * def detractorProTip = response.find(x => x.jobType == name).response.result.detractors.proTipValue
    
    And match promotorProTip == 'The percentage and the number of respondents who responded with a score of 9 or above'
    And match passiveProTip == 'The percentage and the number of respondents who responded with a score of 6 - 8'
    And match detractorProTip == 'The percentage and the number of respondents who responded with a score of 0 - 5'
    
    
    Scenario: Validating the MeterScore widget data
    * def today = JavaClass.get('today')
    * def ThreedaysFilter = JavaClass.get('ThreedaysFilter')
    
    Given path 'builder/streams/'+streamId+'/feedBack/meterscores'
    * def Payload = read('MeterScoreWidget.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.feedbackName[0] = feedbackNameNPS
    * set Payload.filters.surveyType = 'NPS'
    And param mode = 'async'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    And method post
    Then status 200
    And print response
    
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('meterdockStatusID', response._id)
    
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
		* call sleep 5
		
		
		Scenario: Dock Status call to get the data
		* def meterdockStatusID = JavaClass.get('meterdockStatusID')
		* def feedbackNameNPS = JavaClass.get('feedbackNameNPS')
		* print meterdockStatusID
		Given path 'builder/streams/'+streamId+'/dockStatus'
		And header Authorization = 'bearer '+accessToken
		And method get
    Then status 200
    And print response
    
    * def meterwidgetname = 'FEEDBACK_METER_API'
		* def id = response.find(x => x.jobType == meterwidgetname)._id
		* print id
    
    And match id == meterdockStatusID
    
    * def surveyType = response.find(x => x.jobType == meterwidgetname).response.filters.surveyType
    * def surveyName = response.find(x => x.jobType == meterwidgetname).response.filters.feedbackName[0]
    * def feedbackcount = response.find(x => x.jobType == meterwidgetname).response.result.totalCount
    * def promotorCount = response.find(x => x.jobType == meterwidgetname).response.result.promoters
    * def detractorsCount = response.find(x => x.jobType == meterwidgetname).response.result.detractors
    * def feedbackProtipMeterChart = response.find(x => x.jobType == meterwidgetname).response.feedbackProtipMeterChart
    
    And match surveyType == 'NPS'
    And match surveyName == feedbackNameNPS
    And match feedbackcount == 3
    And match promotorCount == 1
    And match detractorsCount == 1
    And match feedbackProtipMeterChart == 'Subtracting the percentage of detractors from the percentage of promoters'
    
    
    Scenario: Validating the Barchart widget data
    * def today = JavaClass.get('today')
    * def ThreedaysFilter = JavaClass.get('ThreedaysFilter')
    
    Given path 'builder/streams/'+streamId+'/feedBack/barChart'
    * def Payload = read('MeterScoreWidget.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.feedbackName[0] = feedbackNameNPS
    * set Payload.filters.surveyType = 'NPS'
    And param mode = 'async'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    And method post
    Then status 200
    And print response
    
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('barchartdockStatusID', response._id)
    
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
		* call sleep 5
		
		Scenario: Dock Status call to get the data
		* def barchartdockStatusID = JavaClass.get('barchartdockStatusID')
		* def feedbackNameNPS = JavaClass.get('feedbackNameNPS')
		* print barchartdockStatusID
		
		Given path 'builder/streams/'+streamId+'/dockStatus'
		And header Authorization = 'bearer '+accessToken
		And method get
    Then status 200
    And print response
    
    * def barchartwidgetname = 'FEEDBACK_BARCHART_API'
		* def id = response.find(x => x.jobType == barchartwidgetname)._id
		* print id
    
    And match id == barchartdockStatusID
    
    * def surveyType = response.find(x => x.jobType == barchartwidgetname).response.filters.surveyType
    * def surveyName = response.find(x => x.jobType == barchartwidgetname).response.filters.feedbackName[0]
    * def feedbackcount = response.find(x => x.jobType == barchartwidgetname).response.result[3].totalCount
    * def promotorCount = response.find(x => x.jobType == barchartwidgetname).response.result[3].promoterCount
    * def passiveCountCount = response.find(x => x.jobType == barchartwidgetname).response.result[3].passiveCount
    * def detractorsCount = response.find(x => x.jobType == barchartwidgetname).response.result[3].detractorCount
    * def date = response.find(x => x.jobType == barchartwidgetname).response.result[3].date
    * def feedbackProtipBarChart = response.find(x => x.jobType == barchartwidgetname).response.feedbackProtipBarChart
    
    And match surveyType == 'NPS'
    And match surveyName == feedbackNameNPS
    And match feedbackcount == 3
    And match promotorCount == 1
    And match passiveCountCount == 1
    And match promotorCount == 1
    And match detractorsCount == 1
    And match feedbackProtipBarChart == 'The percentage of Promoters/Passives/Detractors and the number respondents over a time period'
    
    * def TrendChartfeedbackcount = response.find(x => x.jobType == barchartwidgetname).response.result[4].totalCount
    * def TrendChartpromotorCount = response.find(x => x.jobType == barchartwidgetname).response.result[4].promoterCount
    * def TrendChartpassiveCountCount = response.find(x => x.jobType == barchartwidgetname).response.result[4].passiveCount
    * def TrendChartdetractorsCount = response.find(x => x.jobType == barchartwidgetname).response.result[4].detractorCount
    * def TrendChartfeedbackProtipBarChart = response.find(x => x.jobType == barchartwidgetname).response.feedbackProtipTrendChart
    
    And match TrendChartfeedbackcount == 3
    And match TrendChartpromotorCount == 1
    And match TrendChartpassiveCountCount == 1
    And match TrendChartdetractorsCount == 1
    And match TrendChartfeedbackProtipBarChart == 'The total number of promoters over a time period'
    
    Scenario: Validating the userfeedback widget data
    * def today = JavaClass.get('today')
    * def ThreedaysFilter = JavaClass.get('ThreedaysFilter')
    
    Given path 'builder/streams/'+streamId+'/feedBack/userfeedback'
    * def Payload = read('MeterScoreWidget.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.feedbackName[0] = feedbackNameNPS
    * set Payload.filters.surveyType = 'NPS'
    And param mode = 'async'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    And method post
    Then status 200
    And print response
    
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('userfeedbackdockStatusID', response._id)
    
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
		* call sleep 5
		
		Scenario: Dock Status call to get the data
		* def userfeedbackdockStatusID = JavaClass.get('userfeedbackdockStatusID')
		* def feedbackNameNPS = JavaClass.get('feedbackNameNPS')
		* print userfeedbackdockStatusID
		
		Given path 'builder/streams/'+streamId+'/dockStatus'
		And header Authorization = 'bearer '+accessToken
		And method get
    Then status 200
    And print response
    
    * def userfeedbackwidgetname = 'FEEDBACK_USER_API'
		* def id = response.find(x => x.jobType == userfeedbackwidgetname)._id
		* print id
    
    And match id == userfeedbackdockStatusID
    
    * def surveyType = response.find(x => x.jobType == userfeedbackwidgetname).response.filters.surveyType
    * def surveyName = response.find(x => x.jobType == userfeedbackwidgetname).response.filters.feedbackName[0]
    
    * def botId = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].botId
    * def score = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].score
    * def channel = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].channel
    * def language = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].language
    * def surveyNameFeed = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].feedbackName
    * def feedbackMessage = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].feedbackMessage
    
    And match surveyType == 'NPS'
    And match surveyName == feedbackNameNPS
    And match botId == streamId
    And match score == 10
    And match channel == 'ivr'
    And match language == 'English'
    And match surveyNameFeed == feedbackNameNPS
    And match feedbackMessage == ''
    
    * def botId1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].botId
    * def score1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].score
    * def channel1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].channel
    * def language1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].language
    * def surveyNameFeed1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].feedbackName
    * def feedbackMessage1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].feedbackMessage
    
    And match botId1 == streamId
    And match score1 == 6
    And match channel1 == 'ivr'
    And match language1 == 'English'
    And match surveyNameFeed1 == feedbackNameNPS
    And match feedbackMessage1 == ''
    
    * def botId2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[2].botId
    * def score2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[2].score
    * def channel2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[2].channel
    * def language2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[2].language
    * def surveyNameFeed2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[2].feedbackName
    * def feedbackMessage2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[2].feedbackMessage
    
    And match botId2 == streamId
    And match score2 == 0
    And match channel2 == 'ivr'
    And match language2 == 'English'
    And match surveyNameFeed2 == feedbackNameNPS
    And match feedbackMessage2 == 'not up to the Mark'
    
    
    Scenario: Validating the CSAT widget data
    * def today = JavaClass.get('today')
    * def ThreedaysFilter = JavaClass.get('ThreedaysFilter')
    
    Given path 'builder/streams/'+streamId+'/feedBack/widgets'
    * def Payload = read('WidgetsPayload.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.surveyType = 'CSAT'
    * set Payload.filters.feedbackName = feedbackNameCSAT
    And param mode = 'async'
    And header Content-Type = 'application/json'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    And method post
    Then status 200
    And print response
    
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('CSATWidgetdockStatusID', response._id)
    
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
		* call sleep 5
		
		
		Scenario: Dock Status call to get the data
		* def CSATWidgetdockStatusID = JavaClass.get('CSATWidgetdockStatusID')
		* print CSATWidgetdockStatusID
		Given path 'builder/streams/'+streamId+'/dockStatus'
		And header Authorization = 'bearer '+accessToken
		And method get
    Then status 200
    And print response
    
    * def CSATwidgetname = 'FEEDBACK_WIDGET_API'
		* def id = response.find(x => x.jobType == CSATwidgetname)._id
		* print id
    
    And match id == CSATWidgetdockStatusID
    
    * def surveyType = response.find(x => x.jobType == CSATwidgetname).response.filters.surveyType
    * def surveyName = response.find(x => x.jobType == CSATwidgetname).response.filters.feedbackName
    * def totalFeedback = response.find(x => x.jobType == CSATwidgetname).response.result.totalFeedback
    * def currentCount = response.find(x => x.jobType == CSATwidgetname).response.result.verySatisfied.currentCount
    * def previousCount = response.find(x => x.jobType == CSATwidgetname).response.result.verySatisfied.previousCount
    * def displayName = response.find(x => x.jobType == CSATwidgetname).response.result.verySatisfied.displayName
    * def scoreRange = response.find(x => x.jobType == CSATwidgetname).response.result.verySatisfied.scoreRange
    * def proTipValue = response.find(x => x.jobType == CSATwidgetname).response.result.verySatisfied.proTipValue
    
    And match surveyType == 'CSAT'
    And match surveyName == feedbackNameCSAT
    And match totalFeedback == 5
    And match currentCount == 1
    And match previousCount == 0
    And match displayName == 'Very Satisfied'
    And match scoreRange == '5'
    And match proTipValue == 'The percentage and the number of respondents who responded with a score of 5'
    
    * def currentCount = response.find(x => x.jobType == CSATwidgetname).response.result.satisfied.currentCount
    * def previousCount = response.find(x => x.jobType == CSATwidgetname).response.result.satisfied.previousCount
    * def displayName = response.find(x => x.jobType == CSATwidgetname).response.result.satisfied.displayName
    * def scoreRange = response.find(x => x.jobType == CSATwidgetname).response.result.satisfied.scoreRange
    * def proTipValue = response.find(x => x.jobType == CSATwidgetname).response.result.satisfied.proTipValue
    
    And match currentCount == 1
    And match previousCount == 0
    And match displayName == 'Satisfied'
    And match scoreRange == '4'
    And match proTipValue == 'The percentage and the number of respondents who responded with a score of 4'
    
    * def currentCount = response.find(x => x.jobType == CSATwidgetname).response.result.neutral.currentCount
    * def previousCount = response.find(x => x.jobType == CSATwidgetname).response.result.neutral.previousCount
    * def displayName = response.find(x => x.jobType == CSATwidgetname).response.result.neutral.displayName
    * def scoreRange = response.find(x => x.jobType == CSATwidgetname).response.result.neutral.scoreRange
    * def proTipValue = response.find(x => x.jobType == CSATwidgetname).response.result.neutral.proTipValue
    
    And match currentCount == 1
    And match previousCount == 0
    And match displayName == 'Neutral'
    And match scoreRange == '3'
    And match proTipValue == 'The percentage and the number of respondents who responded with a score of 3'
    
    * def currentCount = response.find(x => x.jobType == CSATwidgetname).response.result.unSatisfied.currentCount
    * def previousCount = response.find(x => x.jobType == CSATwidgetname).response.result.unSatisfied.previousCount
    * def displayName = response.find(x => x.jobType == CSATwidgetname).response.result.unSatisfied.displayName
    * def scoreRange = response.find(x => x.jobType == CSATwidgetname).response.result.unSatisfied.scoreRange
    * def proTipValue = response.find(x => x.jobType == CSATwidgetname).response.result.unSatisfied.proTipValue
    
    And match currentCount == 1
    And match previousCount == 0
    And match displayName == 'Unsatisfied'
    And match scoreRange == '2'
    And match proTipValue == 'The percentage and the number of respondents who responded with a score of 2'
    
    * def currentCount = response.find(x => x.jobType == CSATwidgetname).response.result.veryUnsatisfied.currentCount
    * def previousCount = response.find(x => x.jobType == CSATwidgetname).response.result.veryUnsatisfied.previousCount
    * def displayName = response.find(x => x.jobType == CSATwidgetname).response.result.veryUnsatisfied.displayName
    * def scoreRange = response.find(x => x.jobType == CSATwidgetname).response.result.veryUnsatisfied.scoreRange
    * def proTipValue = response.find(x => x.jobType == CSATwidgetname).response.result.veryUnsatisfied.proTipValue
    
    And match currentCount == 1
    And match previousCount == 0
    And match displayName == 'Very Unsatisfied'
    And match scoreRange == '1'
    And match proTipValue == 'The percentage and the number of respondents who responded with a score of 1'
    
    
    Scenario: Validating the CSAT MeterScore widget data
    * def today = JavaClass.get('today')
    * def ThreedaysFilter = JavaClass.get('ThreedaysFilter')
    
    Given path 'builder/streams/'+streamId+'/feedBack/meterscores'
    * def Payload = read('MeterScoreWidget.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.feedbackName[0] = feedbackNameCSAT
    * set Payload.filters.surveyType = 'CSAT'
    And param mode = 'async'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    And method post
    Then status 200
    And print response
    
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('meterdockStatusID', response._id)
    
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
		* call sleep 5
		
		Scenario: Dock Status call to get the data
		* def meterdockStatusID = JavaClass.get('meterdockStatusID')
		* print meterdockStatusID
		Given path 'builder/streams/'+streamId+'/dockStatus'
		And header Authorization = 'bearer '+accessToken
		And method get
    Then status 200
    And print response
    
    * def CSATwidgetname = 'FEEDBACK_METER_API'
		* def id = response.find(x => x.jobType == CSATwidgetname)._id
		* print id
    
    And match id == meterdockStatusID
    
    * def surveyType = response.find(x => x.jobType == CSATwidgetname).response.filters.surveyType
    * def surveyName = response.find(x => x.jobType == CSATwidgetname).response.filters.feedbackName[0]
    * def totalCount = response.find(x => x.jobType == CSATwidgetname).response.result.totalCount
    * def verySatisfied = response.find(x => x.jobType == CSATwidgetname).response.result.verySatisfied
    * def satisfied = response.find(x => x.jobType == CSATwidgetname).response.result.satisfied
    * def feedbackProtipMeterChart = response.find(x => x.jobType == CSATwidgetname).response.feedbackProtipMeterChart
    
    And match surveyType == 'CSAT'
    And match surveyName == feedbackNameCSAT
    And match totalCount == 5
    And match verySatisfied == 1
    And match satisfied == 1
    And match feedbackProtipMeterChart == 'The percentage of No of satisfied customer (both very satisfied and satisfied) against total number of respondents)'
    
    
    Scenario: Validating the CSAT Barchart widget data
    * def today = JavaClass.get('today')
    * def ThreedaysFilter = JavaClass.get('ThreedaysFilter')
    
    Given path 'builder/streams/'+streamId+'/feedBack/barChart'
    * def Payload = read('MeterScoreWidget.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.feedbackName[0] = feedbackNameCSAT
    * set Payload.filters.surveyType = 'CSAT'
    And param mode = 'async'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    And method post
    Then status 200
    And print response
    
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('barchartdockStatusID', response._id)
    
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
		* call sleep 5
		
		Scenario: Dock Status call to get the data
		* def barchartdockStatusID = JavaClass.get('barchartdockStatusID')
		* print barchartdockStatusID
		Given path 'builder/streams/'+streamId+'/dockStatus'
		And header Authorization = 'bearer '+accessToken
		And method get
    Then status 200
    And print response
    
    * def CSATwidgetname = 'FEEDBACK_BARCHART_API'
		* def id = response.find(x => x.jobType == CSATwidgetname)._id
		* print id
		
		* def surveyType = response.find(x => x.jobType == CSATwidgetname).response.filters.surveyType
    * def surveyName = response.find(x => x.jobType == CSATwidgetname).response.filters.feedbackName[0]
    * def totalCount = response.find(x => x.jobType == CSATwidgetname).response.result[3].totalCount
    * def verySatisfied = response.find(x => x.jobType == CSATwidgetname).response.result[3].verySatisfied
    * def satisfied = response.find(x => x.jobType == CSATwidgetname).response.result[3].satisfied
    * def neutral = response.find(x => x.jobType == CSATwidgetname).response.result[3].neutral
    * def unSatisfied = response.find(x => x.jobType == CSATwidgetname).response.result[3].unSatisfied
    * def veryUnsatisfied = response.find(x => x.jobType == CSATwidgetname).response.result[3].veryUnsatisfied
    * def feedbackProtipBarChart = response.find(x => x.jobType == CSATwidgetname).response.feedbackProtipBarChart
    
    And match surveyType == 'CSAT'
    And match surveyName == feedbackNameCSAT
    And match totalCount == 5
    And match verySatisfied == 1
    And match satisfied == 1
    And match neutral == 1
    And match unSatisfied == 1
    And match veryUnsatisfied == 1
    And match feedbackProtipBarChart == 'The percentage of Very Satisfied/Satisfied/Neutral/Unsatisfied/Very Unsatisfied and the number respondents over a time period'
    
    * def TrendCharttotalCount = response.find(x => x.jobType == CSATwidgetname).response.result[4].totalCount
    * def TrendChartverySatisfied = response.find(x => x.jobType == CSATwidgetname).response.result[4].verySatisfied
    * def TrendChartsatisfied = response.find(x => x.jobType == CSATwidgetname).response.result[4].satisfied
    * def TrendChartneutral = response.find(x => x.jobType == CSATwidgetname).response.result[4].neutral
    * def TrendChartunSatisfied = response.find(x => x.jobType == CSATwidgetname).response.result[4].unSatisfied
    * def TrendChartveryUnsatisfied = response.find(x => x.jobType == CSATwidgetname).response.result[4].veryUnsatisfied
    * def TrendChartfeedbackProtipTrendChart = response.find(x => x.jobType == CSATwidgetname).response.feedbackProtipTrendChart
    
    And match TrendCharttotalCount == 5
    And match TrendChartverySatisfied == 1
    And match TrendChartsatisfied == 1
    And match TrendChartneutral == 1
    And match TrendChartunSatisfied == 1
    And match TrendChartveryUnsatisfied == 1
    And match TrendChartfeedbackProtipTrendChart == 'The total number of very satisfied and satisfied users over a time period'
    
    Scenario: Validating the CSAT userfeedback widget data
    * def today = JavaClass.get('today')
    * def ThreedaysFilter = JavaClass.get('ThreedaysFilter')
    
    Given path 'builder/streams/'+streamId+'/feedBack/userfeedback'
    * def Payload = read('MeterScoreWidget.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.feedbackName[0] = feedbackNameCSAT
    * set Payload.filters.surveyType = 'CSAT'
    And param mode = 'async'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    And method post
    Then status 200
    And print response
    
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('userfeedbackdockStatusID', response._id)
    
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
		* call sleep 5
		
		Scenario: Dock Status call to get the data
		* def userfeedbackdockStatusID = JavaClass.get('userfeedbackdockStatusID')
		* print userfeedbackdockStatusID
		
		Given path 'builder/streams/'+streamId+'/dockStatus'
		And header Authorization = 'bearer '+accessToken
		And method get
    Then status 200
    And print response
    
    * def userfeedbackwidgetname = 'FEEDBACK_USER_API'
		* def id = response.find(x => x.jobType == userfeedbackwidgetname)._id
		* print id
    
    And match id == userfeedbackdockStatusID
        
    * def surveyType = response.find(x => x.jobType == userfeedbackwidgetname).response.filters.surveyType
    * def surveyName = response.find(x => x.jobType == userfeedbackwidgetname).response.filters.feedbackName[0]
    
    * def botId = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].botId
    * def score = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].score
    * def channel = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].channel
    * def language = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].language
    * def surveyNameFeed = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].feedbackName
    * def feedbackMessage = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].feedbackMessage
    
    And match surveyType == 'CSAT'
    And match surveyName == feedbackNameCSAT
    And match botId == streamId
    And match score == 5
    And match channel == 'ivr'
    And match language == 'English'
    And match surveyNameFeed == feedbackNameCSAT
    And match feedbackMessage == ''
    
    * def botId1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].botId
    * def score1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].score
    * def channel1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].channel
    * def language1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].language
    * def surveyNameFeed1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].feedbackName
    * def feedbackMessage1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].feedbackMessage
    
    And match botId1 == streamId
    And match score1 == 4
    And match channel1 == 'ivr'
    And match language1 == 'English'
    And match surveyNameFeed1 == feedbackNameCSAT
    And match feedbackMessage1 == ''
    
    * def botId2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[2].botId
    * def score2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[2].score
    * def channel2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[2].channel
    * def language2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[2].language
    * def surveyNameFeed2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[2].feedbackName
    * def feedbackMessage2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[2].feedbackMessage
    
    And match botId2 == streamId
    And match score2 == 3
    And match channel2 == 'ivr'
    And match language2 == 'English'
    And match surveyNameFeed2 == feedbackNameCSAT
    And match feedbackMessage2 == ''
    
    * def botId2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[3].botId
    * def score2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[3].score
    * def channel2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[3].channel
    * def language2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[3].language
    * def surveyNameFeed2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[3].feedbackName
    * def feedbackMessage2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[3].feedbackMessage
    
    And match botId2 == streamId
    And match score2 == 2
    And match channel2 == 'ivr'
    And match language2 == 'English'
    And match surveyNameFeed2 == feedbackNameCSAT
    And match feedbackMessage2 == 'not up to the Mark'
    
    * def botId2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[4].botId
    * def score2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[4].score
    * def channel2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[4].channel
    * def language2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[4].language
    * def surveyNameFeed2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[4].feedbackName
    * def feedbackMessage2 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[4].feedbackMessage
    
    And match botId2 == streamId
    And match score2 == 1
    And match channel2 == 'ivr'
    And match language2 == 'English'
    And match surveyNameFeed2 == feedbackNameCSAT
    And match feedbackMessage2 == 'not up to the Mark'
    
    
    Scenario: Validating the Thumbs widget data
    * def today = JavaClass.get('today')
    * def ThreedaysFilter = JavaClass.get('ThreedaysFilter')
    
    Given path 'builder/streams/'+streamId+'/feedBack/widgets'
    * def Payload = read('WidgetsPayload.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.surveyType = 'THUMB'
    * set Payload.filters.feedbackName = feedbackNameThumbs
    And param mode = 'async'
    And header Content-Type = 'application/json'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    And method post
    Then status 200
    And print response
    
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('THUMBWidgetdockStatusID', response._id)
    
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
		* call sleep 5
		
		
		Scenario: Dock Status call to get the data
		* def THUMBWidgetdockStatusID = JavaClass.get('THUMBWidgetdockStatusID')
		* print THUMBWidgetdockStatusID
		Given path 'builder/streams/'+streamId+'/dockStatus'
		And header Authorization = 'bearer '+accessToken
		And method get
    Then status 200
    And print response
    
    * def THUMBwidgetname = 'FEEDBACK_WIDGET_API'
		* def id = response.find(x => x.jobType == THUMBwidgetname)._id
		* print id
    
    And match id == THUMBWidgetdockStatusID
    
    
    * def surveyType = response.find(x => x.jobType == THUMBwidgetname).response.filters.surveyType
    * def surveyName = response.find(x => x.jobType == THUMBwidgetname).response.filters.feedbackName
    * def totalFeedback = response.find(x => x.jobType == THUMBwidgetname).response.result.totalFeedback
    * def currentCount = response.find(x => x.jobType == THUMBwidgetname).response.result.extremelyLikely.currentCount
    * def previousCount = response.find(x => x.jobType == THUMBwidgetname).response.result.extremelyLikely.previousCount
    * def displayName = response.find(x => x.jobType == THUMBwidgetname).response.result.extremelyLikely.displayName
    * def scoreRange = response.find(x => x.jobType == THUMBwidgetname).response.result.extremelyLikely.scoreRange
    * def proTipValue = response.find(x => x.jobType == THUMBwidgetname).response.result.extremelyLikely.proTipValue
    
    And match surveyType == 'THUMB'
    And match surveyName == feedbackNameThumbs
    And match totalFeedback == 2
    And match currentCount == 1
    And match previousCount == 0
    And match displayName == 'Extremely Likely'
    And match scoreRange == '1'
    And match proTipValue == 'The percentage and the number of respondents who responded with a score of 1'
    
    
    * def currentCount = response.find(x => x.jobType == THUMBwidgetname).response.result.extremelyUnlikely.currentCount
    * def previousCount = response.find(x => x.jobType == THUMBwidgetname).response.result.extremelyUnlikely.previousCount
    * def displayName = response.find(x => x.jobType == THUMBwidgetname).response.result.extremelyUnlikely.displayName
    * def scoreRange = response.find(x => x.jobType == THUMBwidgetname).response.result.extremelyUnlikely.scoreRange
    * def proTipValue = response.find(x => x.jobType == THUMBwidgetname).response.result.extremelyUnlikely.proTipValue
    
    And match currentCount == 1
    And match previousCount == 0
    And match displayName == 'Extremely Unlikely'
    And match scoreRange == '0'
    And match proTipValue == 'The percentage and the number of respondents who responded with a score of 0'
    
    
    Scenario: Validating the THUMB MeterScore widget data
    * def today = JavaClass.get('today')
    * def ThreedaysFilter = JavaClass.get('ThreedaysFilter')
    
    Given path 'builder/streams/'+streamId+'/feedBack/meterscores'
    * def Payload = read('MeterScoreWidget.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.feedbackName[0] = feedbackNameThumbs
    * set Payload.filters.surveyType = 'THUMB'
    And param mode = 'async'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    And method post
    Then status 200
    And print response
    
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('meterdockStatusID', response._id)
    
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
		* call sleep 5
		
		Scenario: Dock Status call to get the data
		* def meterdockStatusID = JavaClass.get('meterdockStatusID')
		* print meterdockStatusID
		Given path 'builder/streams/'+streamId+'/dockStatus'
		And header Authorization = 'bearer '+accessToken
		And method get
    Then status 200
    And print response
    
    * def THUMBwidgetname = 'FEEDBACK_METER_API'
		* def id = response.find(x => x.jobType == THUMBwidgetname)._id
		* print id
    
    And match id == meterdockStatusID
    
    * def surveyType = response.find(x => x.jobType == THUMBwidgetname).response.filters.surveyType
    * def surveyName = response.find(x => x.jobType == THUMBwidgetname).response.filters.feedbackName[0]
    * def totalFeedback = response.find(x => x.jobType == THUMBwidgetname).response.result.totalFeedback
    * def extremelyLikely = response.find(x => x.jobType == THUMBwidgetname).response.result.extremelyLikely
    * def feedbackProtipMeterChart = response.find(x => x.jobType == THUMBwidgetname).response.feedbackProtipMeterChart
    
    And match surveyType == 'THUMB'
    And match surveyName == feedbackNameThumbs
    And match totalFeedback == 2
    And match extremelyLikely == 1
    And match feedbackProtipMeterChart == 'The percentage of No of extremely likely customers against total number of respondents'
    
    Scenario: Validating the THUMB Barchart widget data
    * def today = JavaClass.get('today')
    * def ThreedaysFilter = JavaClass.get('ThreedaysFilter')
    
    Given path 'builder/streams/'+streamId+'/feedBack/barChart'
    * def Payload = read('MeterScoreWidget.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.feedbackName[0] = feedbackNameThumbs
    * set Payload.filters.surveyType = 'THUMB'
    And param mode = 'async'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    And method post
    Then status 200
    And print response
    
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('barchartdockStatusID', response._id)
    
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
		* call sleep 5
		
		Scenario: Dock Status call to get the data
		* def barchartdockStatusID = JavaClass.get('barchartdockStatusID')
		* print barchartdockStatusID
		Given path 'builder/streams/'+streamId+'/dockStatus'
		And header Authorization = 'bearer '+accessToken
		And method get
    Then status 200
    And print response
    
    * def THUMBwidgetname = 'FEEDBACK_BARCHART_API'
		* def id = response.find(x => x.jobType == THUMBwidgetname)._id
		* print id
		
		* def surveyType = response.find(x => x.jobType == THUMBwidgetname).response.filters.surveyType
    * def surveyName = response.find(x => x.jobType == THUMBwidgetname).response.filters.feedbackName[0]
    * def totalCount = response.find(x => x.jobType == THUMBwidgetname).response.result[3].totalCount
    * def extremelyLikely = response.find(x => x.jobType == THUMBwidgetname).response.result[3].extremelyLikely
    * def extremelyUnlikely = response.find(x => x.jobType == THUMBwidgetname).response.result[3].extremelyUnlikely
    * def feedbackProtipBarChart = response.find(x => x.jobType == THUMBwidgetname).response.feedbackProtipBarChart
    * print feedbackProtipBarChart
    
    * def TrendCharttotalCount = response.find(x => x.jobType == THUMBwidgetname).response.result[4].totalCount
    * def TrendChartveryextremelyLikely = response.find(x => x.jobType == THUMBwidgetname).response.result[4].extremelyLikely
    * def TrendChartextremelyUnlikely = response.find(x => x.jobType == THUMBwidgetname).response.result[4].extremelyUnlikely
    * def TrendChartfeedbackProtipTrendChart = response.find(x => x.jobType == THUMBwidgetname).response.feedbackProtipTrendChart
    * print TrendChartfeedbackProtipTrendChart
    
    And match surveyType == 'THUMB'
    And match surveyName == feedbackNameThumbs
    And match totalCount == 2
    And match extremelyLikely == 1
    And match extremelyUnlikely == 1
    And match feedbackProtipBarChart == 'The percentage of Extremely Likely/Extremely Unlikely and the number respondents over a time period'
    
    And match TrendCharttotalCount == 2
    And match TrendChartveryextremelyLikely == 1
    And match TrendChartextremelyUnlikely == 1
    And match TrendChartfeedbackProtipTrendChart == 'The total number of extremely likely users over a time period'
    
    Scenario: Validating the CSAT userfeedback widget data
    * def today = JavaClass.get('today')
    * def ThreedaysFilter = JavaClass.get('ThreedaysFilter')
    
    Given path 'builder/streams/'+streamId+'/feedBack/userfeedback'
    * def Payload = read('MeterScoreWidget.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.feedbackName[0] = feedbackNameThumbs
    * set Payload.filters.surveyType = 'THUMB'
    And param mode = 'async'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    And method post
    Then status 200
    And print response
    
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('userfeedbackdockStatusID', response._id)
    
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
		* call sleep 5
		
		Scenario: Dock Status call to get the data
		* def userfeedbackdockStatusID = JavaClass.get('userfeedbackdockStatusID')
		* print userfeedbackdockStatusID
		
		Given path 'builder/streams/'+streamId+'/dockStatus'
		And header Authorization = 'bearer '+accessToken
		And method get
    Then status 200
    And print response
    
    * def userfeedbackwidgetname = 'FEEDBACK_USER_API'
		* def id = response.find(x => x.jobType == userfeedbackwidgetname)._id
		* print id
    
    And match id == userfeedbackdockStatusID
    
    
    * def surveyType = response.find(x => x.jobType == userfeedbackwidgetname).response.filters.surveyType
    * def surveyName = response.find(x => x.jobType == userfeedbackwidgetname).response.filters.feedbackName[0]
    
    * def botId = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].botId
    * def score = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].score
    * def channel = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].channel
    * def language = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].language
    * def surveyNameFeed = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].feedbackName
    * def feedbackMessage = response.find(x => x.jobType == userfeedbackwidgetname).response.result[0].feedbackMessage
    
    And match surveyType == 'THUMB'
    And match surveyName == feedbackNameThumbs
    And match botId == streamId
    And match score == 1
    And match channel == 'ivr'
    And match language == 'English'
    And match surveyNameFeed == feedbackNameThumbs
    And match feedbackMessage == ''
    
    * def botId1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].botId
    * def score1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].score
    * def channel1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].channel
    * def language1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].language
    * def surveyNameFeed1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].feedbackName
    * def feedbackMessage1 = response.find(x => x.jobType == userfeedbackwidgetname).response.result[1].feedbackMessage
    
    And match botId1 == streamId
    And match score1 == 0
    And match channel1 == 'ivr'
    And match language1 == 'English'
    And match surveyNameFeed1 == feedbackNameThumbs
    And match feedbackMessage1 == ''