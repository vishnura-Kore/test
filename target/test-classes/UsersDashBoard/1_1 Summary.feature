@runtime
Feature: Validating BATCHTESTING Detailed Summary

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def streamId = 'st-8d47cfe5-5298-5aed-a5d3-30cfeceabb09'

  Scenario: USERS_STATS_API
    Given path '/builder/streams/'+streamId+'/returningUsers/stats'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And param mode = 'async'
    And header bot-language = 'en'
    And request
      """
    {
    "filters": {
        "from": "2022-07-15T18:30:00.000Z",
        "to": "2022-07-22T18:29:59.999Z",
        "tags": {
            "and": []
        },
        "sessionCategory": [
            0,
            1
        ],
        "sessionStatus": "all"
    }
}
      """
    When method post
    Then status 200
    And print 'Response is: ', response
    * def UserStatsId = response._id
    * JavaClass.add('UserStatsId', UserStatsId)
    * print UserStatsId
    
      Scenario: BATCH_TESTING_TESTCASES_QUERY
    Given path '/builder/streams/'+streamId+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print responseTime
    And print response
    

  Scenario: USERS_TREND_API
    Given path '/builder/streams/'+streamId+'/returningUsers/trend'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    And param mode = 'async'
    And request
      """
     {
    "filters": {
        "from": "2022-07-15T18:30:00.000Z",
        "to": "2022-07-22T18:29:59.999Z",
        "tags": {
            "and": []
        },
        "sessionCategory": [
            0,
            1
        ],
        "sessionStatus": "all"
    },
    "aggregateType": "day"
}
      """
    When method post
    Then status 200
    * def USERSTRENDId = response._id
    * JavaClass.add('USERSTRENDId', USERSTRENDId)
    * print USERSTRENDId
    
   
    

  Scenario: BATCH_TESTING_TESTCASES_QUERY
    Given path '/builder/streams/'+streamId+'/dockStatus'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    When method get
    Then status 200
    And print responseTime
    And print response
