Feature: Validting the CustomDashboard

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def PstreamId = JavaClass.get('PstreamId')
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

  Scenario: Getting DashboardId details
    Given path '/users/'+botadminUserID1+'/builder/streams/'+PstreamId+'/dashboards'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    * def DashboardId = response.dashboards[0]._id
    * JavaClass.add('DashboardId', DashboardId)

  Scenario: dockstatus of UNHANDLEDUTTERANCE_API with  Entity
    * def DashboardId = JavaClass.get('DashboardId')
    Given path '/users/'+botadminUserID1+'/builder/streams/'+PstreamId+'/dashboards/'+DashboardId+'/executeSQLQuery'
    And param startDate = ThreedaysFilter
    And param endDate = today
    And param limit = '-1'
    And param offset = '0'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request
      """
      {
      "sqlQuery": {
          "dataSet": "Analytics",
          "select": "metrictype,eventtype",
          "filterBy": "metrictype=unhandledutterances"
      }
      }
      """
    When method post
    Then status 200
    * print response
    * def Id = response._id
    * JavaClass.add('Id', Id)
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

  Scenario: Getting DashboardId status
    * def Id = JavaClass.get('Id')
    * print Id
    Given path '/builder/streams/'+PstreamId+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    * def FileId = response.find(x => x._id == Id).fileId
    * print FileId
    * JavaClass.add('FileId', FileId)

  Scenario: Getting DashboardId status
    * def Confirmation = JavaClass.get('Confirmation')
    * def entityretry = JavaClass.get('entityretry')
    * def StandardResponse = JavaClass.get('StandardResponse')
    * def FileId = JavaClass.get('FileId')
    Given path '/attachment/file/'+FileId+'/datastream'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200  
    And print response
    And match response.queryResponse[0].eventtype == entityretry
    And match response.queryResponse[1].eventtype == Confirmation 
    And match response.queryResponse[2].eventtype == StandardResponse 
