Feature: Validating UnhandledUtterenecs

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

  Scenario: USERS_STATS_API With filter Sevendays
    * def Payload =
      """
      {
        "filters": {
            "from": "2022-07-18T10:53:56.689Z",
            "to": "2022-07-23T10:53:56.690Z",
            "sessionStatus": "all",
            "sessionCategory": [
                0,
                1
            ]
        },
        "type": "unhandledutterance",
        "sort": {
            "order": "desc",
            "by": "timestamp"
        },
        "ignoreCount": false,
        "groupby": ""
      }
      """
    * set Payload.filters.from = SevenDays
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
    * match $..status == ["IN_PROGRESS"]
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

  Scenario: dockstatus of UNHANDLEDUTTERANCE_API
    Given path '/builder/streams/'+PstreamId+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    * def koralogstatusId1 = response[0].response.result[1].records[0].koralogstatusId
    * def koralogstatusId2 = response[0].response.result[0].records[0].koralogstatusId
    * def Taskname1 = response[0].response.result[0].records[0].resourceInfo.name
    * def Taskname2 = response[0].response.result[1].records[0].resourceInfo.name
    * def Utterence1 = response[0].response.result[0].records[0].input
    * def utterence2 = response[0].response.result[1].records[0].input
    * JavaClass.add('Utterence1', Utterence1)
    * JavaClass.add('utterence2', utterence2)
    * JavaClass.add('Taskname1', Taskname1)
    * JavaClass.add('Taskname2', Taskname2)
    * JavaClass.add('koralogstatusId1', koralogstatusId1)
    * JavaClass.add('koralogstatusId2', koralogstatusId2)
    * def koralogstatusId1 = JavaClass.get('koralogstatusId1')
    * def utterence2 = JavaClass.get('utterence2')
    * print koralogstatusId1
    * print Taskname1
    * print Taskname2
    * print Utterence1
    * print utterence2
    And match response[0].response.result[0].records[0].input == 'abcd'
    And match response[0].response.result[0].records[0].resourceInfo.name == 'DefaultTask'
    And match response[0].response.result[0].records[0].resourceInfo.nodeType == 'message'
    And match response[0].response.result[0].records[0].resourceInfo.nodeId == 'message1'
    And match response[0].response.result[0].records[0].resourceInfo.nodeName == 'BotResponse5'
    And match response[0].response.result[1].records[0].input == 'kore'
    And match response[0].response.result[1].records[0].resourceInfo.name == 'SendEmail'
    And match response[0].response.result[1].records[0].resourceInfo.nodeType == 'Confirmation'
    And match response[0].response.result[1].records[0].resourceInfo.nodeId == 'dialogAct3'
    And match response[0].response.result[1].records[0].resourceInfo.nodeName == 'Confirmation0001'
    * def StandardResponse = response[0].response.result[0].records[0].type
    * print StandardResponse
     * JavaClass.add('StandardResponse', StandardResponse)
     * def Confirmation = response[0].response.result[1].records[0].type
     * print Confirmation
     * JavaClass.add('Confirmation', Confirmation)
     * def entityretry = response[0].response.result[2].records[0].type
     * print entityretry
     * JavaClass.add('entityretry', entityretry)
    

  Scenario: dockstatus of UNHANDLEDUTTERANCE_API with  Entity
    * def utterence2 = JavaClass.get('utterence2')
    * def Taskname2 = JavaClass.get('Taskname2')
    * def koralogstatusId1 = JavaClass.get('koralogstatusId1')
    Given path '/builder/streams/'+PstreamId+'/analysis/detail/'+koralogstatusId1
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    #And match response.task == Taskname
    And match response.NLAnalysis.nlProcessing.wordAnalysis[0].original == utterence2
    And match response.NLAnalysis.finalResolver.ranking[0].intent == Taskname2
    And match response.nluLanguage == 'en'

  Scenario: dockstatus of UNHANDLEDUTTERANCE_API with Confirmation
    * def Utterence1 = JavaClass.get('Utterence1')
    * def Taskname2 = JavaClass.get('Taskname2')
    * def koralogstatusId2 = JavaClass.get('koralogstatusId2')
    Given path '/builder/streams/'+PstreamId+'/analysis/detail/'+koralogstatusId2
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    #And match response.task == Taskname
    And match response.NLAnalysis.nlProcessing.wordAnalysis[0].original == Utterence1
    And match response.NLAnalysis.finalResolver.ranking[0].intent == Taskname2
    And match response.nluLanguage == 'en'
