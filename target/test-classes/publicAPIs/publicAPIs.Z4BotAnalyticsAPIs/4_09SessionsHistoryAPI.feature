Feature: Sessions History API For BAC and Bot with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def Botname = JavaClass.get('Botname')
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
    * def decrease = JavaMethods.getdecrementdays(-2,'yyyy-MM-dd',"'T'HH:mm:ss.SSS'Z'")
    * def past = JavaMethods.ConvertDateFormat(decrease,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    * print past
    * print today

  Scenario: Positive Scenario Sessions History API For BOT with filter selfService
    * def Body =
      """
      {
      "skip": 0,
      "limit": 100,
      "dateFrom": "2022-09-03T13:50:49.494Z",
      "dateTo": "2022-09-05T13:50:49.494Z"
      }
      """
    * set Body.dateFrom = past
    * set Body.dateTo = today
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/getSessions'
    And param containmentType = 'selfService'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Body
    When method post
    Then status 200
    And print 'Response is: ', response
     * def Sessioncount = response.total
    * print Sessioncount
    And match response.sessions[0].sessionStatus == "active"

  Scenario: Positive Scenario Sessions History API For BOT with filter agent
    * def Body =
      """
      {
      "skip": 0,
      "limit": 100,
      "dateFrom": "2022-09-03T13:50:49.494Z",
      "dateTo": "2022-09-05T13:50:49.494Z"
      }
      """
    * set Body.dateFrom = past
    * set Body.dateTo = today
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/getSessions'
    And param containmentType = 'agent'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Body
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: Positive Scenario Sessions History API For BOT with filter dropOff
    * def Body =
      """
      {
      "skip": 0,
      "limit": 100,
      "dateFrom": "2022-09-03T13:50:49.494Z",
      "dateTo": "2022-09-05T13:50:49.494Z"
      }
      """
    * set Body.dateFrom = past
    * set Body.dateTo = today
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/getSessions'
    And param containmentType = 'dropOff'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Body
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: Positive Scenario Sessions History API For BAC with filter selfService
    * def Body =
      """
      {
      "skip": 0,
      "limit": 100,
      "dateFrom": "2022-09-03T13:50:49.494Z",
      "dateTo": "2022-09-05T13:50:49.494Z"
      }
      """
    * set Body.dateFrom = past
    * set Body.dateTo = today
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/getSessions'
    And param containmentType = 'selfService'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Body
    When method post
    Then status 200
    And print 'Response is: ', response
     * def SessioncountBeforeClosure = response.total
     * print SessioncountBeforeClosure 

  Scenario: Positive Scenario Sessions History API For BAC with filter dropOff
    * def Body =
      """
      {
      "skip": 0,
      "limit": 100,
      "dateFrom": "2022-09-03T13:50:49.494Z",
      "dateTo": "2022-09-05T13:50:49.494Z"
      }
      """
    * set Body.dateFrom = past
    * set Body.dateTo = today
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/getSessions'
    And param containmentType = 'dropOff'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Body
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: Positive Scenario Sessions History API For BAC with filter agent
    * def Body =
      """
      {
      "skip": 0,
      "limit": 100,
      "dateFrom": "2022-09-03T13:50:49.494Z",
      "dateTo": "2022-09-05T13:50:49.494Z"
      }
      """
    * set Body.dateFrom = past
    * set Body.dateTo = today
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/getSessions'
    And param containmentType = 'agent'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Body
    When method post
    Then status 200
    And print 'Response is: ', response
