@kore
Feature:  Validating PerformanceDashBoard APIs

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
     * def JavaMethods = Java.type('data.commonJava')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
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
    * def future = JavaMethods.ConvertDateFormat(Appenddays,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    * def past = JavaMethods.ConvertDateFormat(decrease,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    * print today
    * print decrease
    * print Appenddays
    * print future
    * print past
    Scenario: 1PERFORMANCE >>>>>> PERFORMANCESTATS_API
    * def Payload =  
    """
  {
    "filters": {
        "from": "2022-07-07",
        "to": "2022-07-09",
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
  * set Payload.filters.from = past
  * set Payload.filters.to = today
 Given path '/builder/streams/'+PstreamId+'/performance/stats'
  And param mode = 'async'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload 
  When method post
  Then status 200
  * print response
  
  
 
 
    Scenario: 2PERFORMANCE >>>>>> INTENTIDENTIFICATION_API
    * def Payload = 
    """
  {
    "filters": {
        "from": "2022-07-07",
        "to": "2022-07-09",
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
  * set Payload.filters.from = past
   * set Payload.filters.to = today
 Given path '/builder/streams/'+PstreamId+'/performance/widgets/intentidentification'
  And param mode = 'async'
  And param dimensions = '10minutes'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload
  When method post
  Then status 200
  * print response
  
 
 
    Scenario: 3PERFORMANCE >>>>>> INTENT_API
    * def Payload = 
    """
  {
    "filters": {
        "from": "2022-07-06",
        "to": "2022-07-09",
        "limit": 5,
        "skip": 0,
        "channels": [],
        "language": [],
        "tags": {},
        "sessionCategory": [
            0,
            1
        ],
        "sessionStatus": "all"
    },
    "sessionType": "all"
}
    """
  * set Payload.filters.from = past
   * set Payload.filters.to = today
 Given path '/builder/streams/'+PstreamId+'/containmentmetrics/intents'
  And param mode = 'async'
  And param type = 'identified'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload
  When method post
  Then status 200
  * print response
  
 
 
 
 
   Scenario: 4PERFORMANCE >>>>>> UNIDENTIFIEDUTTERANCES_APII
   
   * def Payload = 
    """
  {
    "filters": {
        "from": "2022-07-06",
        "to": "2022-07-09",
        "limit": 5,
        "skip": 0,
        "channels": [],
        "language": [],
        "tags": {},
        "sessionCategory": [
            0,
            1
        ],
        "sessionStatus": "all"
    },
    "sessionType": "all"
}
  """
  
  * set Payload.filters.from = past
  * set Payload.filters.to = today
  
 Given path '/builder/streams/'+PstreamId+'/containmentmetrics/intents'
  And param mode = 'async'
  And param type = 'unidentified'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header accountid = adminaccountID1
  And header Content-Type = 'application/json;charset=UTF-8'
  And request Payload
  When method post
  Then status 200
  * print response
 
 
   * def sleep =
      """
      function(seconds){
        for(i = 0; i <= seconds; i++)
        {
          java.lang.Thread.sleep(1*10000);
          karate.log(i);
        }
      }
      """
* call sleep 10
 
  
  Scenario: dockstatus api
   
   Given path '/builder/streams/'+PstreamId+'/dockStatus'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID1 
    And header Host = '<calculated when request is sent>'
    And header bot-language = 'en'
    And header state = 'configured'
     
    When method get
    Then status 200
    And print response