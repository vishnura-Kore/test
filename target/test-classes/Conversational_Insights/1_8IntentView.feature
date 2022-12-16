@R10.0
Feature: Intent View

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

  Scenario: Intent View
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
  * print streamID
  Given path 'builder/metrics/intentdiscovery/streams/'+streamID
  * def Payload = read('IntentViewPayload.json')
  * set Payload.filters.from = ThreedaysFilter
  * set Payload.filters.to = today
  And request Payload
  And param view = 'intent'
  And header Content-Type = 'application/json'
  And header AccountId = accountID
  And header Authorization = 'bearer '+accessToken
  And header state = 'configured'
  And header X-Timezone-Offset = '-330'
  When method post
  Then status 200
  And print response
  
  #Assertions
  And match response.result[0].details[0].type == 'cluster'
  And string convert_num_to_string = response.result[0].details[0].count
  And match convert_num_to_string == '1'
  And string convert_num_to_string = response.result[0].totalCount
  And match convert_num_to_string == '1'
  
  And match response.result[1].details[0].type == 'cluster'
  And string convert_num_to_string = response.result[1].details[0].count
  And match convert_num_to_string == '1'
  And string convert_num_to_string = response.result[1].totalCount
  And match convert_num_to_string == '1'
  
  And match response.result[2].details[0].type == 'cluster'
  And string convert_num_to_string = response.result[2].details[0].count
  And match convert_num_to_string == '1'
  And string convert_num_to_string = response.result[2].totalCount
  And match convert_num_to_string == '1'
  
  And match response.tasks[*].localeData.en.name contains ["Login","Register","Booking"]
  
  * def JavaClass = Java.type('data.HashMap')
  * JavaClass.add('taskID1', response.tasks[0]._id)
  * JavaClass.add('taskID2', response.tasks[1]._id)
  * JavaClass.add('taskID3',response.tasks[2]._id)
 
 
  
  