@public1
Feature: PLAT-10469

  Background: 
 * url publicUrl
 * print publicUrl
 * def JavaClass = Java.type('data.HashMap')
 * def EERSJWT = JavaClass.get('EERSJWT')
 Scenario: Get api with correct error code
 * def PstreamId = JavaClass.get('PstreamId')
 * print PstreamId
  Given path '/public/bot/'+PstreamId+'/faqs/train/status?language=en'
  And header auth = EERSJWT
  And header Content-Type = 'application/json'
  When method post
  Then status 405
   And print 'Response is: ', response
   And match response.errors[0].msg == 'Method Not Allowed'
   And match response.errors[0].code == 405
   
   