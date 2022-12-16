@kore2
Feature:createbot

Background: 
    * url appUrl
    * def userId = ids.userId
    * def accessToken = ids.accessToken
    Scenario: Publish
  
    * def JavaClass = Java.type('data.HashMap')
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    *  def SendEmailDialogID1 = JavaClass.get('SendEmailDialogID1')
    * print SendEmailDialogID1
    * print SanityBotStreamId
    * def Payload = read('PublishChannel.json')
    * set Payload.resources[0].resourceId = SendEmailDialogID1
    * print Payload
    Given path '/builder/streams/'+SanityBotStreamId+'/standardpublish'
    And request Payload 
   
    And header Authorization = 'bearer '+accessToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response