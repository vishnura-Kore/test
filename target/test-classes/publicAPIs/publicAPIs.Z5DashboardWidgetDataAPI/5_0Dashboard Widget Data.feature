Feature: Dashboard Widget Data with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * print SanitystreamId
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
    
  Scenario: Creating CustomDashboard
    * def Payload =
      """
      {
        "name": "DashboardName"
      }
      """
    * set Payload.name = 'DashBoard'+name
    Given path '/users/'+botadminUserID1+'/builder/streams/'+SanitystreamId+'/dashboards'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    * def DashBoardname = response.name
    * def SanityDashBoardID = response._id
    * JavaClass.add('SanityDashBoardID', SanityDashBoardID)
    * JavaClass.add('DashBoardname', DashBoardname)

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
    Given path '/users/'+botadminUserID1+'/builder/streams/'+SanitystreamId+'/dashboards/'+SanityDashBoardID+'/executeSQLQuery'
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
    
    
     Scenario:  creating  widget 
    * def SanityDashBoardID = JavaClass.get('SanityDashBoardID')
    * def Payload = read("Payload.json")
    * set Payload.name = 'Sanity'+name
    Given path '/users/'+botadminUserID1+'/builder/streams/'+SanitystreamId+'/dashboards/'+SanityDashBoardID+'/widgets'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    * def WidgetID = response._id
    * JavaClass.add('WidgetID', WidgetID)
    * def widgetname = response.name
    * JavaClass.add('widgetname', widgetname)
    * def SqlQuery = response.sqlQuery.select
    * JavaClass.add('SqlQuery', SqlQuery)
    
    

  Scenario: Adding widget to Customdashboard
  * def WidgetID = JavaClass.get('WidgetID')
   * def SanityDashBoardID = JavaClass.get('SanityDashBoardID')
    * def Payload =
      """
      {
      "properties": {
        "0": {
            "ind": 0,
            "id": "{{ConsumerBotWidgetID}}",
            "meta": 100,
            "metaHeight": 300
        }
      }
      }
      """
    * set Payload.properties.0.id = WidgetID
    Given path '/users/'+botadminUserID1+'/builder/streams/'+SanitystreamId+'/dashboards/'+SanityDashBoardID
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'put'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response._id == SanityDashBoardID 
   

  Scenario: Positive Scenario Get Dashboard Widget Data
   * def WidgetID = JavaClass.get('WidgetID')
   * def DashBoardname = JavaClass.get('DashBoardname')
    * def SqlQuery = JavaClass.get('SqlQuery')
    * def widgetname = JavaClass.get('widgetname')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/dashboard/'+DashBoardname+'/widget/'+widgetname
    And param startDate = SevenDays
    And param endDate = today
    And param skip = '0'
    And param limit = '10'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match response.name == widgetname
    And match response._id == WidgetID
    And match response.sqlQuery.select == SqlQuery

    
    
    
    
    Scenario: Negative Scenario Get Dashboard Widget Data with wrong stream id
   * def WidgetID = JavaClass.get('WidgetID')
   * def DashBoardname = JavaClass.get('DashBoardname')
    * def SqlQuery = JavaClass.get('SqlQuery')
    * def widgetname = JavaClass.get('widgetname')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+name+'/dashboard/'+DashBoardname+'/widget/'+widgetname
    And param startDate = SevenDays
    And param endDate = today
    And param skip = '0'
    And param limit = '10'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 400
    And print response 
     And match $.errors..msg == ["Invalid StreamId"]
    And match $.errors..code == [400]
    
    
    
    
      Scenario: Negative Scenario Get Dashboard Widget Data with wrong JWT Token
   * def WidgetID = JavaClass.get('WidgetID')
   * def DashBoardname = JavaClass.get('DashBoardname')
    * def SqlQuery = JavaClass.get('SqlQuery')
    * def widgetname = JavaClass.get('widgetname')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/dashboard/'+DashBoardname+'/widget/'+widgetname
    And param startDate = SevenDays
    And param endDate = today
    And param skip = '0'
    And param limit = '10'
    And header auth = JWTToken+name
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print response 
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
       Scenario: Negative Scenario Get Dashboard Widget Data with wrong HTTP METHOD
   * def WidgetID = JavaClass.get('WidgetID')
   * def DashBoardname = JavaClass.get('DashBoardname')
    * def SqlQuery = JavaClass.get('SqlQuery')
    * def widgetname = JavaClass.get('widgetname')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/dashboard/'+DashBoardname+'/widget/'+widgetname
    And param startDate = SevenDays
    And param endDate = today
    And param skip = '0'
    And param limit = '10'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 405
    And print response 
     And match $.errors..msg == ["Method Not Allowed"]
    And match $.errors..code == [405]
    
       
      Scenario: Negative Scenario Get Dashboard Widget Data with no JWT Token in header 
   * def WidgetID = JavaClass.get('WidgetID')
   * def DashBoardname = JavaClass.get('DashBoardname')
    * def SqlQuery = JavaClass.get('SqlQuery')
    * def widgetname = JavaClass.get('widgetname')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/dashboard/'+DashBoardname+'/widget/'+widgetname
    And param startDate = SevenDays
    And param endDate = today
    And param skip = '0'
    And param limit = '10'
    And header Content-Type = 'application/json'
    When method get
    Then status 401
    And print response 
     And match $.errors..msg == ["Invalid SDK credentials"]
    And match $.errors..code == [4002]
    
    
    
    
    
       Scenario: Negative Scenario Get Dashboard Widget Data with wrong widgetname
   * def WidgetID = JavaClass.get('WidgetID')
   * def DashBoardname = JavaClass.get('DashBoardname')
    * def SqlQuery = JavaClass.get('SqlQuery')
    * def widgetname = JavaClass.get('widgetname')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/dashboard/'+DashBoardname+'/widget/'+widgetname+name
    And param startDate = SevenDays
    And param endDate = today
    And param skip = '0'
    And param limit = '10'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 400
    And print response 
     And match $.errors..msg == ["Invalid widget name"]
    And match $.errors..code == [400]
    
    
    
       Scenario: Negative Scenario Get Dashboard Widget Data with wrong DashBoardname
   * def WidgetID = JavaClass.get('WidgetID')
   * def DashBoardname = JavaClass.get('DashBoardname')
    * def SqlQuery = JavaClass.get('SqlQuery')
    * def widgetname = JavaClass.get('widgetname')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/dashboard/'+DashBoardname+name+'/widget/'+widgetname
    And param startDate = SevenDays
    And param endDate = today
    And param skip = '0'
    And param limit = '10'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 400
    And print response 
     And match $.errors..msg == ["Invalid dashboard name"]
    And match $.errors..code == [400]
    