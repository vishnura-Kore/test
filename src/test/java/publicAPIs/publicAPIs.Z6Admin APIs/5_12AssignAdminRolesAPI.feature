Feature: Assign ADMIN Roles API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def CustomAdmin1Id = JavaClass.get('CustomAdmin1Id')
     * def Custom1RoleId = JavaClass.get('Custom1RoleId')
    * def SanitystreamId = JavaClass.get('SanitystreamId')

  Scenario: PositiveScenario....>> Assign ADMIN Roles API
    * def Payload =
      """
     [
    {
        "roleId": "customAdmrole",
        "addUsers": [
            "testew@koreai.in"
        ],
        "removeUsers": [
            ""
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
    * set Payload[0].roleId = Custom1RoleId
   
    Given url publicUrl
    Then path 'public/adminroles/assignments'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    
    
    
     Scenario: PositiveScenario....>> Assign ADMIN Roles API
    * def Payload =
      """
     [
    {
        "roleId": "customAdmrole",
        "addUsers": [
            "test123@koreai.in"
        ],
        "removeUsers": [
            ""
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
    * set Payload[0].roleId = CustomAdmin1Id
   
    Given url publicUrl
    Then path 'public/adminroles/assignments'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response