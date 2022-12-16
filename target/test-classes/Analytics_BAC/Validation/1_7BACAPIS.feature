@kore12
Feature: Validating BAC APIS

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
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

  Scenario: DASHBOARD_REPORT_API with filter Seven days
    Given path '/metrics/usage/organization/'+botadminorgID1
    And param dimensions = 'organization,date_hour'
    And param metrics = 'noOfUserAlerts,noOfUserActions,noOfChatRequest,noOfChatResponse,noOfDialogSuccess1,noOfFaqSuccess,noOfAlertSuccess,noOfActionSuccess,noOfDialogFail,noOfFaqFail,noOfAlertFail,noOfActionFail'
    And param start_date = SevenDays
    And param end_date = today
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
      "sessionCategory": null
      }
      }

      """
  
    When method post
    Then status 200
    * print response
    * def Id = response._id
    * JavaClass.add('Id', Id)
    * print Id
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["DASHBOARD_REPORT_API"]
    
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
* call sleep 5
    
    
    Scenario: DOckstatus of DASHBOARD_REPORT_API with filter Seven days
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
    * def Totalresults = response[0].response.totalResults
    * print Totalresults
   
    
    
    Scenario:  DASHBOARD_REPORT_API with filter Three days
    Given path '/metrics/usage/organization/'+botadminorgID1
    And param dimensions = 'organization,date_hour'
    And param metrics = 'noOfUserAlerts,noOfUserActions,noOfChatRequest,noOfChatResponse,noOfDialogSuccess1,noOfFaqSuccess,noOfAlertSuccess,noOfActionSuccess,noOfDialogFail,noOfFaqFail,noOfAlertFail,noOfActionFail'
    And param start_date = ThreedaysFilter
    And param end_date = today
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
      "sessionCategory": null
      }
      }

      """
  
    When method post
    Then status 200
    * print response
    * def Id = response._id
    * JavaClass.add('Id', Id)
    * print Id
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["DASHBOARD_REPORT_API"]
    
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
* call sleep 5
    
    
    Scenario: DOckstatus of DASHBOARD_REPORT_API with filter Three days
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
    * def Totalresults = response[0].response.totalResults
    * print Totalresults
   
    
    
      Scenario: DASHBOARD_REPORT_API with filter 24hours
    Given path '/metrics/usage/organization/'+botadminorgID1
    And param dimensions = 'organization,date_hour'
    And param metrics = 'noOfUserAlerts,noOfUserActions,noOfChatRequest,noOfChatResponse,noOfDialogSuccess1,noOfFaqSuccess,noOfAlertSuccess,noOfActionSuccess,noOfDialogFail,noOfFaqFail,noOfAlertFail,noOfActionFail'
    And param start_date = OnedaysFilter 
    And param end_date = today
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
      "sessionCategory": null
      }
      }

      """
  
    When method post
    Then status 200
    * print response
    * def Id = response._id
    * JavaClass.add('Id', Id)
    * print Id
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["DASHBOARD_REPORT_API"]
    
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
* call sleep 5
    
    
    Scenario: DOckstatus of  DASHBOARD_REPORT_API with filter 24hours
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
    * def Totalresults = response[0].response.totalResults
    * print Totalresults
   
    

  Scenario: 2Messages and conversations API with filter Seven days
    Given path '/metrics/usage/organization/'+botadminorgID1+'/chats'
    And param dimensions = 'organization,date_day'
    And param metrics = 'noOfChatRequest,noOfChatResponse'
    And param start_date = SevenDays
    And param end_date = today
    And param channels = ''
    And param languages = ''
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def count = response.totalResults
    * print count
    
    Scenario: 2Messages and conversations API  filter for threedays
    Given path '/metrics/usage/organization/'+botadminorgID1+'/chats'
    And param dimensions = 'organization,date_day'
    And param metrics = 'noOfChatRequest,noOfChatResponse'
    And param start_date = ThreedaysFilter
    And param end_date = today
    And param channels = ''
    And param languages = ''
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def count = response.totalResults
    * print count
    
    Scenario: 2Messages and conversations API with filter 24hours
    Given path '/metrics/usage/organization/'+botadminorgID1+'/chats'
    And param dimensions = 'organization,date_day'
    And param metrics = 'noOfChatRequest,noOfChatResponse'
    And param start_date = OnedaysFilter
    And param end_date = today
    And param channels = ''
    And param languages = ''
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def count = response.totalResults
    * print count

  Scenario: 3ACTIVEUSER_DASHBOARD_API with filter Sevendays
    Given path '/metrics/usage/organization/'+botadminorgID1+'/activeusers'
    And param dimensions = 'organization,user'
    And param metrics = 'noOfChatRequest'
    And param start_date = SevenDays
    And param end_date = today
    And param channels = ''
    And param languages = ''
    And param jobType = 'ACTIVEUSER_DASHBOARD_API'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def Id2 = response._id
    * JavaClass.add('Id2', Id2)
    * print Id2
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["ACTIVEUSER_DASHBOARD_API"]
    
    
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
* call sleep 5
    
    
    
    
     Scenario: DOckstatus of ACTIVEUSER_DASHBOARD_API with filter Sevendays
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
   * def ActiveusersCount = response[0].response.activeUsersCount
   * print ActiveusersCount
    
    
    Scenario: 3ACTIVEUSER_DASHBOARD_API with filter Three days
    Given path '/metrics/usage/organization/'+botadminorgID1+'/activeusers'
    And param dimensions = 'organization,user'
    And param metrics = 'noOfChatRequest'
    And param start_date = ThreedaysFilter
    And param end_date = today
    And param channels = ''
    And param languages = ''
     And param jobType = 'ACTIVEUSER_DASHBOARD_API'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def Id2 = response._id
    * JavaClass.add('Id2', Id2)
    * print Id2
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["ACTIVEUSER_DASHBOARD_API"]
    
    
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
* call sleep 5
    
    
    
    
     Scenario: DOckstatus of ACTIVEUSER_DASHBOARD_API with filter Three days
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
   * def ActiveusersCount = response[0].response.activeUsersCount
    * print ActiveusersCount
    
 Scenario: 3ACTIVEUSER_DASHBOARD_API API filter for 24hours
    Given path '/metrics/usage/organization/'+botadminorgID1+'/activeusers'
    And param dimensions = 'organization,user'
    And param metrics = 'noOfChatRequest'
    And param start_date = OnedaysFilter
    And param end_date = today
    And param channels = ''
    And param languages = ''
     And param jobType = 'ACTIVEUSER_DASHBOARD_API'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def Id2 = response._id
    * JavaClass.add('Id2', Id2)
    * print Id2
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["ACTIVEUSER_DASHBOARD_API"]
    
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
* call sleep 5
    
    
     Scenario: DOckstatus of ACTIVEUSER_DASHBOARD_API API filter for 24hours
   
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
    * def ActiveusersCount = response[0].response.activeUsersCount
    * print ActiveusersCount
    
    
  Scenario: 4ACTIVEUSER_ACTIVE_DASHBOARD_API with filter seven days
  
    Given path '/metrics/usage/organization/'+botadminorgID1+'/activeusers'
    And param dimensions = 'organization,user,date_day'
    And param metrics = 'noOfChatRequest'
    And param start_date = SevenDays
    And param end_date = today
    And param channels = ''
    And param languages = ''
    And param jobType = 'ACTIVEUSER_ACTIVE_DASHBOARD_API'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def Id3 = response._id
    * JavaClass.add('Id3', Id3)
    * print Id3
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["ACTIVEUSER_ACTIVE_DASHBOARD_API"]
    
    
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
* call sleep 5
    
    
    
     Scenario: DOckstatus of ACTIVEUSER_DASHBOARD_API with filter 7 days
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
    * def ACTIVEUSER_ACTIVE_Count = response[0].response.activeUsersCount
    * print ACTIVEUSER_ACTIVE_Count
    
    Scenario: 4ACTIVEUSER_ACTIVE_DASHBOARD_API with filter Three days
  
    Given path '/metrics/usage/organization/'+botadminorgID1+'/activeusers'
    And param dimensions = 'organization,user,date_day'
    And param metrics = 'noOfChatRequest'
    And param start_date = ThreedaysFilter
    And param end_date = today
    And param channels = ''
    And param languages = ''
    And param jobType = 'ACTIVEUSER_ACTIVE_DASHBOARD_API'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def Id3 = response._id
    * JavaClass.add('Id3', Id3)
    * print Id3
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["ACTIVEUSER_ACTIVE_DASHBOARD_API"]
    
    
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
* call sleep 5
    
    
    
     Scenario: DOckstatus of 4ACTIVEUSER_ACTIVE_DASHBOARD_API with filter Three days
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
    * def ACTIVEUSER_ACTIVE_Count = response[0].response.activeUsersCount
    * print ACTIVEUSER_ACTIVE_Count
    
     Scenario: 4ACTIVEUSER_ACTIVE_DASHBOARD_API with filter 24hours
    Given path '/metrics/usage/organization/'+botadminorgID1+'/activeusers'
    And param dimensions = 'organization,user,date_day'
    And param metrics = 'noOfChatRequest'
    And param start_date = OnedaysFilter
    And param end_date = today
    And param channels = ''
    And param languages = ''
    And param jobType = 'ACTIVEUSER_ACTIVE_DASHBOARD_API'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def Id3 = response._id
    * JavaClass.add('Id3', Id3)
    * print Id3
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["ACTIVEUSER_ACTIVE_DASHBOARD_API"]
    
    
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
* call sleep 5
    
    
     Scenario: DOckstatus of ACTIVEUSER_ACTIVE_DASHBOARD_API with filter 24hours
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
    * def ACTIVEUSER_ACTIVE_Count = response[0].response.activeUsersCount
    * print ACTIVEUSER_ACTIVE_Count


  Scenario: 5STREAM_DASHBOARD_API with filters Seven days
    Given path '/metrics/usage/organization/'+botadminorgID1+'/streams'
    And param dimensions = 'organization,stream'
    And param metrics = 'noOfChatRequest,noOfChatResponse'
    And param start_date = SevenDays
    And param end_date = today
    And param sortType = 'desc'
    And param channels = ''
    And param languages = ''
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def Id4 = response._id
    * JavaClass.add('Id4', Id4)
    * print Id4
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["STREAM_DASHBOARD_API"]
    
    
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
* call sleep 5
    
    
     Scenario: DOckstatus of STREAM_DASHBOARD_API with filters Seven days
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
    * def count = response[0].response.totalResults
    * print count 
    
     Scenario: 5STREAM_DASHBOARD_API with filters three days
    Given path '/metrics/usage/organization/'+botadminorgID1+'/streams'
    And param dimensions = 'organization,stream'
    And param metrics = 'noOfChatRequest,noOfChatResponse'
    And param start_date = ThreedaysFilter
    And param end_date = today
    And param sortType = 'desc'
    And param channels = ''
    And param languages = ''
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def Id4 = response._id
    * JavaClass.add('Id4', Id4)
    * print Id4
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["STREAM_DASHBOARD_API"]
    
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
* call sleep 5
    
     Scenario: DOckstatus of STREAM_DASHBOARD_API with filters three days
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
     * def count = response[0].response.totalResults
    * print count 
    
     Scenario: 5STREAM_DASHBOARD_API with filters 24 Hours
    Given path '/metrics/usage/organization/'+botadminorgID1+'/streams'
    And param dimensions = 'organization,stream'
    And param metrics = 'noOfChatRequest,noOfChatResponse'
    And param start_date = OnedaysFilter
    And param end_date = today
    And param sortType = 'desc'
    And param channels = ''
    And param languages = ''
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def Id4 = response._id
    * JavaClass.add('Id4', Id4)
    * print Id4
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["STREAM_DASHBOARD_API"]
    
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
* call sleep 5
    
    
     Scenario: DOckstatus of STREAM_DASHBOARD_API with filters 24Hours
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
    * def count = response[0].response.totalResults
    * print count  

  Scenario: 6TASKS_DASHBOARD_API with Filter Sevendays
    Given path '/metrics/usage/organization/'+botadminorgID1+'/tasks'
    And param dimensions = 'organization,task'
    And param metrics = 'noOfUserActions,noOfDialogSuccess1,noOfFaqSuccess'
    And param start_date = SevenDays
    And param end_date = today
    And param sortType = 'desc'
    And param channels = ''
    And param limit = '-1'
    And param languages = ''
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def Id5 = response._id
    * JavaClass.add('Id5', Id5)
    * print Id5
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["TASKS_DASHBOARD_API"]
    
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
* call sleep 5
    
    
     Scenario: DOckstatus of TASKS_DASHBOARD_API with Filter Sevendays
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
    * def SuccessfulTasks = response[0].response.totalResults
    * print SuccessfulTasks 
    
    
    
    
  Scenario: 6TASKS_DASHBOARD_API with Filter Threedays
    Given path '/metrics/usage/organization/'+botadminorgID1+'/tasks'
    And param dimensions = 'organization,task'
    And param metrics = 'noOfUserActions,noOfDialogSuccess1,noOfFaqSuccess'
    And param start_date = ThreedaysFilter
    And param end_date = today
    And param sortType = 'desc'
    And param channels = ''
    And param limit = '-1'
    And param languages = ''
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def Id5 = response._id
    * JavaClass.add('Id5', Id5)
    * print Id5
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["TASKS_DASHBOARD_API"]
    
    
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
* call sleep 5
    
    
     Scenario: DOckstatus of TASKS_DASHBOARD_API with Filter Threedays
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
    * def SuccessfulTasks = response[0].response.totalResults
    * print SuccessfulTasks 
    
   
    Scenario: 6TASKS_DASHBOARD_API with Filter 24Hours
    Given path '/metrics/usage/organization/'+botadminorgID1+'/tasks'
    And param dimensions = 'organization,task'
    And param metrics = 'noOfUserActions,noOfDialogSuccess1,noOfFaqSuccess'
    And param start_date = OnedaysFilter
    And param end_date = today
    And param sortType = 'desc'
    And param channels = ''
    And param limit = '-1'
    And param languages = ''
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header X-HTTP-Method-Override = 'PUT'
    And request
      """
      {
      "filters": {
          "sessionCategory": null
      }
      }

      """
    When method post
    Then status 200
    * print response
    * def Id5 = response._id
    * JavaClass.add('Id5', Id5)
    * print Id5
    And match $..status == ["IN_PROGRESS"]
    And match $..percentageComplete == [0]
    And match $..jobType == ["TASKS_DASHBOARD_API"]
    
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
* call sleep 5
    
    
     Scenario: DOckstatusTASKS_DASHBOARD_API with Filter 24Hours
    * def Id2 = JavaClass.get('Id2')
    * def Id1 = JavaClass.get('Id1')
    Given path '/organization/'+botadminorgID1+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And retry until response[0].status == 'SUCCESS' || response.status == 'failure'
    When method get
    Then status 200
    * print response
    * def SuccessfulTasks = response[0].response.totalResults
    * print SuccessfulTasks 
    
    
