@R10.0
Feature: feature to create the Secure Variable

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
 
  Scenario: Create a Secure Variable
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
  * def Payload = read('SecureVariable.json')
  * def variableKey = "Variable"+name
  * def variableValue = "VariableValue"+name
  * set Payload.key = variableKey
  * set Payload.value = variableValue
  
   Given path 'users/'+userID+'/builder/stream/'+streamID+'/variables'
   And header Content-Type = 'application/json'
   And header Authorization = 'bearer '+accessToken
   And header AccountId = accountId
   And request Payload
   When method post
   Then status 200
   And print response
   And match variableKey == response.key
   And match variableValue != response.value
   
   Scenario: Create a UnSecure Variable
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
  * def Payload = read('UnSecureVariable.json')
  * def variableKey = "Variable"+name
  * def variableValue = "VariableValue"+name
  * set Payload.key = variableKey
  * set Payload.value = variableValue
  
   Given path 'users/'+userID+'/builder/stream/'+streamID+'/variables'
   And header Content-Type = 'application/json'
   And header Authorization = 'bearer '+accessToken
   And header AccountId = accountId
   And request Payload
   When method post
   Then status 200
   And print response
   
   And match variableKey == response.key
   And match variableValue == response.value
  
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