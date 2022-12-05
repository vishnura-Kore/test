@R10.0
Feature: RunTime Scenarios

  Background: 
    * url jwturl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def streamId = JavaClass.get('streamId')
     
  Scenario: Login into the Bot Builder
    Given url appUrl
    And path 'oauth/token'
    When request { "password":'#(password)', "client_id":"1", "client_secret":"1","scope":"friends","grant_type":"password","username":'#(username)' }
    And method post
    Then status 200
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('accountID', response.authorization.accountId)
    * JavaClass.add('accessToken', response.authorization.accessToken)
    * JavaClass.add('userId',response.userInfo.id)
    * JavaClass.add('orgID', response.userInfo.orgID )
    And print 'Response is: ', response  
    
  
  Scenario: Getting the Available Requests count
    * def JavaClass = Java.type('data.HashMap')
    * def streamID = JavaClass.get('streamId')
    * def accountID = JavaClass.get('accountID')
    * def accessToken = JavaClass.get('accessToken')
    * def userId = JavaClass.get('userId')
  
    Given url appUrl
    And path 'users/'+userId+'/builder/streams/'+streamId+''
    And header Content-Type = 'application/json'
    And header AccountId = accountID
    And header Authorization = 'bearer '+accessToken
    And method get
    Then status 200
    And print 'Response is: ', response
    #* JavaClass.add('freeAvailableRequests', response.accountLicense.freeAvailableRequests)
    #* JavaClass.add('freeAllowedRequests', response.accountLicense.freeAllowedRequests)

  Scenario: Generating JWT Token
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
    * def ConsumerWebHookJWT = response.jwt
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('ConsumerWebHookJWT', ConsumerWebHookJWT)
    And print  'Response is ' , response

  Scenario: input Intent
    * def Payload =
      """
        {
        "message": {
            "text": "Book a Flight"
        },
        "from": {
            "id": "Webhook"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.text contains 'Select an option'
    And match response.text contains 'Book a Flight from Delhi to Hyderabad'
    And match response.text contains 'Book a Flight from Hyderabad to Delhi' 
    
    
    Scenario: input Flight Booking
    * def Payload =
      """
        {
        "message": {
            "text": "Book a Flight from Hyderabad to Delhi"
        },
        "from": {
            "id": "Webhook"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.text[0] == 'Book a Flight from Hyderabad to Delhi'
    And match response.completedTaskName == 'book a flight from hyderabad to delhi'
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('completedTaskId', response.completedTaskId)
    * def taskID = response.completedTaskId
    * print taskID
    
    Scenario: Scheduler Call
    Given url appUrl
    And path 'schedule'
    And header Postman-Token = '0f84b4fb-40e0-455b-a535-6c4899447955'
    When method get
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
    
    Scenario: Getting the Available Requests count after the usage
    * def JavaClass = Java.type('data.HashMap')
    * def streamID = JavaClass.get('streamId')
    * def accountID = JavaClass.get('accountID')
    * def accessToken = JavaClass.get('accessToken')
    * def userId = JavaClass.get('userId')
  
    Given url appUrl
    And path 'users/'+userId+'/builder/streams/'+streamId+''
    And header Content-Type = 'application/json'
    And header AccountId = accountID
    And header Authorization = 'bearer '+accessToken
    And method get
    Then status 200
    And print 'Response is: ', response
    #* JavaClass.add('freeAvailableRequestsUsed', response.accountLicense.freeAvailableRequests)
    #* JavaClass.add('freeAllowedRequestsUsed', response.accountLicense.freeAllowedRequests)
    * def freeAvailableRequestsUsed = response.accountLicense.freeAvailableRequests
    * def freeAllowedRequestsUsed = response.accountLicense.freeAllowedRequests
    * print freeAvailableRequestsUsed
    * print freeAllowedRequestsUsed
    
    
    
    
    
    
    
