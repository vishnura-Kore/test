@R10.0
Feature: feature to Get Session Data

  Background: 
    * url appUrl

  Scenario: API to apply the filter to get session data 
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
    
    Given path 'oauth/token'
    When request { "password":'#(password)', "client_id":"1", "client_secret":"1","scope":"friends","grant_type":"password","username":'#(username)' }
    And method post
    Then status 200
    And print response
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('accountID', response.authorization.accountId)
    * JavaClass.add('accessToken', response.authorization.accessToken)
    * JavaClass.add('userId',response.userInfo.id)
    * JavaClass.add('orgID', response.userInfo.orgID )
    And print 'Response is: ', response
    
    Given path 'builder/streams/'+streamId+'/conversationanalytics/sessions'
    * def Payload = read('ApplyFilterSessionData.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    And request Payload
    And param mode = 'async'
    * def accountId = JavaClass.get('accountID')
    * def accessToken = JavaClass.get('accessToken')
    * def userID = JavaClass.get('userId')
    And header Content-Type = 'application/json'
    And header AccountId = accountId
    And header Authorization = 'bearer '+accessToken
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
		* call sleep 10
  
  Scenario: API to get sessions data after applying the filter 
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def streamId = JavaClass.get('streamId')
    * def accountId = JavaClass.get('accountID')
    * def accessToken = JavaClass.get('accessToken')
    * def userID = JavaClass.get('userId')
    * def dockStatusID = JavaClass.get('dockStatusID')
    
    Given path 'builder/streams/'+streamId+'/dockStatus'
    And header Content-Type = 'application/json'
    And header AccountId = accountId
    And header Authorization = 'bearer '+accessToken
    And method get
    Then status 200
    And print response
    
    * def name = 'CONVERSATION_ANALYTICS_API'
		* def id = response.find(x => x.jobType == name)._id
		* print id

		And match id == dockStatusID
		* def sessionid = response.find(x => x.jobType == name).response.sessions[0].sessionId
		* print sessionid
		* def userid = response.find(x => x.jobType == name).response.sessions[0].userId
		* print userid
		* def surveyType = response.find(x => x.jobType == name).response.sessions[0].feedback[0].type
		* print surveyType
		And match surveyType == 'NPS'
		* def score = response.find(x => x.jobType == name).response.sessions[0].feedback[0].score
		* print score
		And match score == '10'
		* def description = response.find(x => x.jobType == name).response.sessions[0].feedback[0].description
		* print description
    And match description == 'Promoter'
    * JavaClass.add('sessionid', sessionid)
    * JavaClass.add('userid', userid)
    
    Scenario: API to get bot messages 
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def streamId = JavaClass.get('streamId')
    * def accountId = JavaClass.get('accountID')
    * def accessToken = JavaClass.get('accessToken')
    * def userid = JavaClass.get('userid')
    * def dockStatusID = JavaClass.get('dockStatusID')
    * def sessionid = JavaClass.get('sessionid')
    * def feedbackName = JavaClass.get('feedbackName')
    
		Given path '/botmessages'
		And param botId = streamId
		And param sessionId = sessionid
		And param limit = '30'
		And param skip = '0'
		And param direction = '0'
		And param showTimeLines = 'true'
		And param allowAllChannels = 'true'
		And param forward = 'false'
		And param userId = userid
		And param considerbotevents = 'true'
		And header accountid = accountId
		And header authorization = 'bearer '+accessToken
		And header content-type = 'application/json'
		When method get
		Then status 200
		* print response
		* def msgtagid = response.messages[2]._id
		* JavaClass.add('msgtagid',msgtagid)
		And match response.messages[0].components[0].data.text == 'Register'
		And match response.messages[1].components[0].data.text == 'User Registered Successfully'
		And match response.messages[2].components[0].data.text == 'Register'
		And match response.messages[3].components[0].data.text == 'User Registered Successfully'
		And match response.messages[4].components[0].data.text contains 'On a scale of 0-10, how likely are you to recommend our product to your friends/family?'
		And match response.messages[5].components[0].data.text == '10'
		And match response.messages[6].components[0].data.text == 'Thank you for the valuable feedback.'
		And match response.botEventsFlow[4].result == 'Feedback'
		And match response.botEventsFlow[4].name == feedbackName
		And match response.botEventsFlow[4].score == '10'
  
  