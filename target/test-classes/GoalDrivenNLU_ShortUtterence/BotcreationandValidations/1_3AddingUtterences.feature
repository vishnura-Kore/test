Feature: feature for adding Shortutterence and  validating scenarios
  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    * print SanityBotStreamId

  Scenario: Getting all TaskIds present in the  bot
    Given path '/builder/streams/'+SanityBotStreamId+'/components'
    And param type = 'intent'
    And param status = 'configured'
  And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print response
    * def taskId = response[0]._id
    * def name = response[0].name
    * JavaClass.add('taskId', taskId)
    * print taskId
    * print name
    

    Scenario: Adding Two words utterence to dialogTask
    * def taskId = JavaClass.get('taskId')
    * def Payload = read('TwoWordsUtterence.json')
    * set Payload.taskId = taskId
    * set Payload.streamId = SanityBotStreamId
    * set Payload.taskName = 'SendEmail'
     Given path '/users/'+botadminUserID1+'/builder/sentences'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $.nluRules..severity == ["Warning"]
    * def wordCount = response.nluRules.shortUtterance.wordCount
    * print wordCount
    * def utteranceCount = $.nluRules..utteranceCount
    * print utteranceCount
    * def Id = response._id
    * JavaClass.add('Id', Id)
    
     
   
    
    
    
    Scenario: Adding single word utterence to dialogTask
     * def taskId = JavaClass.get('taskId')
    * def Payload = read('SingleWordUtterence.json')
    * set Payload.taskId = taskId
    * set Payload.streamId = SanityBotStreamId
    * set Payload.taskName = 'SendEmail'
     Given path '/users/'+botadminUserID1+'/builder/sentences'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $.nluRules..severity == ["Warning"]
    * def wordCount = response.nluRules.shortUtterance.wordCount
    * print wordCount
    * def utteranceCount =  $.nluRules..utteranceCount
    * print utteranceCount
    * def Id1 = response._id
    * JavaClass.add('Id1', Id1)
   
   
     Scenario: Adding Morethan 2 words utterence to dialogTask
      * def taskId = JavaClass.get('taskId')
    * def Payload = read('morethan2WordsUtterence.json')
    * set Payload.taskId = taskId
    * set Payload.streamId = SanityBotStreamId
    * set Payload.taskName = 'SendEmail'
     Given path '/users/'+botadminUserID1+'/builder/sentences'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.nluRules == '#notpresent'
   
    
    Scenario: Publish
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    Given url publicUrl
    Then path '/public/bot/'+SanityBotStreamId+'/publish'
    And request
      """
      {
      "versionComment": "new update"
      }
      """
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
    
   
    
    Scenario: Updating  Two words utterence with one word utterence to dialogTask
    * def taskId = JavaClass.get('taskId')
     * def Id = JavaClass.get('Id')
    * def Payload = read('UpdatinTwoWordsUtterencewith1word.json')
    * set Payload.taskId = taskId
    * set Payload.streamId = SanityBotStreamId
    * set Payload.taskName = 'SendEmail'
     Given path '/users/'+botadminUserID1+'/builder/sentences/'+Id
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header X-HTTP-Method-Override = 'put'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $.nluRules..severity == ["Warning"]
    * def wordCount = response.nluRules.shortUtterance.wordCount
    * print wordCount
    * def utteranceCount = $.nluRules..utteranceCount
    * print utteranceCount
    
    
    Scenario: Getting all DialogIds present in the bot
     Given path '/builder/streams/'+SanityBotStreamId+'/dialogs'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print response
    * def DialogTask = response[0]._id
    * JavaClass.add('DialogTask', DialogTask)
    * print DialogTask
    
    
    
    Scenario: upgrading the utterences
    * def DialogTask = JavaClass.get('DialogTask')
     Given path '/builder/streams/'+SanityBotStreamId+'/dialogs/'+DialogTask+'/upgrade'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header X-HTTP-Method-Override = 'put'
    And request 
    """
     {}
    """
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
    
     Scenario: Updating One word utterence with Three word utterence to dialogTask
    * def taskId = JavaClass.get('taskId')
     * def Id1 = JavaClass.get('Id1')
    * def Payload = read('UpdatingOneWordsUtterencewith3word.json')
    * set Payload.taskId = taskId
    * set Payload.streamId = SanityBotStreamId
    * set Payload.taskName = 'SendEmail'
     Given path '/users/'+botadminUserID1+'/builder/sentences/'+Id1
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header X-HTTP-Method-Override = 'put'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.nluRules == '#notpresent'
   
   
    
   
    
    
   
    
    
    
    
    
    
    
   
    
     
    
   
