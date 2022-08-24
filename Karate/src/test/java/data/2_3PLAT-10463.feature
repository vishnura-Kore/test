 @public2
 Feature: PLAT-10463
 Background:
 * url runtimeUrl
 * def JavaClass = Java.type('data.HashMap')
 Scenario: runtime
    * def PstreamId = JavaClass.get('PstreamId')
    * def ConsumerWebHookJWT = JavaClass.get('ConsumerWebHookJWT')
    * print PstreamId
    * print ConsumerWebHookJWT
    Given url runtimeUrl
    Then path '/chatbot/hooks/'+PstreamId
    And request
    """
    {
    "message": {
        "text": "Discard all"
    },
    "from": {
        "id": ""
    },
    "to": {
        "id": "4321"
    }
}
    """
   And header Authorization = 'bearer '+ConsumerWebHookJWT
   And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    
    