@kore
Feature: To Disable the None and FAQ Intent
  To validate the get end point response

  Background: Setup the base url
    Given url 'https://eu-bots.kore.ai'

  Scenario: To Login and Validate the Primary Admin Status
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
    
    #Getting the Model Params Value
    Given url 'https://staging-bots.korebots.com/api/1.1/builder/streams/'+botID+'/mlparams?isDeveloper=true&reset=:reset&resetkey=:resetkey'
    And header Content-Type = 'application/json'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountID
    And header app-language = 'en'
    And header bot-language = 'en'
    And request
    When method get
    Then status 200
    And print response
    * def paramID = response[1]._id
    And print "Param ID ==> ", paramID
    
    #Disable the None Intent and FAQ Intent and Enable the Customize None Intent
    Given url 'https://staging-bots.korebots.com/api/1.1/builder/streams/'+botID+'/customModelParams/'+paramID+''
    And header Content-Type = 'application/json'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountID
    And header app-language = 'en'
    And header bot-language = 'en'
    And header X-HTTP-Method-Override = 'put'
    And request
      """
      {
      "dialogIntents": [],
      "isDefault": false,
      "intentParams": {
          "type": "V3",
          "minngram": 1,
          "maxngram": 4,
          "ngram": [
              1,
              1
          ],
          "useSynonyms": false,
          "f_negation": false,
          "useStopwords": true,
          "usePlaceholders": false,
          "useTestPlaceholders": false,
          "features": "n_gram",
          "skip_gram": {
              "seqLength": 2,
              "maxSkipDistance": 1
          }
      },
      "nerParams": {
          "type": "corenlp"
      },
      "intentData": {
          "stopwords": "'ll 'm 've a about above abst accordance according accordingly across act actually adj affected affecting affects afternoon afterwards again against ah all almost alone along already also although always am among amongst an and announce another any anybody anyhow anymore anyone anything anyway anyways anywhere apparently approximately are aren arent arise around as aside ask asking at auth away awfully b back be became because become becomes becoming been before beforehand begin beginning beginnings begins behind being believe below beside besides between beyond biol both brief briefly bro but by bye c ca came cause causes certain certainly co com come comes contain containing contains could couldnt d did didn't different do does doesn't doing don't done down downwards during e each ed edu effect eg either else elsewhere end ending enough especially et et-al etc even ever every everybody everyone everything everywhere ex except f far few ff fix followed following follows for former formerly forth found from further furthermore g gave get gets give given gives giving goes gone good got gotten h had happens hardly has hasn't haven't he hed hello hello hence her here hereafter hereby herein heres hereupon hers herself hes hey hi hid him himself his hither home how howbeit howdy however i i'll i've ie if im immediate immediately importance important in inc indeed index information instead into invention inward is isn't it it'll itd its itself j just k keep keeps kept kg kk km know known knows l largely last lately later latter latterly least less lest let lets like liked likely line little ltd m made mainly make makes many may maybe me mean means meantime meanwhile merely mg might miss ml more moreover morning most mostly mr mrs much mug must my myself n na namely nay nd near nearly necessarily necessary needs neither never nevertheless new next night no no nobody non none nonetheless noon noone nor normally nos noted nothing now nowhere o obtain obtained obviously of off often oh ok okay old omitted on once one ones only onto or ord other others otherwise ought our ours ourselves over overall owing own p page pages part particular particularly past per perhaps placed please plus poorly possible possibly pp present previously primarily probably promptly proud provides put q que quickly quite qv r ran rather rd re readily really recent recently ref refs regarding regardless regards related relatively research respectively resulted resulting results right run s said same saw say saying says sec section see seeing seem seemed seeming seems seen self selves sent seven several shall she she'll shed shes should shouldn't show showed shown showns shows significant significantly similar similarly since slightly so some somebody somehow someone somethan something sometime sometimes somewhat somewhere soon sorry specifically specified specify specifying still stop strongly sub substantially successfully such sufficiently sup sure t take taken taking tell tends th than thank thanks thanks thanx that that'll that've thats the their theirs them themselves then thence there there'll there've thereafter thereby thered therefore therein thereof therere theres thereto thereupon these they they'll they've theyd theyre think this those thou though thoughh thousand throug through throughout thru thus til tip to together too took toward towards tried tries truly try trying ts twice u un under unfortunately unless unlike unlikely until unto up upon ups us use used useful usefully usefulness uses using usually v value various very via viz vol vols vs w want wants was wasnt way we we'll we've wed welcome went were werent what what'll whatever whats when whence whenever where whereafter whereas whereby wherein wheres whereupon wherever whether which while whim whither who who'll whod whoever whole whom whomever whos whose why widely willing wish with within without wont words world would wouldnt www x y yeah yes yet yo you you'll you've youd your youre yours yourself yourselves z zero"
      },
      "streamId": "#(botID)",
      "language": "en",
      "state": "configured",
      "type": 2,
      "name": "",
      "exactMatchThreshold": 95,
      "minThreshold": 0.3,
      "maxThreshold": 0,
      "__v": 0,
      "mlConfigurations": {
          "NoneIntent": false,
          "ML_Add_FAQS_To_NoneIntent": false,
          "NoneIntentCustomTraining": true
      }
      }
      """
    When method post
    Then status 200
    And print response
      
    #None Intent Check for New Bots
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
    * def result2 = response[1].mlConfigurations.NoneIntent
    * match result2 == false
    * def result3 = response[1].mlConfigurations.ML_Add_FAQS_To_NoneIntent
    * match result3 == false
    * def result4 = response[1].mlConfigurations.NoneIntentCustomTraining
    * match result4 == true
    
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
