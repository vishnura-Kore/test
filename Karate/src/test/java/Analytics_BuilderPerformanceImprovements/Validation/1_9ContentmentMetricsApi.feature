@kore
Feature: Validating containment metrics Apis

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
  Scenario: containment metrics >>>>>> SUCCESSINTENT_API
  * def Payload =  
  """
      {
    "filters": {
        "from": "2022-07-07",
        "to": "2022-07-09",
        "channels": [],
        "language": [],
        "tags": {},
        "sessionCategory": []
    }
}
      """
  * set Payload.filters.from = past
   * set Payload.filters.to = today
    Given path '/builder/streams/'+PstreamId+'/containmentmetrics/stats'
    And param allConversations = 'true'
     And param mode = 'async'
    And param isConversationMetrics = 'true'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request Payload
    When method post
    Then status 200
    * print response
    * def SUCCESSINTENT_APIID = response._id
    * JavaClass.add('SUCCESSINTENT_APIID',SUCCESSINTENT_APIID)
    * def SUCCESSINTENT_APIID = JavaClass.get('SUCCESSINTENT_APIID')
    * print SUCCESSINTENT_APIID
    
    
    Scenario: containment metrics >>>>>> CONVERSATIONGRAPH_API
    * def Payload = 
     """
     {
    "filters": {
        "from": "2022-07-07",
        "to": "2022-07-09",
        "aggregationType": "hours",
        "channels": [],
        "language": [],
        "tags": {},
        "sessionCategory": []
    },
    "sessionType": "all"
}
      """
    * set Payload.filters.from = past
    * set Payload.filters.to = today
    Given path '/builder/streams/'+PstreamId+'/containmentmetrics/Conversations'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request Payload
    When method post
    Then status 200
    * print response
    * def CONVERSATIONGRAPH_APIID = response._id
    * JavaClass.add('CONVERSATIONGRAPH_APIID',CONVERSATIONGRAPH_APIID)
    * def CONVERSATIONGRAPH_APIID = JavaClass.get('CONVERSATIONGRAPH_APIID')
    * print CONVERSATIONGRAPH_APIID
    
    
    
    Scenario: containment metrics >>>>>> analysiscount
    * def Payload = 
    """
      {
    "filters": {
        "from": "2022-07-07T07:36:58.557Z",
        "to": "2022-07-08T07:37:36.943Z",
        "isDeveloper": false,
        "channel": [],
        "language": [],
        "tags": {},
        "sessionCategory": []
    },
    "type": "success"
}
     
      """
      * set Payload.filters.from = past
      * set Payload.filters.to = today
    Given path '/builder/streams/'+PstreamId+'/analysis/count'
    And param metrictype = 'containmentmetrics'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request Payload
    When method post
    Then status 200
    * print response
    * def analysiscount = response._id
    * JavaClass.add('analysiscount',analysiscount)
    * def analysiscount = JavaClass.get('analysiscount')
    * print analysiscount
    
    
    
    
    
    
    
    
     
    Scenario: containment metrics >>>>>> analysisFail Count
    * def Payload = 
      """
     {
    "filters": {
        "from": "2022-07-06T07:36:58.557Z",
        "to": "2022-07-07T07:37:36.943Z",
        "isDeveloper": false,
        "channel": [],
        "language": [],
        "tags": {},
        "sessionCategory": []
    },
    "type": "failintent"
}
      """
      * set Payload.filters.from = decrease
      * set Payload.filters.to = today
    Given path '/builder/streams/'+PstreamId+'/analysis/count'
    And param metrictype = 'containmentmetrics'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request Payload
    When method post
    Then status 200
    * print response
    * def analysisFailCount = response._id
    * JavaClass.add('analysisFailCount',analysisFailCount)
    * def analysisFailCount = JavaClass.get('analysisFailCount')
    * print analysisFailCount
    
    
    
    Scenario: containment metrics >>>>>> INTENT_API
    * def Payload = 
    """
       {
    "filters": {
        "from": "2022-07-07T07:36:58.557Z",
        "to": "2022-07-08T07:37:36.943Z",
        "limit": 13,
        "skip": 0,
        "channels": [],
        "language": [],
        "tags": {},
        "sessionCategory": []
    },
    "sessionType": "all"
}
      """
     * set Payload.set.filters = decrease
     * set Payload.filters.to = today
    Given path '/builder/streams/'+PstreamId+'/containmentmetrics/intents'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request Payload
    When method post
    Then status 200
    * print response
    * def INTENT_APIID = response._id
    * JavaClass.add('INTENT_APIID',INTENT_APIID)
    * def INTENT_APIID = JavaClass.get('INTENT_APIID')
    * print INTENT_APIID
    
    
    
    
    Scenario: containment metrics >>>>>> engagementinsghts
    * def Payload = 
    """
      {
    "filters": {
        "from": "2022-07-07T07:36:58.557Z",
        "to": "2022-07-08T07:37:36.943Z",
        "channels": [],
        "language": [],
        "tags": {},
        "sessionCategory": []
    },
    "sessionType": "all"
}
      """
    * set Payload.set.filters = decrease
    * set Payload.filters.to = today
    Given path '/builder/streams/'+PstreamId+'/containmentmetrics/engagementinsghts'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request Payload
    When method post
    Then status 200
    * print response
    * def engagementinsghtsID = response._id
    * JavaClass.add('engagementinsghtsID',engagementinsghtsID)
    * def engagementinsghtsID = JavaClass.get('engagementinsghtsID')
    * print engagementinsghtsID
    
    
      
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
 
  
  Scenario: dockstatus api
   * def SUCCESSINTENT_APIID = JavaClass.get('SUCCESSINTENT_APIID')
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
    #* def id = response.find(x => x._id == engagementinsghtsID).response.analysisCounts.messages[0].count
    #* print id
    
    
    
    
    
    