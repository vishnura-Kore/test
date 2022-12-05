@R10.0
Feature: Get Sessoion Details
Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
     * def streamId = JavaClass.get('streamId')
     * def adminaccountID1 = JavaClass.get('adminaccountID1')
     * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
      * def botadminUserID1 = JavaClass.get('botadminUserID1')
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
    
     Scenario: To filter Active Session Details
     Given path '/builder/streams/'+streamId+'/conversationanalytics/sessions'
     And param mode = 'async'
     And header accountid = adminaccountID1
		And header authorization = 'bearer '+botadminaccesstokenuser1
	  And header content-type = 'application/json'
	  And param mode = 'async'
	  * def Payload =
	 """
	  {
    "filters": {
        "from": "2022-09-27T10:21:03.384Z",
        "to": "2022-09-28T10:21:03.384Z",
        "channels": [],
        "limit": 20,
        "skip": 0,
        "labels": [],
        "status": "all",
        "containmentType": "selfservice",
        "type": "interactive",
        "isDeveloper": true,
        "taskNames": [],
        "tags": {
            "and": []
        },
        "koreUIds": [],
        "channelUIds": [],
        "excludeUserIds": [],
        "excludeChannelUIds": [],
        "events": []
    }
}
"""
* set Payload.filters.from = SevenDays
* set Payload.filters.to = today
And request Payload
When method Post
Then status 200
* print response
* def docstatusid = response._id
* JavaClass.add('docstatusid',docstatusid)
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
	 
Scenario: Validating Active get session details
* def docstatusid = JavaClass.get('docstatusid')
* print docstatusid
Given path 'builder/streams/'+streamId+'/dockStatus'
And header accountid = adminaccountID1
And header authorization = 'bearer '+botadminaccesstokenuser1
And header content-type = 'application/json'
When method get
Then status 200
* print response

* def name = 'CONVERSATION_ANALYTICS_API'
* def id = response.find(x => x.jobType == name)._id
* print id

And match id == docstatusid
* def sessionid1 = response.find(x => x.jobType == name).response.sessions[0].sessionId
* print sessionid1
* def userid1 = response.find(x => x.jobType == name).response.sessions[0].userId
* print userid1
* def sessionid2 = response.find(x => x.jobType == name).response.sessions[1].sessionId
* print sessionid2
* def userid2 = response.find(x => x.jobType == name).response.sessions[0].userId
* print userid2
* def sessionid3 = response.find(x => x.jobType == name).response.sessions[2].sessionId
* print sessionid3
* def userid3 = response.find(x => x.jobType == name).response.sessions[0].userId
* print userid3
* JavaClass.add('sessionid1',sessionid1)
* JavaClass.add('sessionid2',sessionid2)
* JavaClass.add('sessionid3',sessionid3)
* JavaClass.add('userid1',userid1)
* JavaClass.add('userid2',userid2)
* JavaClass.add('userid3',userid3)

Scenario: Get chat History 
			* def sessionid1 = JavaClass.get('sessionid1')
			* def sessionid2 = JavaClass.get('sessionid2')
			* def sessionid3 = JavaClass.get('sessionid3')
			* def userid1 = JavaClass.get('userid1')
			* def userid2 = JavaClass.get('userid2')
			* def userid3 = JavaClass.get('userid3')

 			Given path '/botmessages'
 			And param botId = streamId
 			And param sessionId = sessionid1
 			And param limit = '30'
 			And param skip = '0'
 			And param direction = '0'
 			And param showTimeLines = 'true'
 			And param allowAllChannels = 'true'
 			And param forward = 'false'
 			And param userId = userid1
 			And param considerbotevents = 'true'
     And header accountid = adminaccountID1
		And header authorization = 'bearer '+botadminaccesstokenuser1
	  And header content-type = 'application/json'
	  When method get
		Then status 200
		* print response
		And match response.botEventsFlow[0].result == 'successintent'
		And match response.botEventsFlow[1].result == 'welcome'
		And match response.botEventsFlow[2].result == 'confirmationretry'
		And match response.botEventsFlow[3].result == 'entityretry'
		And match response.botEventsFlow[4].result == 'endofconversation'

