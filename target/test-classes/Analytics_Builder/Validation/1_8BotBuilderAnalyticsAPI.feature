@kore
Feature: Validating BotBuilderAnalyticsAPIS

    Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
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

  Scenario: USERS_STATS_API With filter Sevendays
  * def Payload = 
  """
 {
    "filters": {
        "from": "2022-06-26T17:49:00.227Z",
        "to": "2022-06-27T17:49:00.227Z",
        "tags": {
            "and": []
        },
        "sessionCategory": [
            1
        ],
        "sessionStatus": "all"
    }
}
  """
* set Payload.filters.from = SevenDays
* set Payload.filters.to = today
  Given path '/builder/streams/'+streamId+'/returningUsers/stats'
  And param issummary = 'true'
  And param mode = 'async'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload
  When method post
  Then status 200
  * print response
  * match $..status == ["IN_PROGRESS"]
  * match $..jobType == ["USERS_STATS_API"]
  * def returningUsersID = response._id
  * JavaClass.add('returningUsersID', returningUsersID)
  * def returningUsersID = JavaClass.get('returningUsersID')
  * print returningUsersID
 
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
 Scenario: dockstatus of USERS_STATS_API With filter Sevendays
    * def returningUsersID = JavaClass.get('returningUsersID')
   Given path '/builder/streams/'+streamId+'/dockStatus'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header Host = '<calculated when request is sent>'
    When method get
    Then status 200
    And print response
    * def CurrentUsers = response[0].response.totalUsers.current
    * def NewUsers = response[0].response.newUsers.current
    * def returningUsersID2 = response.find(x => x._id == returningUsersID).status
    * def returningUsersID1 = response.find(x => x._id == returningUsersID).jobType
    * print NewUsers
     * print CurrentUsers
    * print returningUsersID1
    * print returningUsersID2
   
 #
 
   Scenario: USERS_STATS_API With filter threedays
  * def Payload = 
  """
 {
    "filters": {
        "from": "2022-06-26T17:49:00.227Z",
        "to": "2022-06-27T17:49:00.227Z",
        "tags": {
            "and": []
        },
        "sessionCategory": [
            1
        ],
        "sessionStatus": "all"
    }
}
  """
* set Payload.filters.from = ThreedaysFilter
* set Payload.filters.to = today
  Given path '/builder/streams/'+streamId+'/returningUsers/stats'
  And param issummary = 'true'
  And param mode = 'async'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload
  When method post
  Then status 200
  * print response
  * match $..status == ["IN_PROGRESS"]
  * match $..jobType == ["USERS_STATS_API"]
  * def returningUsersID = response._id
   * JavaClass.add('returningUsersID', returningUsersID)
    * def returningUsersID = JavaClass.get('returningUsersID')
  * print returningUsersID
 
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
 Scenario: dockstatus of USERS_STATS_API With filter threedays
    * def returningUsersID = JavaClass.get('returningUsersID')
   Given path '/builder/streams/'+streamId+'/dockStatus'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header Host = '<calculated when request is sent>'
    When method get
    Then status 200
    And print response
     * def CurrentUsers = response[0].response.totalUsers.current
    * def NewUsers = response[0].response.newUsers.current
    * def returningUsersID2 = response.find(x => x._id == returningUsersID).status
    * def returningUsersID1 = response.find(x => x._id == returningUsersID).jobType
    * print NewUsers
     * print CurrentUsers
    * print returningUsersID1
    * print returningUsersID2
    * def returningUsersID2 = response.find(x => x._id == returningUsersID).status
    * def returningUsersID1 = response.find(x => x._id == returningUsersID).jobType
    * print returningUsersID1
    * print returningUsersID2
 
 
 
   Scenario: USERS_STATS_API With filter 24Hours
  * def Payload = 
  """
 {
    "filters": {
        "from": "2022-06-26T17:49:00.227Z",
        "to": "2022-06-27T17:49:00.227Z",
        "tags": {
            "and": []
        },
        "sessionCategory": [
            1
        ],
        "sessionStatus": "all"
    }
}
  """
