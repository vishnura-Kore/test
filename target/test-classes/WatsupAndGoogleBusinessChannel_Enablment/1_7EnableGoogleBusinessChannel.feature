@R10.0
Feature: Enabling Webhook channel and creating app

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def streamId = JavaClass.get('streamId')

  Scenario: creating  appscope
    * def name = JavaMethods.generateRandom('number')
    * print name
    * def Payload =
      """
      {
      "appName": "Test",
      "algorithm": "HS256",
      "scope": [
         "anonymouschat",
         "registration"
      ],
      "bots": [
         "PstreamId"
      ],
      "pushNotifications": {
         "enable": false,
         "webhookUrl": ""
      }
      }
      """
    * set Payload.appName = 'Test'+name
    * set Payload.bots[0] = streamId
    * print Payload
    Given path '/users/'+botadminUserID1+'/streams/'+streamId+'/sdk/apps'
    And request Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def smartclientId1 = response.clientId
    * def smartclientsecret1 = response.clientSecret
    * print 'appList account id is:',smartclientId1
    * JavaClass.add('smartclientId1', smartclientId1)
    * JavaClass.add('smartclientsecret1', smartclientsecret1)
    * print smartclientId1
    * print smartclientsecret1

 

  Scenario: Genrate idp random number
    Given url idpurl
    Then path 'version4'
    When method get
    Then status 200
    And print 'Response is: ', response
    * def idpid = response
    * JavaClass.add('idpid',idpid)

  Scenario: To enable idp
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def idpid = JavaClass.get('idpid')
    * def BotName = JavaClass.get('BotName')
    * print smartclientId1
    * def Payload =
      """
      {
      "appConfig": {
        "channel": "googlebusiness",
        "client_id": "117409502971205851454",
        "client_email": "solution-provider@gbc-testingbot-nj2p7pq.iam.gserviceaccount.com",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCujZSwrLDtq5yD\n352Mm2RA9/wev0dKjXP2kKds3oU4Hdz8iaEDLpAPeKS/s/UAjtV1jzy/oY3AiE2m\noEfU75JvX7Cf6lK8tu6wsTcRfoSHupmMBxJr3Urc7D6wDhlSDlFs437kCetrEu+G\noxUXWLR/kWCiNBeJrZzDFjPb43Z00KxuHtYIc4XYtd4C/blex8gBu9NPnjtOx5ny\nlrcCNwdnc7ArIwrcZsFpxO6SGgEjeTDB0v0tHtIRLlxpjMdJf2aIujI/JkvZA3At\n4AfyXtK6jgxP2G5kpVRiwiQyHWg0mJftsvSn+uDsFkjs23jUzABBK0hx92+yQMLG\nboH3mngDAgMBAAECggEABlHi+c3u2VQW0SGAs01nAQEu3trJv9XE8T7wiOe6Rrtc\nu8SskJBthS824Sf+ArypLDNOSEPsUssR61VZ9HLjcuaHNGsH/tmCuowCtJPyRCB0\nnGt0dnT8gmjdUNjZ1YI7iX09JBAwjApoo2UhMjIIgFE+VfEb5GS69xyag7zFwQSZ\nBdQnRxQQlffIDSlKDkE58Y0fjFSL8k5wN9WUqjoQFCUSxU3qs8DyMbvLRoaRbuP0\nkTH8Gr4/4mQE340igEZiZFJXm0JJaSGwkxnYxFiqFKG75S5mSH5ZeF91f/0cUNN/\na41T7Uw8zgSBmExfjLD1NyECFGLB+jXWCaqTqYbKiQKBgQDzu+vdiPlT0ZPc5yoz\nXpyKaVWD+UjKDf2iX33S7TQhFilKEhOVtZAq+7v+v8ssYqlqMvxB6yNTbQIrEeGh\nP8heIcIC4WoU32ZqtUsPAHgk63WjVxNvbxifKywEFnCWjqP2HAlnzw8r3KiyKUH5\nheolTPSQja0vx7PgoPRRlj822QKBgQC3VmKuf3C8zdvSODfMwJxJJTRB1posT4KU\nIGFR3F0UOCwcApTcPPmoI9hi4qt5qg8uq+iyzMcnwihslVNbr5rfwpzra/zpRMOx\n5gG4PsvuPXLfAqCfoj7xTf+wgPOvuW53BKFsxeoq9EdZN5UgUujFK1ICavOhZXkF\n8mp955L0OwKBgG6iOmoQprv5QZjgBTPUGlJphbumB/hPaXWuyrpXmXX7TTqmAeXO\nyGX6Zlc4T80R67yc8Awr45kWvgk20KgU/6pawGn2T+SxkxeUu0FQATkg+ADwoY3P\na+mz+wLP/MMadCpeh5ZrUoOiYaCdQak1tBbCW7DR3m71wxyPctcl0APhAoGAfWTA\nKclQOlIyPx3kTE6Qlha0HzPATv4yuU1MQskNgH7K7H13gwrRVobtwPR3g8ckiy9Z\nALG+pRrOuzWGxfbdXp2k5f/+Ay3dCxfdpT6ODGxK3OzXH1fA5RoL/5SzF0UkoJKy\nNctH1gkto3+4p1sNiY2PkcfEyma017Rt0Z9Ji3ECgYBUzeEvO8WLzL6IE0Kk5SLW\nf+r/sGDnKDhpP2PQ9+c3hIHjf5WM+/nUl8p2L1vum5z5l4JG2x+4qIGluJ4jCqaf\narK8wkF7i4E2ZhbipAqQsj+Pc6aYcpvf5fRQHWUXtkTViXjRC2zwzhL4ta7L0CEo\njjZ+Bk9YVFzIrVBM+jFD9w==\n-----END PRIVATE KEY-----\n"
      },
      "_id": "ap-e06dd707-94f6-4cf5-b965-47a1716ae7a3",
      "streamId": "st-c8269609-76e7-5149-b882-d2f5072d001b",
      "channel_auth": "googlebusiness",
      "sso_type": "none",
      "name": "9591 googlebusiness account"
      }
      """
    * set Payload._id = 'ap-'+idpid
    * set Payload.name = BotName+' googlebusiness account'
    * set Payload.streamId = streamId
    * print Payload
    Given path '/builder/streams/'+streamId+'/idp'
    And request  Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200

  Scenario: To enable idp
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * def idpid = JavaClass.get('idpid')
    * def BotName = JavaClass.get('BotName')
    * print smartclientId1
    * def Payload =
      """
      {
      "type": "googlebusiness",
      "enable": true,
      "clientToken": "117409502971205851454"
      }
      """
    * print Payload
    Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId+'/channels/googlebusiness'
    And request  Payload
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200

  Scenario: Publishing the bot
    Given url publicUrl
    Then path '/public/bot/'+streamId+'/publish'
    And request
      """
      {
      "versionComment": "new update"
      }
      """
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: To Delete google business channel
    * def smartclientId1 = JavaClass.get('smartclientId1')
    * print smartclientId1
    Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId+'/channel/googlebusiness'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header X-HTTP-Method-Override = 'delete'
    When method post
    Then status 200