Scenario: Get chat History 2
			* def sessionid1 = JavaClass.get('sessionid1')
			* def sessionid2 = JavaClass.get('sessionid2')
			* def sessionid3 = JavaClass.get('sessionid3')
			* def userid1 = JavaClass.get('userid1')
			* def userid2 = JavaClass.get('userid2')
			* def userid3 = JavaClass.get('userid3')

 			Given path '/botmessages'
 			And param botId = streamId
 			And param sessionId = sessionid2
 			And param limit = '30'
 			And param skip = '0'
 			And param direction = '0'
 			And param showTimeLines = 'true'
 			And param allowAllChannels = 'true'
 			And param forward = 'false'
 			And param userId = userid2
 			And param considerbotevents = 'true'
     And header accountid = adminaccountID1
		And header authorization = 'bearer '+botadminaccesstokenuser1
	  And header content-type = 'application/json'
	  When method get
		Then status 200
		* print response
		And match response.botEventsFlow[0].result == 'successintent'
		And match response.botEventsFlow[1].result == 'welcome'
		And match response.botEventsFlow[2].result == 'endofconversation'
		
		Scenario: Get chat History 3
			* def sessionid1 = JavaClass.get('sessionid1')
			* def sessionid2 = JavaClass.get('sessionid2')
			* def sessionid3 = JavaClass.get('sessionid3')
			* def userid1 = JavaClass.get('userid1')
			* def userid2 = JavaClass.get('userid2')
			* def userid3 = JavaClass.get('userid3')

 			Given path '/botmessages'
 			And param botId = streamId
 			And param sessionId = sessionid1
 			And param limit = '30'
 			And param skip = '0'
 			And param direction = '0'
 			And param showTimeLines = 'true'
 			And param allowAllChannels = 'true'
 			And param forward = 'false'
 			And param userId = userid3
 			And param considerbotevents = 'true'
     And header accountid = adminaccountID1
		And header authorization = 'bearer '+botadminaccesstokenuser1
	  And header content-type = 'application/json'
	  When method get
		Then status 200
		* print response
		* def msgtagid = response.messages[2]._id
		* JavaClass.add('msgtagid',msgtagid)
#And match response[0].response.sessions[0].incoming == 1
#And match response[0].response.sessions[0].outgoing == 1
#And match response[0].response.sessions[0].channels == "ivr"
#And match response[0].response.sessions[0].sessionCategory == "selfService"

Scenario: To get Message Id
			* def sessionid1 = JavaClass.get('sessionid1')
			* def sessionid2 = JavaClass.get('sessionid2')
			* def sessionid3 = JavaClass.get('sessionid3')
			* def userid1 = JavaClass.get('userid1')
			* def userid2 = JavaClass.get('userid2')
			* def userid3 = JavaClass.get('userid3')
Given path '/botmessages'
And param botId = streamId
 			And param sessionId = sessionid1
 			And param limit = '30'
 			And param skip = '0'
 			And param userId = userid1
 			And param considerbotevents = 'true'
     And header accountid = adminaccountID1
		And header authorization = 'bearer '+botadminaccesstokenuser1
	  And header content-type = 'application/json'
	  When method get
		Then status 200
		* print response
Scenario: Add Message Tag

Given path 'builder/users/'+botadminUserID1+'/streams/'+streamId+'/custommetatags'
* def msgtagid = JavaClass.get('msgtagid')
		And header accountid = adminaccountID1
		And header authorization = 'bearer '+botadminaccesstokenuser1
	  And header content-type = 'application/json'
	  * def Payload =
	 """
	 {
    "resourceId": "ms-b9970111-e839-5d09-84f4-f2cfda086fca",
    "name": "automation1",
    "value": "automationvalue"
		}
	"""
			* set Payload.resourceId = msgtagid
			And request Payload
			When method Post
			Then status 200
			* print response