* set Payload.filters.from = OnedaysFilter
* set Payload.filters.to = today
  Given path '/builder/streams/'+streamId+'/returningUsers/stats'
  And param issummary = 'true'
  And param mode = 'async'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload
  When method post
  Then status 200
  * print response
  * match $..status == ["IN_PROGRESS"]
  * match $..jobType == ["USERS_STATS_API"]
  * def returningUsersID = response._id
   * JavaClass.add('returningUsersID', returningUsersID)
   * def returningUsersID = JavaClass.get('returningUsersID')
  * print returningUsersID
 
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
 Scenario: dockstatus of USERS_STATS_API With filter 24Hours
    * def returningUsersID = JavaClass.get('returningUsersID')
   Given path '/builder/streams/'+streamId+'/dockStatus'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header Host = '<calculated when request is sent>'
    When method get
    Then status 200
    And print response
     * def CurrentUsers = response[0].response.totalUsers.current
    * def NewUsers = response[0].response.newUsers.current
    * def returningUsersID2 = response.find(x => x._id == returningUsersID).status
    * def returningUsersID1 = response[0].find(x => x._id == returningUsersID).jobType
    * print NewUsers
     * print CurrentUsers
    * print returningUsersID1
    * print returningUsersID2
    * def returningUsersID2 = response.find(x => x._id == returningUsersID).status
    * def returningUsersID1 = response.find(x => x._id == returningUsersID).jobType
    * print returningUsersID1
    * print returningUsersID2
 
 
 
 
 
 
 
 
 
 
 
 
 Scenario: SUMMARY_PERFORMANCESTATS_API with filter Sevendays
 * def Payload =   
 """
{
    "filters": {
        "from": "2022-06-26T17:49:00.227Z",
        "to": "2022-06-27T17:49:00.227Z",
        "tags": {
            "and": []
        },
        "sessionCategory": [
            1
        ],
        "sessionStatus": "all"
    }
}
  """
* set Payload.filters.from = SevenDays
* set Payload.filters.to = today
  Given path '/builder/streams/'+streamId+'/performance/stats'
  And param issummary = 'true'
  And param mode = 'async'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload
  When method post
  Then status 200
  * print response
  * match $..status == ["IN_PROGRESS"]
  * match $..jobType == ["SUMMARY_PERFORMANCESTATS_API"]
  * def performanceUsersID = response._id
  * JavaClass.add('performanceUsersID', performanceUsersID)
  * def performanceUsersID = JavaClass.get('performanceUsersID')
  * print performanceUsersID
  
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
  
  
  Scenario: dockstatus of SUMMARY_PERFORMANCESTATS_API with filter Sevendays
    * def performanceUsersID = JavaClass.get('performanceUsersID')
   Given path '/builder/streams/'+streamId+'/dockStatus'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header Host = '<calculated when request is sent>'
    When method get
    Then status 200
    And print response
     #* def CurrentUsers = response[0].response.totalUsers.current
    #* def NewUsers = response[0].response.newUsers.current
    #* def performanceUsersID = response.find(x => x._id == performanceUsersID).status
    #* def performanceUsersID = response[0].find(x => x._id == performanceUsersID).jobType
    #* print NewUsers
     #* print CurrentUsers
    #* print returningUsersID1
    #* print returningUsersID2
    #* def returningUsersID2 = response.find(x => x._id == returningUsersID).status
    #* def returningUsersID1 = response.find(x => x._id == returningUsersID).jobType
    #* print returningUsersID1
    #* print returningUsersID2
  
  
  Scenario: SUMMARY_PERFORMANCESTATS_API with filter threedays
 * def Payload =   
 """
{
    "filters": {
        "from": "2022-06-26T17:49:00.227Z",
        "to": "2022-06-27T17:49:00.227Z",
        "tags": {
            "and": []
        },
        "sessionCategory": [
            1
        ],
        "sessionStatus": "all"
    }
}
  """
