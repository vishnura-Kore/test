@kore
Feature: Validating conversation dashboard on NLP APIS

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
  Scenario: NLP Metrics >>>>>> SUCCESSINTENT_API
  * def Payload = 
  """
      {
        "type": "successintent",
        "filters": {
            "from": "2022-07-07",
            "to": "2022-07-09",
            "sessionStatus": "all",
            "sessionCategory": [
                0,
                1
            ]
        },
        "groupby": "input",
        "sort": {
            "order": "desc",
            "by": "timestamp"
        },
        "ignoreCount": false
      }
      """
      * set Payload.filters.from = past
       * set Payload.filters.to = today
    Given path '/builder/streams/'+PstreamId+'/analysis'
    And param offset = '0'
    And param limit = '20'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request Payload
      
    When method post
    Then status 200
    * print response
  

  Scenario: NLP Metrics >>>>>>>>>>>>>FAILINTENT_API
  * def Payload = 
  """
      {
        "filters": {
            "from": "2022-07-07",
            "to": "2022-07-09",
            "sessionStatus": "all",
            "sessionCategory": [
                0,
                1
            ]
        },
        "type": "failintent",
        "groupby": "input",
        "sort": {
            "order": "desc",
            "by": "timestamp"
        },
        "ignoreCount": false
      }
      """
      * set Payload.filters.from = past
      * set Payload.filters.to = today
    Given path '/builder/streams/'+PstreamId+'/analysis'
    And param offset = '0'
    And param limit = '20'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request Payload
      
    When method post
    Then status 200
    * print response

  Scenario: NLP Metrics >>>>>>>>>>>>>PROMPTTYPE
  * def Payload =
   """
      {
        "filters": {
            "from": "2022-07-07",
            "to": "2022-07-09",
            "sessionStatus": "all",
            "sessionCategory": [
                0,
                1
            ]
        },
        "type": "unhandledutterance",
        "groupby": "input",
        "sort": {
            "order": "desc",
            "by": "timestamp"
        },
        "ignoreCount": false
      }
      """
  * set Payload.filters.from = past
  * set Payload.filters.to = today
    Given path '/builder/streams/'+PstreamId+'/analysis'
    And param offset = '0'
    And param limit = '20'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request Payload
    When method post
    Then status 200
    * print response

  Scenario: NLP Metrics >>>>>>>>>>>>>FAILTASK_API
 * def Payload = 
 """
      {
        "filters": {
            "from": "2022-07-07",
            "to": "2022-07-09",
            "sessionStatus": "all",
            "sessionCategory": [
                0,
                1
            ]
        },
        "type": "failtask",
        "groupby": "input",
        "sort": {
            "order": "desc",
            "by": "timestamp"
        },
        "ignoreCount": false
      }
      """
      * set Payload.filters.from = past
      * set Payload.filters.to = today
    Given path '/builder/streams/'+PstreamId+'/analysis'
    And param offset = '0'
    And param limit = '20'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request Payload
      
    When method post
    Then status 200
    * print response

  Scenario: NLP Metrics >>>>>>>>>>>>>PERFORMANCE_API
  * def Payload = 
   """
      {
        "filters": {
            "from": "2022-07-08",
            "to": "2022-07-09"
        },
        "type": "performance",
        "groupby": "componentId",
        "sort": {
            "order": "desc",
            "by": "avg_res"
        },
        "ignoreCount": false
      }
      """
      * set Payload.filters.from = past
      * set Payload.filters.to = today
    Given path '/builder/streams/'+PstreamId+'/analysis'
    And param offset = '0'
    And param limit = '20'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request Payload
    When method post
    Then status 200
    * print response

  Scenario: NLP Metrics >>>>>>>>>>>>>PINNED_API
  * def Payload =
  """
      {
        "filters": {
            "from": "2022-07-07",
            "to": "2022-07-09",
            "pinnedBy": [
                "u-093524cf-9df9-5371-b28b-2813f18752dd"
            ]
        },
        "type": "pinned",
        "groupby": "input",
        "sort": {
            "order": "desc",
            "by": "timestamp"
        },
        "ignoreCount": false
      }
      """
      * set Payload.filters.from = past
       * set Payload.filters.from = today
    Given path '/builder/streams/'+PstreamId+'/analysis'
    And param offset = '0'
    And param limit = '20'
    And param mode = 'async'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header accountid = adminaccountID1
    And header Content-Type = 'application/json;charset=UTF-8'
    And request Payload
    When method post
    Then status 200
    * print response

  Scenario: NLP Metrics >>>>>>>>>>>>>debugLogs
  * def Payload = 
   """
      {
        "filters": {
            "fromDate": "2022-07-07",
            "toDate": "2022-07-09",
            "isDeveloper": true,
            "sort": {
                "order": "desc",
                "by": "timestamp"
            }
        }
      }
      """
  * set Payload.filters.from = past
  * set Payload.filters.to = today
    Given path '/builder/streams/'+PstreamId+'/debugLogs//fetch'
    And param offset = '0'
    And param limit = '20'
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
          java.lang.Thread.sleep(1*5000);
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
    #* def pinID = response[5].response.result[0].records[0]
    #* JavaClass.add('pinID',pinID);
    #* print pinID
    #
    #
    #
     #Scenario: NLP Metrics >>>>>>>>>>>>>Pining the task
     #* def pinID =JavaClass.get('pinID',pinID)
    #Given path '/builder/streams/'+PstreamId+'/analysis/pinID'
    #And param offset = '0'
    #And param limit = '20'
    #And param mode = 'async'
    #And header Authorization = 'bearer '+botadminaccesstokenuser1
    #And header accountid = adminaccountID1
    #And header Content-Type = 'application/json;charset=UTF-8'
    #And request
      #"""
      #{
       #"pinned":true
      #}
      #"""
    #When method post
    #Then status 200
    #* print response
    #
    #Scenario: NLP Metrics >>>>>>>>>>>>>PINNED_API
    #Given path '/builder/streams/'+PstreamId+'/analysis'
    #And param offset = '0'
    #And param limit = '20'
    #And param mode = 'async'
    #And header Authorization = 'bearer '+botadminaccesstokenuser1
    #And header accountid = adminaccountID1
    #And header Content-Type = 'application/json;charset=UTF-8'
    #And request
      #"""
      #{
        #"filters": {
            #"from": "2022-07-07T05:19:57.293Z",
            #"to": "2022-07-08T05:19:57.293Z",
            #"pinnedBy": [
                #"u-093524cf-9df9-5371-b28b-2813f18752dd"
            #]
        #},
        #"type": "pinned",
        #"groupby": "input",
        #"sort": {
            #"order": "desc",
            #"by": "timestamp"
        #},
        #"ignoreCount": false
      #}
      #"""
    #When method post
    #Then status 200
    #* print response
    #
    #Scenario: dockstatus api
   #
   #Given path '/builder/streams/'+PstreamId+'/dockStatus'
     #And header Authorization = 'bearer '+botadminaccesstokenuser1
    #And header Content-Type = 'application/json'
    #And header accountid = adminaccountID1 
    #And header Host = '<calculated when request is sent>'
    #And header bot-language = 'en'
    #And header state = 'configured'
     #
    #When method get
    #Then status 200
    #And print response
    #
    #
    #
    #
    #
