@R10.0
Feature: feature to get Billing Sessions

  Background: 
    * url publicUrl

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
    * def PreviousDay = JavaMethods.ConvertDateFormat(Oneday,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    * print today
    * print decrease
    * print Appenddays
    * print future
    * print PreviousDay
    * print ThreedaysFilter
    
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamId')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def JWTToken = JavaClass.get('JWTToken')
  
  Given path '/public/bot/'+streamID+'/billingsessionsummary'
  * def Payload = read('BillingSessionPayload.json')
  * set Payload.fromDate = PreviousDay
  * set Payload.toDate = today
  And request Payload
  And header Content-Type = 'application/json'
  And header auth = JWTToken
  And method post
  Then status 200
  And print 'Response is: ', response
  * JavaClass.add('dockStatusID', response._id)
  