* set Payload.filters.from = ThreedaysFilter
* set Payload.filters.to = today
  Given path '/builder/streams/'+streamId+'/performance/stats'
  And param issummary = 'true'
  And param mode = 'async'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload
  When method post
  Then status 200
  * print response
  * match $..status == ["IN_PROGRESS"]
  * match $..jobType == ["SUMMARY_PERFORMANCESTATS_API"]
  * def performanceUsersID = response._id
  * JavaClass.add('performanceUsersID', performanceUsersID)
  * def performanceUsersID = JavaClass.get('performanceUsersID')
  * print performanceUsersID
  
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
  
  
  Scenario: dockstatus of SUMMARY_PERFORMANCESTATS_API with filter ThreedaysFilter
    * def performanceUsersID = JavaClass.get('performanceUsersID')
   Given path '/builder/streams/'+streamId+'/dockStatus'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header Host = '<calculated when request is sent>'
    When method get
    Then status 200
    And print response
  
  
  
  Scenario: SUMMARY_PERFORMANCESTATS_API with filter OnedaysFilter
 * def Payload =   
 """
{
    "filters": {
        "from": "2022-06-26T17:49:00.227Z",
        "to": "2022-06-27T17:49:00.227Z",
        "tags": {
            "and": []
        },
        "sessionCategory": [
            1
        ],
        "sessionStatus": "all"
    }
}
  """
* set Payload.filters.from = OnedaysFilter
* set Payload.filters.to = today
  Given path '/builder/streams/'+streamId+'/performance/stats'
  And param issummary = 'true'
  And param mode = 'async'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload
  When method post
  Then status 200
  * print response
  * match $..status == ["IN_PROGRESS"]
  * match $..jobType == ["SUMMARY_PERFORMANCESTATS_API"]
  * def performanceUsersID = response._id
  * JavaClass.add('performanceUsersID', performanceUsersID)
  * def performanceUsersID = JavaClass.get('performanceUsersID')
  * print performanceUsersID
  
  
  
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
  
  Scenario: dockstatus of SUMMARY_PERFORMANCESTATS_API with filter OnedaysFilter
    * def performanceUsersID = JavaClass.get('performanceUsersID')
   Given path '/builder/streams/'+streamId+'/dockStatus'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header Host = '<calculated when request is sent>'
    When method get
    Then status 200
    And print response
  
  

  Scenario: SUMMARY_STATS_API with filter Sevendays
  * def Payload =  
  """
{
    "filters": {
        "from": "2022-06-20T13:52:57.133Z",
        "to": "2022-06-27T13:52:57.134Z",
        "tags": {
            "and": []
        },
        "sessionCategory": [
            0,
            1
        ],
        "sessionStatus": "all"
    }
}
  """
* set Payload.filters.from = SevenDays
* set Payload.filters.to = today
  Given path '/builder/streams/'+streamId+'/containmentmetrics/stats'
  And param issummary = 'true'
  And param mode = 'async'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload
  When method post
  Then status 200
  * print response
  * match $..status == ["IN_PROGRESS"]
  * match $..jobType == ["SUMMARY_STATS_API"]
  * def containmentmetricsUsersID = response._id
   * JavaClass.add('containmentmetricsUsersID', containmentmetricsUsersID)
  * def containmentmetricsUsersID = JavaClass.get('containmentmetricsUsersID')
  * print containmentmetricsUsersID
 
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

 Scenario: dockstatus of SUMMARY_STATS_API with filter Sevendays
    * def containmentmetricsUsersID = JavaClass.get('containmentmetricsUsersID')
    * def performanceUsersID = JavaClass.get('performanceUsersID')
   Given path '/builder/streams/'+streamId+'/dockStatus'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header Host = '<calculated when request is sent>'
    When method get
    Then status 200
    And print response
    #* def containmentmetricsUsersID = response.find(x => x._id == containmentmetricsUsersID).status
    #* def containmentmetrics = response.find(x => x._id == containmentmetricsUsersID).jobType
    #* print containmentmetrics
    #* print containmentmetricsUsersID
    
 
 
 
 
  Scenario: SUMMARY_STATS_API with filter threedays
  * def Payload =  
  """
{
    "filters": {
        "from": "2022-06-20T13:52:57.133Z",
        "to": "2022-06-27T13:52:57.134Z",
        "tags": {
            "and": []
        },
        "sessionCategory": [
            0,
            1
        ],
        "sessionStatus": "all"
    }
}
  """
