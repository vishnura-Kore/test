@token
Feature: Login Into AnotherAccount

  Background: 
    * url appUrl
 * def JavaClass = Java.type('data.HashMap')
  Scenario: Generate AuthToken
    Given path 'oauth/token'
    When request { "password":'Harish@123', "client_id":"1", "client_secret":"1","scope":"friends","grant_type":"password","username":'ramakrishna.ravuru27@gmail.com' }
    And method post
    Then status 200
    And def botadminaccesstokenuser2 = response.authorization.accessToken
    And def botadminorgID2 = response.userInfo.orgID
    And def botadminUserID2 = response.authorization.resourceOwnerID
    And def adminaccountID2 = response.authorization.accountId
    And def userID2 = response.userInfo.id
    * def JavaClass = Java.type('data.HashMap')
    * JavaClass.add('botadminorgID2', botadminorgID2)
    * JavaClass.add('botadminUserID2', botadminUserID2)
    * JavaClass.add('adminaccountID2',adminaccountID2)
    * JavaClass.add('botadminaccesstokenuser2', botadminaccesstokenuser2 )
    * JavaClass.add('userID2',userID2);
    And print 'Response is: ', response
    * print botadminorgID2
    * print botadminUserID2
    * print botadminaccesstokenuser2
    * print userID2
    * print adminaccountID2
  
  
  
  
  Scenario: Getting datatable shared is
  
 * def adminaccountID2 = JavaClass.get('adminaccountID2')
 * def botadminaccesstokenuser2 = JavaClass.get('botadminaccesstokenuser2')
 * def botadminUserID2 = JavaClass.get('botadminUserID2')
    * def Tablename = JavaClass.get('Tablename')
    Given path '/users/'+botadminUserID2+'/builder/tables'
    And header Authorization = 'bearer '+botadminaccesstokenuser2
    And param limit = '100'
    And param skip = '0'
    And param fetchData = 'shared'
    And header AccountId = "5ef18834cf43275b5b1205dd"
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..name contains Tablename
   
    
    
    
    Scenario: Getting datatable shared is
     * def TableViewname = JavaClass.get('TableViewname')
 * def botadminaccesstokenuser2 = JavaClass.get('botadminaccesstokenuser2')
 * def botadminUserID2 = JavaClass.get('botadminUserID2')
    * def Tablename = JavaClass.get('Tablename')
    Given path '/users/'+botadminUserID2+'/builder/views'
    And header Authorization = 'bearer '+botadminaccesstokenuser2
    And param limit = '100'
    And param skip = '0'
    And param fetchData = 'shared'
    And header AccountId = "5ef18834cf43275b5b1205dd"
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    And match $..name contains TableViewname
   
    
    
    
    
    
    
    
    
    
