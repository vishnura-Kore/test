@runtime
Feature: Enabling Webhook channel and creating app

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
     * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def name = JavaMethods.generateRandom('number')
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
    
    Scenario: Creating CustomDashboard 
  * def Payload = 
  """
  {
    "name": "DashboardName"
}
"""

* set Payload.name = 'DashBoard'+name
   Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId+'/dashboards'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    * def SanityDashBoardID = response._id
   * JavaClass.add('SanityDashBoardID', SanityDashBoardID)
  
      
    Scenario: Running query
   * def SanityDashBoardID = JavaClass.get('SanityDashBoardID')
  * def Payload = 
  """
 {
    "sqlQuery": {
        "dataSet": "Analytics",
        "select": "metricType,taskname,channel",
        "filterBy": "metricType='successtasks' "
    }
}
"""
  Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId+'/dashboards/'+SanityDashBoardID+'/executeSQLQuery'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And param startDate = SevenDays
    And param endDate = today
    And param limit = '-1'
    And param offset = '0'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $.queryResponse..metrictype == ["successtasks","successtasks"]
    
    
    
    
      Scenario:  a 
   * def SanityDashBoardID = JavaClass.get('SanityDashBoardID')
  * def Payload = 
  """
 {
    "sqlQuery": {
        "dataSet": "Analytics",
        "select": "taskname,channel",
        "filterBy": "taskname='SendEmail' "
    }
}
"""
  Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId+'/dashboards/'+SanityDashBoardID+'/executeSQLQuery'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And param startDate = SevenDays
    And param endDate = today
    And param limit = '-1'
    And param offset = '0'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $.queryResponse..taskname == ["SendEmail"]
    
    