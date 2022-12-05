@R10.0
Feature: feature to Send the Proactive Notification using MS Teams Channel

  Scenario: Sending the Proactive Notification using MS Teams Channel
  
  Given url 'https://qa1-bots.kore.ai/api/public/bot/st-b6bb88de-40a8-5087-8b54-3f35fb042fd4/notify'
  * def Payload = read('SlackPayload.json')
  And request Payload
  And header Content-Type = 'application/json'
  And header auth = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiYXBwSWQiOiJjcy05NjkxNWY5MS03NzM1LTU4NGMtYWM4Ni1kZGRmYjM5MzhmOTAifQ.MTLIqmXnbwRSbgCoEdCSNHstWOhzcVq858o3zY96llY'
  And method post
  Then status 200
  And print 'Response is: ', response
  * def JavaClass = Java.type('data.HashMap')
  * JavaClass.add('slackdockStatusID', response._id)
  
   * def sleep =
      """
      function(seconds){
        for(i = 0; i <= seconds; i++)
        {
          java.lang.Thread.sleep(1*6000);
          karate.log(i);
        }
      }
      """
    * call sleep 6