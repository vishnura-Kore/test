@runtime
Feature: feature to login into BotBuilder

  Background: 
    * url appUrl

  Scenario: Generate AuthToken
    Given path 'oauth/token'
    When request { "password":'#(password)', "client_id":"1", "client_secret":"1","scope":"friends","grant_type":"password","username":'#(username)' }
    And method post
    Then status 200
    And def botadminaccesstokenuser1 = response.authorization.accessToken
    And def botadminorgID1 = response.userInfo.orgID
    And def botadminUserID1 = response.authorization.resourceOwnerID
    And def adminaccountID1 = response.authorization.accountId
    And def userID1 = response.userInfo.id
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('botadminorgID1', botadminorgID1)
    * JavaClass.add('botadminUserID1', botadminUserID1)
    * JavaClass.add('adminaccountID1',adminaccountID1)
    * JavaClass.add('botadminaccesstokenuser1', botadminaccesstokenuser1 )
    * JavaClass.add('userID1',userID1);
    And print 'Response is: ', response
    * print botadminorgID1
    * print botadminUserID1
    * print botadminaccesstokenuser1
    * print userID1
    * print adminaccountID1

  
