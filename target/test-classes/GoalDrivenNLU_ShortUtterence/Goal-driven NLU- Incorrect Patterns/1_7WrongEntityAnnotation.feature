Feature: Adding wrong entity Annotations and validating

Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def streamId = JavaClass.get('streamId')
    * print streamId

  Scenario: Getting all TaskIds present in the  bot
    Given path '/builder/streams/'+streamId+'/components'
    And param type = 'intent'
    And param status = 'configured'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print response
    * def name = 'SendEmail'
    * print name
    * def taskId = response.find(x => x.name == name)._id
    * print taskId
    * JavaClass.add('taskId', taskId)
    * print taskId
    
     Scenario: Getting all EntityIds present in the  bot
    Given path '/builder/streams/'+streamId+'/components'
    And param type = 'entity'
    And param status = 'configured'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print response
    * def name = 'email'
    * print name
    * def entityId = response.find(x => x.name == name)._id
    * print entityId
    * JavaClass.add('entityId', entityId)
    * print entityId
    
    Scenario: Adding Wrong Annotation to dialogTask
    * def taskId = JavaClass.get('taskId')
    * def Payload = read('Payload.json')
    * set Payload.taskId = taskId
    * set Payload.streamId = streamId
    * set Payload.taskName = 'SendEmail'
     Given path '/users/'+botadminUserID1+'/builder/sentences'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def Id = response._id
    * JavaClass.add('Id', Id)
    * print Id
    
    
    
    Scenario: adding wrong annotation to dialogTask
    * def Id = JavaClass.get('Id')
    * def taskId = JavaClass.get('taskId')
    * def entityId = JavaClass.get('entityId')
    
    * def Payload = 
    """
    {
    "taskId": "dc-6882191f-fd50-568c-bb23-71c4749d9460",
    "sentence": "send me an email",
    "streamId": "st-b8b07315-9330-5f36-8603-f00c03d4b645",
    "taskName": "SendEmail",
    "type": "DialogIntent",
    "entities": [
        {
            "startIndex": 5,
            "endIndex": 7,
            "entityId": "dc-56df7bf4-665f-5f5c-aa25-f69d0ed21001"
        }
    ]
}
    """
    * set Payload.taskId = taskId
    * set Payload.streamId = streamId
    * set Payload.entities[0].entityId = entityId
    * set Payload.taskName = 'SendEmail'
     Given path '/users/'+botadminUserID1+'/builder/sentences/'+Id
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'put'
    When method post
    Then status 200
    And print 'Response is: ', response
  
   
    
    
     Scenario: triggerValidatePatterns
    Then path '/streams/'+streamId+'/triggerValidatePatterns'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And param language = 'en'
    And param process = 'refreshValidation'
    When method get
    Then status 200
    And print responseTime
    And print response
   
   
    Scenario: dockstatus
     Given path '/builder/streams/'+streamId+'/dockStatus'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
   
   
 
   
   Scenario: getBotLevelValidations
     Given path '/streams/'+streamId+'/getBotLevelValidations'
     And param language = 'en'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID1
    When method get
    Then status 200
    And print 'Response is: ', response
    * def inCorrectPatterns = response.inCorrectPatterns
    * def shortUtterance = response.shortUtterance
    * def inadequateTrainingUtterances = response.inadequateTrainingUtterances
    * def untrainedIntents = response.untrainedIntents
    * print untrainedIntents
    * print inCorrectPatterns
    * print inadequateTrainingUtterances
    * print shortUtterance
   
    
    
    
    
    
    
    
    