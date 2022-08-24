@runtime
Feature: Enable channel and creating app

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def streamId = JavaClass.get('streamId')

  Scenario: creating a intent component
    * def Payload =
      """
      {
      "desc": "taska",
      "type": "intent",
      "intent": "busticket",
      "preConditions": []
      }
      """
    Given path '/builder/streams/'+streamId+'/components'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method post
    Then status 200
    * print response
    * def componentId = response._id
    * JavaClass.add('componentId', componentId)
    * print componentId

  Scenario: Creating a DialogTask With subintent
    * def componentId = JavaClass.get('componentId')
    Given path '/builder/streams/'+streamId+'/dialogs'
    * def payload = read("Dialog.json")
    * set payload.nodes[0].componentId = componentId
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    And request payload
    When method post
    Then status 200
    * print response
    * def TaskId = response._id
    * JavaClass.add('TaskId', TaskId)
    * print TaskId

  Scenario: Adding Utterence to the dialog task which is created with subintent
    * def componentId = JavaClass.get('componentId')
    * def Payload =
      """
      {
      "taskId": "dc-571f5047-7476-5cdc-b006-494c64b24282",
      "sentence": "Book a ticket to hyderabad",
      "streamId": "st-7d4678dc-9ca0-543a-b880-01d30ea5d57e",
      "taskName": "busticket",
      "type": "DialogIntent",
      "predictiveNer": true
      }
      """
    * set Payload.taskId = componentId
    * set Payload.streamId = streamId
    Given path '/users/'+botadminUserID1+'/builder/sentences'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    * print response
    * def MlutterenceId = response._id



Scenario: Training the bot
   
    Given path '/users/'+botadminUserID1+'/builder/sentences/ml/train'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And param streamId = streamId
    And request 
    """
    {}
    """
    When method post
    Then status 200
    And print 'Response is: ', response



  Scenario: getting the Training status of the bot 
 
    Given path '/users/'+botadminUserID1+'/bt/streams/'+streamId+'/autoTrainStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And param sentences = 'true'
    And param speech = 'false'
    And retry until response.trainingStatus == 'Finished' || response.status == 'Failed'
    When method get
    Then status 200
    And print 'Response is: ', response


Scenario: Negative Scenario without disabling multi intent model checking key value is present or not
   * def Botname = JavaClass.get('Botname')
   
   * def payload = 
      """
      {
      "input": "Book a ticket to hyderabad",
      "streamName": "PublicConsumerbot3128",
      "timezone": "Asia/Calcutta",
      "isDeveloper": true
      }
      """
      * set payload.streamName = Botname
    Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId+'/findIntent'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header bot-language = 'en'
    And request payload
    When method post
    Then status 200
    * print response
    And match response.response.finalResolver.ranking[0].eliminationInfo.reason == '#notpresent'
   
    


  Scenario: getting app details
    Given path 'builder/streams/'+streamId+'/advancedNLSettings'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print 'Response is: ', response
    * def intentId = response[0]._id
    * JavaClass.add('intentId', intentId)
    * print intentId

  Scenario: Disbaling the Multiple intent Models
    * def intentId = JavaClass.get('intentId')
    Given path '/builder/streams/'+streamId+'/advancedNLSettings/'+intentId
    When request
      """
      {"configurationValue":false}
      """
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And header X-HTTP-Method-Override = 'put'
    And header bot-language = 'en'
    When method post
    Then status 200
    * print response
    
    
    Scenario: Training the bot
   
    Given path '/users/'+botadminUserID1+'/builder/sentences/ml/train'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And param streamId = streamId
    And request 
    """
    {}
    """
    When method post
    Then status 200
    And print 'Response is: ', response



  Scenario: Getting the Training status of the bot
 
    Given path '/users/'+botadminUserID1+'/bt/streams/'+streamId+'/autoTrainStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And param sentences = 'true'
    And param speech = 'false'
    And retry until response.trainingStatus == 'Finished' || response.status == 'Failed'
    When method get
    Then status 200
    And print 'Response is: ', response

  Scenario: Positive Scenario >>>>>.... Checking whether key is present in the respose or not
   * def Botname = JavaClass.get('Botname')
   
   * def payload = 
      """
      {
      "input": "Book a ticket to hyderabad",
      "streamName": "PublicConsumerbot3128",
      "timezone": "Asia/Calcutta",
      "isDeveloper": true
      }
      """
      * set payload.streamName = Botname
    Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId+'/findIntent'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header bot-language = 'en'
    And request payload
    When method post
    Then status 200
    * print response
    And match response.response.finalResolver.ranking[0].eliminationInfo.reason == "subIntent"
    
   
   
