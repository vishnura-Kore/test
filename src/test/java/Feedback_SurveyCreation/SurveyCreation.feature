@R10.0
Feature: feature to create the Feedback Survey

  Background: 
    * url appUrl

  Scenario: Login into the Bot Builder
  Given path 'oauth/token'
  When request { "password":'#(password)', "client_id":"1", "client_secret":"1","scope":"friends","grant_type":"password","username":'#(username)' }
  And method post
  Then status 200
  * def JavaClass = Java.type('data.HashMap')
  * JavaClass.add('accountID', response.authorization.accountId)
  * JavaClass.add('accessToken', response.authorization.accessToken)
  * JavaClass.add('userId',response.userInfo.id)
  * JavaClass.add('orgID', response.userInfo.orgID )
  And print 'Response is: ', response
  
  
  Scenario: Creation of Bot
  * def JavaClass = Java.type('data.commonJava')
  * def name = JavaClass.generateRandom('number')
  * print name 
  * def Payload = read('BotCreation.json')
  * set Payload.name = "Feedback"+name
  * print  Payload
  * def JavaClass = Java.type('data.HashMap')
  * def userId = JavaClass.get('userId')
  * def accessToken = JavaClass.get('accessToken')
  Given path 'users/'+userId+'/builder/streams' 
  And request Payload
  And header Authorization = 'bearer '+accessToken
  And header Content-Type = 'application/json'
  When method post
  Then status 200
  And print 'Response is: ', response
  * JavaClass.add('botName', response.name)
  * JavaClass.add('streamID', response._id)
  
  #Marker Streams API
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  
  Given path 'market/streams'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  * def Payload = read('MarketStreams.json')
  * set Payload._id = streamID
  * set Payload.name = botName
  * set Payload.description = botName
  And request Payload
  When method post
  Then status 200
  And print response
 
  Scenario: Create a FeedSurvey With Dialog: Type NPS
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  
  * def JavaClass = Java.type('data.commonJava')
  * def name = JavaClass.generateRandom('number')
  * print name 
  * def Payload = read('NPS_With_Dialog.json')
  * set Payload.name = "NPS with Dialog"+name
  * set Payload.dialogName = "NPS with Dialog"+name
  
  Given path 'users/'+userID+'/builder/streams/'+streamID+'/feedbacksurvey'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  And request Payload
  When method post
  Then status 200
  
  Scenario: Create a FeedSurvey With Dialog: Type CSAT
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  
  * def JavaClass = Java.type('data.commonJava')
  * def name = JavaClass.generateRandom('number')
  * print name 
  * def Payload = read('CSAT_With_Dialog.json')
  * set Payload.name = "CSAT with Dialog"+name
  * set Payload.dialogName = "CSAT with Dialog"+name
  
  Given path 'users/'+userID+'/builder/streams/'+streamID+'/feedbacksurvey'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  And request Payload
  When method post
  Then status 200
  
  Scenario: Create a FeedSurvey With Dialog: Type THUMB
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  
  * def JavaClass = Java.type('data.commonJava')
  * def name = JavaClass.generateRandom('number')
  * print name 
  * def Payload = read('Thumb_With_Dialog.json')
  * set Payload.name = "Thumbs with Dialog"+name
  * set Payload.dialogName = "THUMB with Dialog"+name
  
  Given path 'users/'+userID+'/builder/streams/'+streamID+'/feedbacksurvey'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  And request Payload
  When method post
  Then status 200
  
  Scenario: Create a FeedSurvey Without Dialog: Type NPS
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  
  * def JavaClass = Java.type('data.commonJava')
  * def name = JavaClass.generateRandom('number')
  * print name 
  * def Payload = read('NPS_Without_Dialog.json')
  * set Payload.name = "NPS without Dialog"+name
  
  Given path 'users/'+userID+'/builder/streams/'+streamID+'/feedbacksurvey'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  And request Payload
  When method post
  Then status 200
  
  
  Scenario: Create a FeedSurvey Without Dialog: Type CSAT
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  
  * def JavaClass = Java.type('data.commonJava')
  * def name = JavaClass.generateRandom('number')
  * print name 
  * def Payload = read('CSAT_Without_Dialog.json')
  * set Payload.name = "CSAT without Dialog"+name
  
  Given path 'users/'+userID+'/builder/streams/'+streamID+'/feedbacksurvey'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  And request Payload
  When method post
  Then status 200
  
  
  Scenario: Create a FeedSurvey Without Dialog: Type THUMB
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  
  * def JavaClass = Java.type('data.commonJava')
  * def name = JavaClass.generateRandom('number')
  * print name 
  * def Payload = read('THUMB_Without_Dialog.json')
  * set Payload.name = "THUMB without Dialog"+name
  
  Given path 'users/'+userID+'/builder/streams/'+streamID+'/feedbacksurvey'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  And request Payload
  When method post
  Then status 200
  
  Scenario: Getting the Feedback survey list and Asserting the Count of the Created Feedback surveys with the actual one
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  
  Given path 'users/'+userID+'/builder/streams/'+streamID+'/feedbacksurvey'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  When method get
  Then status 200
  And print response
  And string convert_num_to_string = response.count
  And match convert_num_to_string == '6'
  
  Scenario: Delete the bot
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  
  Given path 'users/'+userID+'/builder/streams/'+streamID+''
  And header Content-Type = 'application/json'
  And header AccountId = accountId
  And header Authorization = 'bearer '+accessToken
  And header state = 'configured'
  And header X-HTTP-Method-Override = 'delete'
  When method post
  Then status 200
  And print response