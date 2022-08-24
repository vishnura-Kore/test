@runtime
Feature: Create labels for session

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def streamId = JavaClass.get('streamId')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get("botadminUserID1")

  Scenario: To create labels
    Given path 'users/'+botadminUserID1+'/builder/streams/'+streamId+'/labels'
    And header accountid = adminaccountID1
    And header authorization = 'bearer '+botadminaccesstokenuser1
    And header content-type = 'application/json'
    * def Payload =
      """
      {
      "name": "label3",
      "metaInfo": {
          "color": "#123123"
      }
      }
      """
    And request Payload
    When method Post
    Then status 200
    * print response
    And match response.name == "label3"
    * def labelid = response._id
    * JavaClass.add('labelid',labelid)

  Scenario: To create labels
    * def labelid = JavaClass.get("labelid")
    Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId+'/labels'
    And header accountid = adminaccountID1
    And header authorization = 'bearer '+botadminaccesstokenuser1
    And header content-type = 'application/json'
    When method get
    Then status 200
    * print response
    And match response[0]._id == labelid

  Scenario: Update label name
    * def labelid = JavaClass.get("labelid")
    Given path 'users/'+botadminUserID1+'/builder/streams/'+streamId+'/labels/'+labelid
    And header accountid = adminaccountID1
    And header authorization = 'bearer '+botadminaccesstokenuser1
    And header content-type = 'application/json'
    And header x-http-method-override = 'put'
    * def Payload =
      """
      {
    "_id": "la-5c6b67c8-aac3-5b57-b520-7c66622fb14f",
    "name": "label31",
    "metaInfo": {
        "color": "#123123"
    },
    "edit": true
}
      """
    * set Payload._id = labelid
    * set Payload.name = 'label'+name
    * def updatedlabelName = Payload.name
    And request Payload
    When method Post
    Then status 200
    * print response
    And match response._id == labelid
    And match response.name == updatedlabelName
   
   Scenario: Add Label to the Session 
   
   * def sessionid = JavaClass.get("sessionid")
   * def labelid = JavaClass.get("labelid")
    Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId+'/resource/'+sessionid
    And header accountid = adminaccountID1
    And header authorization = 'bearer '+botadminaccesstokenuser1
    And header content-type = 'application/json'
    And header x-http-method-override = 'put'
    * def Payload =
      """
      {
    "labels": [
       	 "la-5c6b67c8-aac3-5b57-b520-7c66622fb14f"
    ]
}
"""
* set Payload.labels[0] = labelid
 And request Payload
    When method Post
    Then status 200
    * print response
    
    Scenario: Delete Label
     * def labelid = JavaClass.get("labelid")
    Given path '/users/'+botadminUserID1+'/builder/streams/'+streamId+'/labels/'+labelid
    And header accountid = adminaccountID1
    And header authorization = 'bearer '+botadminaccesstokenuser1
    And header content-type = 'application/json'
     When method delete
    Then status 200
    * print response
