Feature: To Get the Customize None Intent Utterances for the New Bots
  To validate the get end point response

  Background: Setup the base url
    Given url 'https://staging-bots.korebots.com'

  Scenario: To Login and Validate the Status
    Given path '/api/1.1/oauth/token'
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    * def loginRequestPayload = read("LoginRequestPayload.json")
    And request loginRequestPayload
    When method post
    Then status 200
    And print response
    * def accountID = response.authorization.accountId
    * def accessToken = response.authorization.accessToken
    * def userId = response.userInfo.id
    * def orgID = response.userInfo.orgID
    And print "Primary Account ID ==> ", accountID
    And print "Primary Access Token ==> ", accessToken
    And print "Primary UserID ==> ", userId
    And print "Primary OrgID ==> ", orgID
    
    #Creation of Bot
    Given path '/api/1.1/users/'+userId+'/builder/streams'
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountID
    And header app-language = 'en'
    * def botCreationPayload = read("BotCreation.json")
    And request botCreationPayload
    When method post
    Then status 200
    And print response
    * def botID = response._id
    And print "Stream ID ==> ", botID
    * def botName = response.name
    
    #Marker Streams API
    Given path '/api/1.1/market/streams'
    And header Content-Type = 'application/json'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountID
    And request
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
    When method post
    Then status 200
    And print response
    
    #Add the None Intent Utterances
    Given path '/api/1.1/users/'+userId+'/builder/noneIntent/sentences'
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountID
    And header app-language = 'en'
    And request
    """
    {
    "state": "configured",
    "streamId": "#(botID)",
    "type": 1,
    "sentence": "Add Utterance"
		}
		"""
		When method post
    Then status 200
    And print response
    * def ID = response._id
    And print "ID ==> ", ID
    
    #Modify the Utterance
    Given path '/api/1.1/users/'+userId+'/builder/noneIntent/sentences/'+ID+''
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountID
    And header app-language = 'en'
    And header X-HTTP-Method-Override = 'put'
    * def utterances = 'Modify Utterance'
    And request
    """
    {
    "state": "configured",
    "sentence": "#(utterances)",
    "streamId": "#(botID)",
    "type": 1
		}
		"""
		When method post
    Then status 200
    And print response
    
    
    #Get the Utterances for Multi Intent Model
    Given url 'https://staging-bots.korebots.com/api/1.1/users/'+userId+'/builder/noneIntent/sentences/?streamId='+botID+'&type=single&offset=0&limit=30&search=&autoTrained=true'
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountID
    And header app-language = 'en'
    When method get
    Then status 200
    And print response
    And match utterances == response.Sentences[0].sentence
    
    #Getting Als value from ML Params
    Given url 'https://staging-bots.korebots.com/api/1.1/builder/streams/'+botID+'/mlparams?isDeveloper=true&reset=:reset&resetkey=:resetkey'
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    And header bot-language = 'en'
    And header AccountId = accountID
    And header Authorization = 'bearer '+accessToken
    And header state = 'configured'
    When method get
    Then status 200
    And print response
    * def anlsValue = response[0].advancedMLConfigurations[0]._id
    And print anlsValue
    
    #Disable Multi Intent Model
    Given url 'https://staging-bots.korebots.com/api/1.1/builder/streams/'+botID+'/advancedNLSettings/'+anlsValue+''
    And header Content-Type = 'application/json'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountID
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
    
    #Get the Utterances for Multi Intent Model
    Given url 'https://staging-bots.korebots.com/api/1.1/users/'+userId+'/builder/noneIntent/sentences/?streamId='+botID+'&type=single&offset=0&limit=30&search=&autoTrained=true'
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountID
    And header app-language = 'en'
    When method get
    Then status 200
    And print response
    And match utterances == response.Sentences[0].sentence
    
    #Delete the bot
    Given url 'https://staging-bots.korebots.com/api/1.1/users/'+userId+'/builder/streams/'+botID+''
    And header Content-Type = 'application/json'
    And header AccountId = accountID
    And header Authorization = 'bearer '+accessToken
    And header state = 'configured'
    And header X-HTTP-Method-Override = 'delete'
    When method post
    Then status 200
    And print response
    