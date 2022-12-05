@kore
Feature: To validate the None Intent Check for the New Bots
  To validate the get end point response

  Background: 
    * url appUrl
    * def userId = ids.userId
    * def accessToken = ids.accessToken
    * def JavaClass = Java.type('data.HashMap')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
   
  
   Scenario: creating a bot
    * def JavaClass = Java.type('data.commonJava')
    * def name = JavaClass.generateRandom('number')
    * print name 
    * def Payload = read('BotCreation.json')
    * set Payload.name = "Sanity"+name
    * print  Payload
    Given path 'users/'+userId+'/builder/streams' 
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.name == Payload.name
    * def SanityBotStreamId = response._id
    * print 'SanityBot streamID is:',SanityBotStreamId
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('SanityBotStreamId', SanityBotStreamId)
    * JavaClass.add('userId', userId)
    
    Scenario: getting market streams api
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    Given path '/market/streams'
    * def payload = 
     """
     {
      "_id": '#(botID)',
      "name": '#(botName)',
      "description": '#(botName)',
      "categoryIds": [
      "451902a073c071463e2fe7f6"
      ],
      "icon": "62a32fe0a240be2aa45f9c13",
      "keywords": [],
      "languages": [],
      "price": 1,
      "screenShots": [],
      "namespace": "private",
      "namespaceIds": [],
      "color": "#009dab",
      "bBanner": "",
      "sBanner": "",
      "bBannerColor": "#009dab",
      "sBannerColor": "#009dab",
      "profileRequired": true,
      "sendVcf": false
      }
      """
     * set payload._id = SanityBotStreamId
    And header Content-Type = 'application/json'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header AccountId = adminaccountID1
    And request payload
    When method post
    Then status 200
    And print response
    
    Scenario: Getting Als value from ML Params
     * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    Given path '/builder/streams/'+SanityBotStreamId+'/mlparams'
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    And header bot-language = 'en'
    And header AccountId = adminaccountID1
   And param isDeveloper = 'true&reset=:reset&resetkey=:resetkey'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header state = 'configured'
    When method get
    Then status 200
    And print response
    * def anlsValue = response[0].advancedMLConfigurations[0]._id
     * JavaClass.add('anlsValue', anlsValue)
    And print anlsValue
    
    Scenario: Disable Multi Intent Model
     * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
      * def anlsValue = JavaClass.get('anlsValue')
    Given path '/builder/streams/'+SanityBotStreamId+'/advancedNLSettings/'+anlsValue
    And header Content-Type = 'application/json'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header AccountId = adminaccountID1
    And header bot-language = 'en'
    And header bot-language = 'en'
    And header X-HTTP-Method-Override = 'put'
    And request
    """
    {
    "configurationValue": false
		}
    """
    When method post
    Then status 200
    And print response
    
    Scenario: None Intent Check for New Bots
     * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    Given path '/builder/streams/'+SanityBotStreamId+'/mlparams'
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    And header bot-language = 'en'
      And param isDeveloper = 'true'
    And param reset = 'reset'
    And param resetkey = 'resetkey'
    And header AccountId = adminaccountID1
    And header Authorization = 'bearer '+accessToken
    And header state = 'configured'
    When method get
    Then status 200
    And print response
    * def value4 = $..mlConfigurations.NoneIntent
    * print value4
    * match value4 == [true,true]
    * def value5 = $..mlConfigurations.ML_Add_FAQS_To_NoneIntent
    * print value5
    * match value5 == [true,true]
    * def value6 = $..mlConfigurations.NoneIntentCustomTraining
    * print value6
    * match value6 == [false,false]
    
    Scenario: Delete the bot
    * def SanityBotStreamId = JavaClass.get('SanityBotStreamId')
    Given path '/users/'+userId+'/builder/streams/'+SanityBotStreamId
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header state = 'configured'
    And header X-HTTP-Method-Override = 'delete'
    When method post
    Then status 200
    And print response

