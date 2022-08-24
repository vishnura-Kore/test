@kore1233
Feature: data fetching

  Background: 
    * url appUrl
    * def userId = ids.userId
    * def accessToken = ids.accessToken
    * print 'UserId iss::::::::::::',userId
    * def JavaClass = Java.type('data.HashMap')
    * def JavaClass = Java.type('data.commonJava')
    * def pattern = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    #* def getDate =
      #"""
      #function() {
        #var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
        #var sdf = new SimpleDateFormat(pattern);
        #var date = new java.util.Date();
        #return sdf.format(date);
        #
      #} 
      #"""
    #* def today = getDate()
    #* def JavaClass = Java.type('data.commonJava')
    #* def Appenddays = JavaClass.getRequiredDate(7,'yyyy-MM-dd',"HH:mm:ss")
    #* def decrease = JavaClass.getdecrementdays(-7,'yyyy-MM-dd',"'T'HH:mm:ss.SSS'Z'")
    #* def threedays = JavaClass.getdecrementdays(-3,'yyyy-MM-dd',"'T'HH:mm:ss.SSS'Z'")
    #* def future = JavaClass.ConvertDateFormat(Appenddays,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    #* def past = JavaClass.ConvertDateFormat(decrease,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
     #* def threedaysFilter = JavaClass.ConvertDateFormat(threedays,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    #
    #* print today
    #* print decrease
    #* print Appenddays
    #* print future
    #* print past
    #* print threedaysFilter
    * def name = 'sendemail'
    * print name
    * def number = 3
   * def num = 15;
   * def text = num.toString();
   * print text
    * JavaClass.add('text', text)
   

  Scenario: AppControlList
    * def name = JavaClass.generateRandom('date')
    * print name
    Given path 'users/'+userId+'/AppControlList'
    And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    #And print 'Response is: ', response
    * def accountId = response.accountId
    * print 'appList account id is:',accountId
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('accountid', accountId)
