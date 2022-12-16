@R10.0
Feature: feature to Send the Proactive Notification using MS Teams Channel

  Scenario: Sending the Proactive Notification using MS Teams Channel
  
  * def JavaClass = Java.type('data.HashMap')
  * def slackdockStatusID = JavaClass.get('slackdockStatusID')
  
  Given url 'https://qa1-bots.kore.ai/api/public/bot/st-b6bb88de-40a8-5087-8b54-3f35fb042fd4/notify/status/'+slackdockStatusID+''
  And header Content-Type = 'application/json'
  And header auth = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiYXBwSWQiOiJjcy05NjkxNWY5MS03NzM1LTU4NGMtYWM4Ni1kZGRmYjM5MzhmOTAifQ.MTLIqmXnbwRSbgCoEdCSNHstWOhzcVq858o3zY96llY'
  And method get
  Then status 200
  And print 'Response is: ', response
  And match response.status == 'SUCCESS'
  And string convert_num_to_string = response.percentageComplete
  And match convert_num_to_string == '100'