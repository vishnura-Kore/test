@R10.0
Feature: feature to Submit the Feedback Survey

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
  And print response
  * def JavaClass = Java.type('data.HashMap')
  * JavaClass.add('NPSwithDialog', response.result[0].name)
  * JavaClass.add('NPSwithDialogType', response.result[0].type)
  
  Scenario: Push the Data from the Public API to NPS Feedback Survey
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * def accessToken = JavaClass.get('accessToken')
  * def NPSwithDialog = JavaClass.get('NPSwithDialog')
  * def NPSwithDialogType = JavaClass.get('NPSwithDialogType')
  * def JWTToken = JavaClass.get('JWTToken')
  * print JWTToken
  * def Payload = read('SurveySubmission.json')
  * set Payload.name = NPSwithDialog
  * set Payload.type = NPSwithDialogType
  
  Given path 'public/bot/'+streamID+'/saveFeedback'
  And header Content-Type = 'application/json'
  And header auth = JWTToken
  And request Payload
  When method post
  Then status 200
  And print response
  And match response.name == NPSwithDialog
  And match response.type == NPSwithDialogType
  And match response.channel == 'slack'
  And match response.language == 'en'
  And match response.score == '3'
  And match response.channelUId == 'release9.3@getnada.com'
  And match response.botId == streamID
  
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
  And print response
  * def JavaClass = Java.type('data.HashMap')
  * JavaClass.add('CSATwithDialog', response.result[0].name)
  * JavaClass.add('CSATwithDialogType', response.result[0].type)
  
  Scenario: Push the Data from the Public API to CSAT Feedback Survey
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * def accessToken = JavaClass.get('accessToken')
  * def CSATwithDialog = JavaClass.get('CSATwithDialog')
  * def CSATwithDialogType = JavaClass.get('CSATwithDialogType')
  * def JWTToken = JavaClass.get('JWTToken')
  * print JWTToken
  * def Payload = read('SurveySubmission.json')
  * set Payload.name = CSATwithDialog
  * set Payload.type = CSATwithDialogType
  
  Given path 'public/bot/'+streamID+'/saveFeedback'
  And header Content-Type = 'application/json'
  And header auth = JWTToken
  And request Payload
  When method post
  Then status 200
  And print response
  And match response.name == CSATwithDialog
  And match response.type == CSATwithDialogType
  And match response.channel == 'slack'
  And match response.language == 'en'
  And match response.score == '3'
  And match response.channelUId == 'release9.3@getnada.com'
  And match response.botId == streamID
  
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
  And print response
  * def JavaClass = Java.type('data.HashMap')
  * JavaClass.add('ThumbwithDialog', response.result[0].name)
  * JavaClass.add('ThumbwithDialogType', response.result[0].type)
  
  Scenario: Push the Data from the Public API to Thumb Feedback Survey
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * def accessToken = JavaClass.get('accessToken')
  * def ThumbwithDialog = JavaClass.get('ThumbwithDialog')
  * def ThumbwithDialogType = JavaClass.get('ThumbwithDialogType')
  * def JWTToken = JavaClass.get('JWTToken')
  * print JWTToken
  * def Payload = read('SurveySubmission.json')
  * set Payload.name = ThumbwithDialog
  * set Payload.type = ThumbwithDialogType
  
  Given path 'public/bot/'+streamID+'/saveFeedback'
  And header Content-Type = 'application/json'
  And header auth = JWTToken
  And request Payload
  When method post
  Then status 200
  And print response
  And match response.name == ThumbwithDialog
  And match response.type == ThumbwithDialogType
  And match response.channel == 'slack'
  And match response.language == 'en'
  And match response.score == '3'
  And match response.channelUId == 'release9.3@getnada.com'
  And match response.botId == streamID
  
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
  And print response
  * def JavaClass = Java.type('data.HashMap')
  * JavaClass.add('NPSwithoutDialog', response.result[0].name)
  * JavaClass.add('NPSwithoutDialogType', response.result[0].type)
  
  Scenario: Push the Data from the Public API to Thumb Feedback Survey
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * def accessToken = JavaClass.get('accessToken')
  * def NPSwithoutDialog = JavaClass.get('NPSwithoutDialog')
  * def NPSwithoutDialogType = JavaClass.get('NPSwithoutDialogType')
  * def JWTToken = JavaClass.get('JWTToken')
  * print JWTToken
  * def Payload = read('SurveySubmission.json')
  * set Payload.name = NPSwithoutDialog
  * set Payload.type = NPSwithoutDialogType
  
  Given path 'public/bot/'+streamID+'/saveFeedback'
  And header Content-Type = 'application/json'
  And header auth = JWTToken
  And request Payload
  When method post
  Then status 200
  And print response
  And match response.name == NPSwithoutDialog
  And match response.type == NPSwithoutDialogType
  And match response.channel == 'slack'
  And match response.language == 'en'
  And match response.score == '3'
  And match response.channelUId == 'release9.3@getnada.com'
  And match response.botId == streamID
  
  
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
  And print response
  * def JavaClass = Java.type('data.HashMap')
  * JavaClass.add('CSATwithoutDialog', response.result[0].name)
  * JavaClass.add('CSATwithoutDialogType', response.result[0].type)
  
  Scenario: Push the Data from the Public API to Thumb Feedback Survey
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * def accessToken = JavaClass.get('accessToken')
  * def CSATwithoutDialog = JavaClass.get('CSATwithoutDialog')
  * def CSATwithoutDialogType = JavaClass.get('CSATwithoutDialogType')
  * def JWTToken = JavaClass.get('JWTToken')
  * print JWTToken
  * def Payload = read('SurveySubmission.json')
  * set Payload.name = CSATwithoutDialog
  * set Payload.type = CSATwithoutDialogType
  
  Given path 'public/bot/'+streamID+'/saveFeedback'
  And header Content-Type = 'application/json'
  And header auth = JWTToken
  And request Payload
  When method post
  Then status 200
  And print response
  And match response.name == CSATwithoutDialog
  And match response.type == CSATwithoutDialogType
  And match response.channel == 'slack'
  And match response.language == 'en'
  And match response.score == '3'
  And match response.channelUId == 'release9.3@getnada.com'
  And match response.botId == streamID
  
  
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
  And print response
  * def JavaClass = Java.type('data.HashMap')
  * JavaClass.add('ThumbwithoutDialog', response.result[0].name)
  * JavaClass.add('ThumbwithoutDialogType', response.result[0].type)
  
  Scenario: Push the Data from the Public API to Thumb Feedback Survey
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * def accessToken = JavaClass.get('accessToken')
  * def ThumbwithoutDialog = JavaClass.get('ThumbwithoutDialog')
  * def ThumbwithoutDialogType = JavaClass.get('ThumbwithoutDialogType')
  * def JWTToken = JavaClass.get('JWTToken')
  * print JWTToken
  * def Payload = read('SurveySubmission.json')
  * set Payload.name = ThumbwithoutDialog
  * set Payload.type = ThumbwithoutDialogType
  
  Given path 'public/bot/'+streamID+'/saveFeedback'
  And header Content-Type = 'application/json'
  And header auth = JWTToken
  And request Payload
  When method post
  Then status 200
  And print response
  And match response.name == ThumbwithoutDialog
  And match response.type == ThumbwithoutDialogType
  And match response.channel == 'slack'
  And match response.language == 'en'
  And match response.score == '3'
  And match response.channelUId == 'release9.3@getnada.com'
  And match response.botId == streamID
  
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