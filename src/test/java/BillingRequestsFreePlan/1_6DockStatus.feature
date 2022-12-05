@R10.0
Feature: feature to get dock status data

  Background: 
    * url publicUrl

  Scenario: Get the Billing session Dock status data

  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamId')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def JWTToken = JavaClass.get('JWTToken')
  
  Given path '/public/bot/'+streamID+'/billingsessionsummary/status'
  And header Content-Type = 'application/json'
  And header auth = JWTToken
  And param type = 'summary'
  And method get
  Then status 200
  And print 'Response is: ', response
  And string convert_num_to_string = response.response.data[0].val[1].val.requests
  And match convert_num_to_string == '3'
  And string convert_num_to_string = response.response.data[0].val[1].val.sessions
  And match convert_num_to_string == '0' 
  And string convert_num_to_string = response.response.data[0].val[1].val.proactive_notifications
  And match convert_num_to_string == '0'
  And string convert_num_to_string = response.response.data[0].val[1].val.alert_notifications
  And match convert_num_to_string == '0'
  And string convert_num_to_string = response.response.averageSessions
  And match convert_num_to_string == '3' 