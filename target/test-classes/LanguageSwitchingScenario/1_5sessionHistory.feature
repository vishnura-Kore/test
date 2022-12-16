Feature: scenarios to get messages request
Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def streamId = JavaClass.get('streamId')
     * def botadminUserID1 = JavaClass.get('botadminUserID1')
     * def accessToken = JavaClass.get('accessToken')
     * def botadminorgID1 = JavaClass.get('botadminorgID1')
     * def botName = JavaClass.get('botName')
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
  


Scenario: Positive Scenario Conversation History API 
  * def Payload = 
  """
  {
    "type": "successintent",
    "filters": {
        "from": "2022-10-18T07:08:16.621Z",
        "to": "2022-10-19T07:08:16.622Z",
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
  * set Payload.filters.from = OnedaysFilter
  * set Payload.filters.to = today
    Given path '/builder/streams/'+streamId+'/analysis'
    And param userId = botadminUserID1
    And param from = today
    And param mode = 'async'
    And param offset = '0'
    And param limit = '20'
    And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
   
   
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
   
    
    
    
    
    Scenario: Positive Scenario getting Conversation History API 
    Given path '/builder/streams/'+streamId+'/dockStatus'
     And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
   * def userid = response[0].response.users[0]._id
   * print userid
     * JavaClass.add('userid', userid)
    
    
    
    
    
    
  
  Scenario: Positive Scenario Conversation History API for getting messages
  * def userid = JavaClass.get('userid')
    Given url publicUrl
    Then path '/public/stream/'+streamId+'/getMessages'
    And param userId = userid
    And param channelType = 'ivr'
    And param dateFrom = OnedaysFilter
    And param dateTo = today
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..text contains "De nada"
  