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
  
  Scenario: Create a FeedSurvey With Dialog: Type Thumbs
    * def JavaClass = Java.type('data.HashMap')
    * def accountId = JavaClass.get('accountID')
    * def accessToken = JavaClass.get('accessToken')
    * def userID = JavaClass.get('userId')
    * def Payload = read('Thumb_With_Dialog.json')
    * def JavaClass = Java.type('data.commonJava')
    * def name = JavaClass.generateRandom('number')
    * def feedbackName = "Thumbs with Dialog"+name
    * set Payload.name = "Thumbs with Dialog"+name
    * set Payload.dialogName = "Thumbs with Dialog"+name
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('feedbackNameThumbs', feedbackName)
    
    Given path 'users/'+userID+'/builder/streams/'+streamId+'/feedbacksurvey'
    And header Content-Type = 'application/json'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountId
    And request Payload
    When method post
    Then status 200
    And print response

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
    
    Scenario: input Register
    * def Payload =
      """
        {
        "message": {
            "text": "Register"
        },
        "from": {
            "id": "Webhook"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
    Scenario: Executing the Dialog
    * def Payload =
      """
        {
        "message": {
            "text": "Register"
        },
        "from": {
            "id": "Webhook"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response

    
    Scenario: Submitting the Thumbs Score
    * def Payload =
      """
        {
        "message": {
            "text": "1"
        },
        "from": {
            "id": "Webhook"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
    Scenario: Descriptive Feedback
    * def Payload =
      """
        {
        "message": {
            "text": "Not up to the Mark"
        },
        "from": {
            "id": "Webhook"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    Scenario: input Register Second time
    * def Payload =
      """
        {
        "message": {
            "text": "Register"
        },
        "from": {
            "id": "Webhook1"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    Scenario: Executing the Dialog Second time
    * def Payload =
      """
        {
        "message": {
            "text": "Register"
        },
        "from": {
            "id": "Webhook1"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response

    
    Scenario: Submitting the Thumbs Score Second time
    * def Payload =
      """
        {
        "message": {
            "text": "2"
        },
        "from": {
            "id": "Webhook1"
        },
        "to": {
            "id": "4321"
        }
        }
      """
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+streamId
    And request Payload
    And header Authorization = 'bearer '+ConsumerWebHookJWT
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
