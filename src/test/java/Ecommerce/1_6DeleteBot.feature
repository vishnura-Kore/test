@R10.0
Feature: Deleting the bot 

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def streamId = JavaClass.get('streamId')
    
     Scenario: Get all dialog ids in bot
    Given url appUrl
    Then path '/builder/streams/'+streamId+'/dialogs'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print response
    
    * def ID1 = response[0]._id
    * def ID2 = response[1]._id
    * def ID3 = response[2]._id
    * def ID4 = response[3]._id
    
    * JavaClass.add('ID1',ID1)
    * JavaClass.add('ID2',ID2)
    * JavaClass.add('ID3',ID3)
    * JavaClass.add('ID4',ID4)
    
    Scenario: Suspending tasks 
    Given url appUrl
    * def ID1 = JavaClass.get('ID1')
    * def ID2 = JavaClass.get('ID2')
    * def ID3 = JavaClass.get('ID3')
    * def ID4 = JavaClass.get('ID4')
    * def payload = read('Suspendtasks.json')
    * set payload[0].dialogId = ID1
    * set payload[1].dialogId = ID2
    * set payload[2].dialogId = ID3
    * set payload[3].dialogId = ID4

    Given path '/organization/'+botadminorgID1+'/workflows/updateTaskStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header X-HTTP-Method-Override = 'put'
    And header Host = '<calculated when request is sent>'
    And header accountid = adminaccountID1
    And request payload
    When method post
    Then status 200
    And print responseTime
    And print response
 
 		Scenario: Login into the Bot Builder
    Given path 'oauth/token'
    When request { "password":'#(password)', "client_id":"1", "client_secret":"1","scope":"friends","grant_type":"password","username":'#(username)' }
    And method post
    Then status 200
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('accountID', response.authorization.accountId)
    * JavaClass.add('accessToken', response.authorization.accessToken)
    * JavaClass.add('userId',response.userInfo.id)
    * JavaClass.add('orgID', response.userInfo.orgID )
    And print 'Response is: ', response  
 
    Scenario: Delete the bot 
  
    * def JavaClass = Java.type('data.HashMap')
    * def streamID = JavaClass.get('streamId')
    * def accountID = JavaClass.get('accountID')
    * def accessToken = JavaClass.get('accessToken')
    * def userId = JavaClass.get('userId')
  
    Given path 'users/'+userId+'/builder/streams/'+streamID+''
    And header Content-Type = 'application/json'
    And header AccountId = accountID
    And header Authorization = 'bearer '+accessToken
    And header state = 'configured'
    And header X-HTTP-Method-Override = 'delete'
    When method post
    Then status 200
    And print response
 
 