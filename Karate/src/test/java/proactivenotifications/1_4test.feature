@runtime
Feature: Creating AppScopes in Bot Builder

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def SanitystreamId = "st-b6bb88de-40a8-5087-8b54-3f35fb042fd4"
    * JavaClass.add('SanitystreamId', SanitystreamId)
    * def name = JavaMethods.generateRandom('number')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def SanitystreamId = JavaClass.get('SanitystreamId')

  #Scenario: Get billing sessions
    #Given path '/builder/'+SanitystreamId+'/billingsessioncount/chart'
    #And param fromDate = '2022-06-21T10:09:30.245Z'
    #And param toDate = '2022-06-28T10:09:30.245Z'
    #And param axisInterval = 'date_day'
    #And param fullDateData = 'true'
    #And header Authorization = 'bearer '+botadminaccesstokenuser1
    #And header Content-Type = 'application/json'
    #When method get
    #Then status 200
    #And print response
    #* def billing = response.dbResult[0].billingSessions
    #* JavaClass.add('billing', billing)
    #* print billing
    

  Scenario: runtime in ms team channel
    * def Payload =
      """
       {
      "channel": "msteams",
      "userIdentityType": "resolve",
      "message": {
      "type": "script",
      "val": "print(JSON.stringify({text:'Enterprise Plan JS'}))"
      },
      "identities": [
      "praveen@koredotai.onmicrosoft.com",
      "ravindranaik@koredotai.onmicrosoft.com"
      ]
      }
      """
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/notify'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def id = response._id
    * JavaClass.add('id', id)

  Scenario: runtime in ms team channel
  * def id = JavaClass.get('id')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/notify/status/'+id
    And header auth = JWTToken
    And header Content-Type = 'application/json'
   And retry until response.status == 'SUCCESS' || response.status == 'FAILURE'
    When method get
    Then status 200
    And print response

    
    
    
    Scenario:  in  SLACK channel
    * def Payload =
      """
     {
"channel": "slack",
"userIdentityType": "resolve",
"message": {
"type": "text",
"val": "Hi Proactive BAC Scope 22"
},
"identities": [
"harishcse547@gmail.com",
"mallik.devisetty@kore.com"
]
}
      """
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/notify'
    And request Payload
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    * def id2 = response._id
    * JavaClass.add('id2', id2)

  Scenario: runtime in SLACK channel
  * def id2 = JavaClass.get('id2')
    Given url publicUrl
    Then path '/public/bot/'+SanitystreamId+'/notify/status/'+id2
    And header auth = JWTToken
    And header Content-Type = 'application/json'
   And retry until response.status == 'SUCCESS' || response.status == 'FAILURE'
    When method get
    Then status 200
    And print response
    
    
    
    
    
    
    
    
    
    
    