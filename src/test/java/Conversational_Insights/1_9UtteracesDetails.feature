@R10.0
Feature: Utterance Details

  Background: 
    * url appUrl

  Scenario: Login into the Bot Builder
    Given path 'oauth/token'
    When request { "password":'#(password)', "client_id":"1", "client_secret":"1","scope":"friends","grant_type":"password","username":'#(username)' }
    And method post
    Then status 200
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('accountID', response.authorization.accountId)
    * JavaClass.add('accessToken', response.authorization.accessToken)
    * JavaClass.add('userId',response.userInfo.id)
    * JavaClass.add('orgID', response.userInfo.orgID )
    And print 'Response is: ', response

  Scenario: Validating the Utterances Details
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
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
    * def streamID = JavaClass.get('streamId')
    * def accountID = JavaClass.get('accountID')
    * def accessToken = JavaClass.get('accessToken')
    * def taskID1 = JavaClass.get('taskID1')
    * def taskID2 = JavaClass.get('taskID2')
    * def taskID3 = JavaClass.get('taskID3')
    * def taskIDs = ["#(taskID1)","#(taskID2)","#(taskID3)"]
    * print taskIDs
    * print streamID
    Given path 'builder/metrics/intentdiscovery/streams/'+streamID+'/utterances'
    * def Payload = read('UtterancesDetails.json')
    * set Payload.filters.from = ThreedaysFilter
    * set Payload.filters.to = today
    * set Payload.filters.taskId = taskIDs
    And request Payload
    And param view = 'intent'
    And param offset = '0'
    And param limit = '30'
    And header Content-Type = 'application/json'
    And header AccountId = accountID
    And header Authorization = 'bearer '+accessToken
    And header state = 'configured'
    And header X-Timezone-Offset = '-330'
    When method post
    Then status 200
    And print response
    And match response[*].utterance contains ["Login","Register","Booking"]
    And match response[*].intent contains ["#(taskID1)","#(taskID2)","#(taskID3)"]
    * def utteranceStatus1 = response[0].utteranceStatus
    And match utteranceStatus1 == 0
    * def utteranceStatus2 = response[1].utteranceStatus
    And match utteranceStatus2 == 0
    * def utteranceStatus3 = response[2].utteranceStatus
    And match utteranceStatus3 == 0
    * JavaClass.add('clusterID1', response[0].id)
    * JavaClass.add('clusterID2', response[1].id)
    * JavaClass.add('clusterID3', response[2].id)
