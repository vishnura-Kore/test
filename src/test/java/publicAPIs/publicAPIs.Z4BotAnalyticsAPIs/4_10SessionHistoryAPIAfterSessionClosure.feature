
 Feature: RunTime Scenarios

  Background: 
    * url jwturl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
     * def JWTToken = JavaClass.get('JWTToken')
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

 
 Scenario: Generatinng JWT Token for Webhook Channel
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def smartclientsecret1 = JavaClass.get('smartclientsecret1')
    * def userID1 = JavaClass.get('userID1')
    * print userID1
    * print smartclientId1
    * print smartclientsecret1
    * def Payload =
      """
       {
       "clientId": "smartclientId1",
       "clientSecret": "smartclientsecret1",
       "identity": "userID1",
       "aud": "",
       "isAnonymous": true
      }
      """
    * set Payload.clientId = smartclientId1
    * set Payload.identity = userID1
    * set Payload.clientSecret = smartclientsecret1
    * print Payload
    And request Payload
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def ConsumerWebHookJWT2 = response.jwt
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('ConsumerWebHookJWT2', ConsumerWebHookJWT2)
    And print  'Response is ' , response
    
    
    
    
      Scenario: input Current weather
    * def Payload =
      """
        {
        "message": {
            "text": "Current weather"
        },
        "from": {
            "id": "kore123"
        },
        "to": {
            "id": "4321"
        }
        }
      """
  
    * def ConsumerWebHookJWT2 = JavaClass.get('ConsumerWebHookJWT2')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanitystreamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT2
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
     #Scenario: input hyderabad
    * def Payload =
      """
        {
        "message": {
            "text": "hyderabad"
        },
        "from": {
            "id": "kore123"
        },
        "to": {
            "id": "4321"
        }
        }
      """
  
    * def ConsumerWebHookJWT2 = JavaClass.get('ConsumerWebHookJWT2')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanitystreamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT2
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
      #Scenario: input 
    * def Payload =
      """
        {
        "message": {
            "text": "okay"
        },
        "from": {
            "id": "kore123"
        },
        "to": {
            "id": "4321"
        }
        }
      """
  
    * def ConsumerWebHookJWT2 = JavaClass.get('ConsumerWebHookJWT2')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanitystreamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT2
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
      Scenario: input  Show balance 
    * def Payload =
      """
        {
        "message": {
            "text": "Show Balance"
        },
        "from": {
            "id": "kore1234"
        },
        "to": {
            "id": "4321"
        }
        }
      """
  
    * def ConsumerWebHookJWT2 = JavaClass.get('ConsumerWebHookJWT2')
   
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanitystreamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT2
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
      #Scenario: input  Savings
    * def Payload =
      """
        {
        "message": {
            "text": "Savings"
        },
        "from": {
            "id": "kore1234"
        },
        "to": {
            "id": "4321"
        }
        }
      """
  
    * def ConsumerWebHookJWT2 = JavaClass.get('ConsumerWebHookJWT2')
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanitystreamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT2
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
     #Scenario: input  Savings
    * def Payload =
      """
        {
        "message": {
            "text": "okay"
        },
        "from": {
            "id": "kore1234"
        },
        "to": {
            "id": "4321"
        }
        }
      """
  
    * def ConsumerWebHookJWT2 = JavaClass.get('ConsumerWebHookJWT2')
    * print ConsumerWebHookJWT2
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanitystreamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT2
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
      Scenario: input  Savings
    * def Payload =
      """
        {
        "message": {
            "text": "Book Appointment"
        },
        "from": {
            "id": "kore1234"
        },
        "to": {
            "id": "4321"
        }
        }
      """
  
    * def ConsumerWebHookJWT2 = JavaClass.get('ConsumerWebHookJWT2')
    * print ConsumerWebHookJWT2
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanitystreamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT2
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
      Scenario: input  Savings
    * def Payload =
      """
        {
        "message": {
            "text": "discard all"
        },
        "from": {
            "id": "kore1234"
        },
        "to": {
            "id": "4321"
        }
        }
      """
  
    * def ConsumerWebHookJWT2 = JavaClass.get('ConsumerWebHookJWT2')
    * print ConsumerWebHookJWT2
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanitystreamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT2
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
     Scenario: input  KoreUtilCloseConversation
    * def Payload =
      """
        {
        "message": {
            "text": "KoreUtilCloseConversation"
        },
        "from": {
            "id": "kore1235"
        },
        "to": {
            "id": "4321"
        }
        }
      """
  
    * def ConsumerWebHookJWT2 = JavaClass.get('ConsumerWebHookJWT2')
    * print ConsumerWebHookJWT2
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+SanitystreamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT2
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
     Scenario: Positive Scenario Sessions History API For BOT with filter selfService
      * def SessioncountBeforeClosure = JavaClass.get('SessioncountBeforeClosure')
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
    
    * def SessioncountAfterClosure = response.total
    * print SessioncountAfterClosure
    And match response.sessions[0].sessionStatus == "closed"
    And match response.total != SessioncountBeforeClosure
   
    
    
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
    
    