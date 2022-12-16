Feature: Remove Assign BT Roles API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def BotTesterId = JavaClass.get('BotTesterId')
     * def BotDeveloperId = JavaClass.get('BotDeveloperId')
    * def SanitystreamId = JavaClass.get('SanitystreamId')

  Scenario: PositiveScenario....>> Remvove Assign BT Roles API
    * def Payload =
      """
      [
    {
        "roleId": "customBTrole",
        "botId": "constreamid",
        "addUsers": [
            ""
        ],
        "removeUsers": [
            "test1234@koreai.in"
        ],
        "addGroups": [
            ""
        ],
        "removeGroups": [
            ""
        ]
    }
]
      """
    * set Payload[0].roleId = BotDeveloperId
    * set Payload[0].botId = SanitystreamId
    Given url publicUrl
    Then path 'public/btroles/assignments'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response