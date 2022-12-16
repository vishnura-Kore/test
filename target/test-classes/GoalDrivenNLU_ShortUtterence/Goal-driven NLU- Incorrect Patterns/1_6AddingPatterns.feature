Feature: feature for adding patterens and  validating scenarios
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

  Scenario: Getting all DialogIds present in the  bot
    Given path '/builder/streams/'+streamId+'/components'
    And param type = 'intent'
    And param status = 'configured'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print response
    * def DialogId = response[0]._id
     * def DialogId1 = response[1]._id
      * def DialogId2 = response[2]._id
    * def name = response[0].name
    * JavaClass.add('DialogId1', DialogId1)
    * JavaClass.add('DialogId', DialogId)
     * JavaClass.add('DialogId2', DialogId2)
    * print DialogId
    * print DialogId1
    * print name
    

    Scenario: Adding patteren to dialogTask
    * def DialogId = JavaClass.get('DialogId')
     Given path '/builder/streams/'+streamId+'/components/'+DialogId+'/patterns'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'put'
    And request 
    """
    {
    "patterns": [
        "validating the patteren",
        "[validating wrong patteren"
    ]
}
    """
    When method post
    Then status 200
    And print 'Response is: ', response
   
   
    Scenario: Adding patteren to dialogTask
    * def DialogId1 = JavaClass.get('DialogId1')
     Given path '/builder/streams/'+streamId+'/components/'+DialogId1+'/patterns'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'put'
    And request 
    """
    {
    "patterns": [
        "how are you",
        "[what is your age"
    ]
}
    """
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
    Scenario: Adding patteren to dialogTask
    * def DialogId2 = JavaClass.get('DialogId2')
     Given path '/builder/streams/'+streamId+'/components/'+DialogId2+'/patterns'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header x-http-method-override = 'put'
    And request 
    """
    {
    "patterns": [
        "tomorrow is holiday",
        "[tomorrow is working day",
       
    ]
}
    """
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
   
   
    
    
    