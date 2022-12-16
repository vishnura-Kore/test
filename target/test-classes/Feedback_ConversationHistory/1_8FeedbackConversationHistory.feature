@R10.0
Feature: feature to create the Feedback Filter

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
  * JavaClass.add('userID', response.authorization.resourceOwnerID )
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
 
  Scenario: Create a Feedback Filter with type NPS
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
    
  Given path 'builder/streams/'+streamID+'/conversationanalytics/filters'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  * def Payload = read('Payload_JSON.json')
  * set Payload.filterInfo.name = botName+'NPS'
  * set Payload.filterInfo.description = botName+'NPS'
  And request Payload
  When method post
  Then status 200
  And print response  
  * JavaClass.add('NPScuftId', response._id)
  
  Scenario: Getting NPS Filter Details
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  
  Given path 'builder/streams/'+streamID+'/conversationanalytics/filters/'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  When method get
  Then status 200
  And print response  
  And match response[0].filterInfo.feedback[0].type == 'NPS'
  And match response[0].filterInfo.feedback[0].operator == 'eq'
  And match response[0].filterInfo.feedback[0].value == '8'
  
  Scenario: Update a Feedback Filter with type CSAT
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  * def NPScuftId = JavaClass.get('NPScuftId')
    
  Given path 'builder/streams/'+streamID+'/conversationanalytics/filters/'+NPScuftId+''
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  And header X-HTTP-Method-Override = 'put'
  * def Payload = read('CSAT.json')
  * set Payload.filterInfo.name = botName+'CSAT'
  * set Payload.filterInfo.description = botName+'CSAT'
  And request Payload
  When method post
  Then status 200
  And print response  
  * JavaClass.add('CSATcuftId', response._id)
  
  
  Scenario: Getting CSAT Filter Details
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  
  Given path 'builder/streams/'+streamID+'/conversationanalytics/filters/'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  When method get
  Then status 200
  And print response  
  And match response[0].filterInfo.feedback[0].type == 'CSAT'
  And match response[0].filterInfo.feedback[0].operator == 'eq'
  And match response[0].filterInfo.feedback[0].value == '5'
  
  
  Scenario: Update a Feedback Filter with type Thumb
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  * def CSATcuftId = JavaClass.get('CSATcuftId')
  
  Given path 'builder/streams/'+streamID+'/conversationanalytics/filters/'+CSATcuftId+''
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  And header X-HTTP-Method-Override = 'put'
  * def Payload = read('Thumbs.json')
  * set Payload.filterInfo.name = botName+'Thumb'
  * set Payload.filterInfo.description = botName+'Thumb'
  * def filterName = botName+'Thumb'
  * def filterDescription = botName+'Thumb'
  And request Payload
  When method post
  Then status 200
  And print response  
  * JavaClass.add('ThumbcuftId', response._id)
  * JavaClass.add('filterName', filterName)
  * JavaClass.add('filterDescription', filterDescription)
  
   
  Scenario: Getting Filter Details
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  * def CSATcuftId = JavaClass.get('CSATcuftId')
  * def filterName = JavaClass.get('filterName')
  * def filterDescription = JavaClass.get('filterDescription')
  
  Given path 'builder/streams/'+streamID+'/conversationanalytics/filters/'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  When method get
  Then status 200
  And print response  
  * def actualfilterName = karate.lowerCase(filterName)
  And match response[0].filterInfo.name == actualfilterName
  And match response[0].filterInfo.description == filterDescription
  And match response[0].filterInfo.status == 'all'
  And match response[0].filterInfo.type == 'all'
  And match response[0].filterInfo.containmentType == 'selfservice'
  And match response[0].filterInfo.feedback[0].type == 'THUMB'
  And match response[0].filterInfo.feedback[0].operator == 'eq'
  And match response[0].filterInfo.feedback[0].value == '1'
  
  
  Scenario: Getting Specific Filter Details
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamID')
  * print streamID
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def userID = JavaClass.get('userId')
  * def ThumbcuftId = JavaClass.get('ThumbcuftId')
  * def filterName = JavaClass.get('filterName')
  * def filterDescription = JavaClass.get('filterDescription')
 
  Given path 'builder/streams/'+streamID+'/conversationanalytics/filters/'+ThumbcuftId+''
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  When method get
  Then status 200
  And print response
  And match response._id == ThumbcuftId
  * def actualfilterName = karate.lowerCase(filterName)
  And match response.filterInfo.name == actualfilterName
  And match response.filterInfo.description == filterDescription
  And match response.filterInfo.status == 'all'
  And match response.filterInfo.type == 'all'
  And match response.filterInfo.containmentType == 'selfservice'
  And match response.filterInfo.feedback[0].type == 'THUMB'
  And match response.filterInfo.feedback[0].operator == 'eq'
  And match response.filterInfo.feedback[0].value == '1'
  
  
  
  
  