* set Payload.filters.from = ThreedaysFilter
* set Payload.filters.to = today
  Given path '/builder/streams/'+streamId+'/containmentmetrics/stats'
  And param issummary = 'true'
  And param mode = 'async'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload
  When method post
  Then status 200
  * print response
  * match $..status == ["IN_PROGRESS"]
  * match $..jobType == ["SUMMARY_STATS_API"]
  * def containmentmetricsUsersID = response._id
   #* JavaClass.add('containmentmetricsUsersID', containmentmetricsUsersID)
  #* def containmentmetricsUsersID = JavaClass.get('containmentmetricsUsersID')
  #* print containmentmetricsUsersID
 

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
 Scenario: dockstatus of SUMMARY_STATS_API with filter threedays
    * def containmentmetricsUsersID = JavaClass.get('containmentmetricsUsersID')
    * def performanceUsersID = JavaClass.get('performanceUsersID')
   Given path '/builder/streams/'+streamId+'/dockStatus'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header Host = '<calculated when request is sent>'
    When method get
    Then status 200
    And print response
    * def containmentmetricsUsersID = response.find(x => x._id == containmentmetricsUsersID).status
    * def containmentmetrics = response.find(x => x._id == containmentmetricsUsersID).jobType
    * print containmentmetrics
    * print containmentmetricsUsersID
 
 
 Scenario: SUMMARY_STATS_API with filter 24hours
  * def Payload =  
  """
{
    "filters": {
        "from": "2022-06-20T13:52:57.133Z",
        "to": "2022-06-27T13:52:57.134Z",
        "tags": {
            "and": []
        },
        "sessionCategory": [
            0,
            1
        ],
        "sessionStatus": "all"
    }
}
  """
* set Payload.filters.from = OnedaysFilter
* set Payload.filters.to = today
  Given path '/builder/streams/'+streamId+'/containmentmetrics/stats'
  And param issummary = 'true'
  And param mode = 'async'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload
  When method post
  Then status 200
  * print response
  * match $..status == ["IN_PROGRESS"]
  * match $..jobType == ["SUMMARY_STATS_API"]
  * def SUMMARYSTATSAPI= response._id
   * JavaClass.add('SUMMARYSTATSAPI', SUMMARYSTATSAPI)
  * def SUMMARYSTATSAPI = JavaClass.get('SUMMARYSTATSAPI')
  * print SUMMARYSTATSAPI
 
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

 Scenario: dockstatus of SUMMARY_STATS_API with filter 24hours
    * def SUMMARYSTATSAPI = JavaClass.get('SUMMARYSTATSAPI')
   Given path '/builder/streams/'+streamId+'/dockStatus'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header Host = '<calculated when request is sent>'
    When method get
    Then status 200
    And print response
    * def SUMMARYSTATSAPIID = response.find(x => x._id == SUMMARYSTATSAPI).status
    * def JOBTYPE = response.find(x => x._id == SUMMARYSTATSAPI).jobType
    * print JOBTYPE
    * print SUMMARYSTATSAPIID

 
 
 
 
 
 
 
 
 
 