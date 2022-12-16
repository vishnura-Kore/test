Feature: feature to create the bot

  Background: 
    * url appUrl
 * def JavaClass = Java.type('data.HashMap')
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
  * set Payload.name = "SanityBot"+name
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
  * JavaClass.add('streamId', response._id)
  
  Scenario: Marker Streams API
  * def JavaClass = Java.type('data.HashMap')
  * def streamId = JavaClass.get('streamId')
  * print streamId
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  Given path 'market/streams'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  * def Payload = read('MarketStreams.json')
  * set Payload._id = streamId
  * set Payload.name = botName
  * set Payload.description = botName
  And request Payload
  When method post
  Then status 200
  And print response
  
  
  
  
  Scenario: Enabling Spanish language
   * def JavaClass = Java.type('data.HashMap')
   * def streamId = JavaClass.get('streamId')
  * print streamId
  * def botName = JavaClass.get('botName')
  * def accountId = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  
   Given path '/builder/streams/'+streamId+'/supportedLanguage'
   And param language = 'es'
  And header Content-Type = 'application/json'
  And header Authorization = 'bearer '+accessToken
  And header AccountId = accountId
  And request 
  """
  {
    "baseLanguage": "en",
    "multiLingualConfigurations": {
        "es": {
            "nluLanguage": "es",
            "inputTranslation": false,
            "responseTranslation": false
        }
    }
}
  """
  When method post
  Then status 200
  And print response
  
  
  #Scenario: adding settings in nlp data
  #* def JavaClass = Java.type('data.HashMap')
  #* def streamId = JavaClass.get('streamId')
  #* def botName = JavaClass.get('botName')
  #* def accountId = JavaClass.get('accountID')
   #* def userId = JavaClass.get('userId')
  #* def accessToken = JavaClass.get('accessToken')
  #Given path '/users/'+userId+'/builder/streams/'+streamId
  #And header Content-Type = 'application/json'
  #And header Authorization = 'bearer '+accessToken
  #And header AccountId = accountId
  #* def Payload = read('Nlpsettings.json')
  #* set Payload.name = botName
  #And request Payload
  #When method post
  #Then status 200
  #And print response