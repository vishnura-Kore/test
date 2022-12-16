@R10.0
Feature: feature to Login into the bot

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
  
  Scenario: Get the Billing session Dock status ID
  
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
    
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  
  Given path '/public/bot/st-b6bb88de-40a8-5087-8b54-3f35fb042fd4/billingsessionsummary'
  * def Payload = read('BillingSessionPayload.json')
  * set Payload.fromDate = Oneday
  * set Payload.toDate = today
  And request Payload
  And header Content-Type = 'application/json'
  And header auth = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiYXBwSWQiOiJjcy05NjkxNWY5MS03NzM1LTU4NGMtYWM4Ni1kZGRmYjM5MzhmOTAifQ.MTLIqmXnbwRSbgCoEdCSNHstWOhzcVq858o3zY96llY'
  And method post
  Then status 200
  And print 'Response is: ', response
  * JavaClass.add('dockStatusID', response._id)
  
  Scenario: Get the Billing session Dock status data

  * def JavaClass = Java.type('data.HashMap')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  
  Given path '/public/bot/st-b6bb88de-40a8-5087-8b54-3f35fb042fd4/billingsessionsummary/status'
  And header Content-Type = 'application/json'
  And header auth = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiYXBwSWQiOiJjcy05NjkxNWY5MS03NzM1LTU4NGMtYWM4Ni1kZGRmYjM5MzhmOTAifQ.MTLIqmXnbwRSbgCoEdCSNHstWOhzcVq858o3zY96llY'
  And param type = 'summary'
  And method get
  Then status 200
  And print 'Response is: ', response
  * def JavaClass = Java.type('data.HashMap')
  And string convert_num_to_string = response.response.data[0].val[1].val.proactive_notifications
  * JavaClass.add('proactiveNotificationCount', convert_num_to_string)
  And string convert_num_to_string = response.response.averageSessions
  * JavaClass.add('averageSessionCount', convert_num_to_string)