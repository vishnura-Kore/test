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
    * def ID5 = response[4]._id
    * def ID6 = response[5]._id
    * JavaClass.add('ID1',ID1)
    * JavaClass.add('ID2',ID2)
    * JavaClass.add('ID3',ID3)
    * JavaClass.add('ID4',ID4)
    * JavaClass.add('ID5',ID5)
     * JavaClass.add('ID6',ID6)
    
    
    
    
    Scenario: Suspending tasks 
    Given url appUrl
    * def ID1 = JavaClass.get('ID1')
    * def ID2 = JavaClass.get('ID2')
    * def ID3 = JavaClass.get('ID3')
    * def ID4 = JavaClass.get('ID4')
    * def ID5 = JavaClass.get('ID5')
    * def ID6 = JavaClass.get('ID6')
    
    * def payload = read('Suspendtasks.json')
    * set payload[0].dialogId = ID1
    * set payload[1].dialogId = ID2
    * set payload[2].dialogId = ID3
    * set payload[3].dialogId = ID4
    * set payload[4].dialogId = ID5
    * set payload[5].dialogId = ID6
    
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
   
    
    Scenario: Deleting the bot 
    * def streamId = JavaClass.get('streamId')
    Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId
    And request
    """
      {

      }
      """
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method DELETE
    Then status 200
    And print 'Response is: ', response
    
 
 
 
 
 