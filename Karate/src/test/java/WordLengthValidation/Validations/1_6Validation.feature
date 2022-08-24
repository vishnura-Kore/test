Feature: testapi

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def StreamID = JavaClass.get('StreamID')
    * print StreamID

  Scenario: Verified  presence of Key value in Standard Response  
    Given path '/streams/koraGenericResp'
    And param streamId = StreamID
    And param isAll = 'true'
    And param newFormat = 'true'
   And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID1
    When method get
    Then status 200
    And print responseTime
    And print response
    And match $.streamId == StreamID
    * def KeyValue = response.messages["Error & Warnings"][46].Key
    * JavaClass.add('KeyValue',KeyValue)
    * def condition = response.messages["Error & Warnings"][46].Condition
    * JavaClass.add('condition',condition)
    * print condition
    * print KeyValue
     And match response.messages["Error & Warnings"][46].Condition == condition
     And match response.messages["Error & Warnings"][46].Key == KeyValue
     
     
     
     Scenario: Edit Standard Response in Webhook Channel
     * def payload = read('payload.json')
   * set payload.streamId = StreamID
    Given path '/users/'+botadminUserID1+'/builder/streams/'+StreamID+'/koraGenericResp/condition'
    And param rnd = '140kqh'
   And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header X-HTTP-Method-Override = 'put'
    And header Host = '<calculated when request is sent>'
    And header accountid = adminaccountID1
   And request payload
    When method post
    Then status 200
    And print responseTime
    And print response
    And match $.streamId == StreamID
    * def ID = response._id
    * JavaClass.add('ID',ID)
    * def channel = response.channelUXMaps[0].channel
    * JavaClass.add('channel',channel)
    * print channel
    * def botmap = response.channelUXMaps[0].botUXMap
    * print botmap
    
    
    
    Scenario: verfied Edited response in webhook channel 
   * def condition = JavaClass.get('condition')
   * def KeyValue = JavaClass.get('KeyValue')
    * def channel = JavaClass.get('channel')
    * def botmap = JavaClass.get('botmap')
   
    Given path '/streams/koraGenericResp'
    And param streamId = StreamID
    And param isAll = 'true'
    And param newFormat = 'true'
   And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID1
    When method get
    Then status 200
    And print responseTime
    And print response
    And match $.streamId == StreamID
    And match response.messages["Error & Warnings"][0].channelUXMaps[0].channel == channel
    And match response.messages["Error & Warnings"][0].Condition == condition
    And match response.messages["Error & Warnings"][0].Key == KeyValue
    
    
     
     
     
     
     
     
     
     
     
     
    