@token
Feature: feature to test login

  Background: 
    * url appUrl

  Scenario: Generate AuthToken
    Given path 'oauth/token'
    When request { "password":'#(password)', "client_id":"1", "client_secret":"1","scope":"friends","grant_type":"password","username":'#(username)' }
    And method post
    Then status 200
    And print 'Response is: ', response
    And def accessToken = response.authorization.accessToken
    And def orgId = response.userInfo.orgID
    And def userId = response.userInfo.id
    * print accessToken
    * print orgId
    * print userId
    
   
