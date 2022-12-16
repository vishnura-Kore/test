@R10.0
Feature: feature to get dock status data

  Background: 
    * url publicUrl

  Scenario: Get the Billing session Dock status data
  
  Given path '/public/bot/st-b6bb88de-40a8-5087-8b54-3f35fb042fd4/billingsessionsummary/status'
  And header Content-Type = 'application/json'
  And header auth = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiYXBwSWQiOiJjcy05NjkxNWY5MS03NzM1LTU4NGMtYWM4Ni1kZGRmYjM5MzhmOTAifQ.MTLIqmXnbwRSbgCoEdCSNHstWOhzcVq858o3zY96llY'
  And param type = 'summary'
  And method get
  Then status 200
  And print 'Response is: ', response
  
  * def JavaClass = Java.type('data.HashMap')
  * def convert_string_to_num = JavaClass.get('proactiveNotificationCount')
  * def usedNotificationCount = '2'
  * def acutalCount = convert_string_to_num+2
  And print acutalCount
  
  * def averageSessionCount = JavaClass.get('averageSessionCount')
  * def usedSessionCount = '1'
  * def actualSessionCount = averageSessionCount+1
  And print actualSessionCount
  
  #
  #And string convert_num_to_string = response[0].response.data[0].val[1].val.requests
  #And match convert_num_to_string == '3' 
  #And string convert_num_to_string = response[0].response.averageSessions
  #And match convert_num_to_string == '3' 
  
  And string convert_num_to_string = response.response.data[0].val[1].val.requests
  And match convert_num_to_string == '3' 
  And string convert_num_to_string = response.response.data[0].val[1].val.sessions
  And match convert_num_to_string == '0' 
  And string convert_num_to_string = response.response.data[0].val[1].val.alert_notifications
  And match convert_num_to_string == '0'