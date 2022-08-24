@runtime
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
      
     Scenario: To filter Active Session Details
     Given path '/builder/streams/'+streamId+'/conversationanalytics/sessions'
     And header accountid = adminaccountID1
		And header authorization = 'bearer '+botadminaccesstokenuser1
	  And header content-type = 'application/json'
	  And param mode = 'async'
	  * def Payload =
	 """
	  {
    "filters": {
        "from": "2022-07-21T12:21:49.576Z",
        "to": "2022-07-24T20:42:05.687Z",
        "limit": 20,
        "skip": 0,
        "status": "active",
        "type": "interactive",
        "tags": {
            "and": []
        }
    }
}
"""
And request Payload
When method Post
Then status 200
* print response
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
Given path 'builder/streams/'+streamId+'/dockStatus'
And header accountid = adminaccountID1
And header authorization = 'bearer '+botadminaccesstokenuser1
And header content-type = 'application/json'
When method get
Then status 200
* print response
* def sessionid = response[0].response.sessions[0].sessionId
* JavaClass.add('sessionid',sessionid)
And match response[0].response.sessions[0].incoming == 1
And match response[0].response.sessions[0].outgoing == 1
And match response[0].response.sessions[0].channels == "ivr"
And match response[0].response.sessions[0].sessionCategory == "selfService"

