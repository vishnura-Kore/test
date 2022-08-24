@kore
Feature: To validate the Customize None Intent Check for the New Bots
  To validate the get end point response

  Background: Setup the base url
    Given url 'https://staging-bots.korebots.com'

  Scenario: To Login and Validate the Status
    Given path '/api/1.1/oauth/token'
    And header Content-Type = 'application/json'
    And header bot-language = 'en'
    * def loginRequestPayload = read("LoginRequestPayload.json")
    And request loginRequestPayload
    When method post
    Then status 200
    And print response
    * def accountID = response.authorization.accountId
    * def accessToken = response.authorization.accessToken
    * def userId = response.userInfo.id
    * def orgID = response.userInfo.orgID
    And print "Primary Account ID ==> ", accountID
    And print "Primary Access Token ==> ", accessToken
    And print "Primary UserID ==> ", userId
    And print "Primary OrgID ==> ", orgID
    
    #Validate the data in the Orders & Invoices Screen
    Given url 'https://staging-bots.korebots.com/api/1.1/builder/streams/st-41d90449-6653-5ed7-a940-c77bdd91db7b/billing/invoice?&limit=10&skip=0'
    And header Content-Type = 'application/json'
    And header Authorization = 'bearer '+accessToken
    And header AccountId = accountID
    When method get
    And print response
    
    #Support Plan Assertions
    And match response.invoices[0].planName == 'Standard Support'
    And match response.invoices[0].orderType == 'Subscription'
    And match response.invoices[0].state == 'success'
    And string convert_num_to_string = response.invoices[0].amountPaid
    And match convert_num_to_string == '10000'
    
    #Standard Plan(Reload) Assertions
    And match response.invoices[1].planName == 'Standard'
    And match response.invoices[1].orderType == 'Reload'
    And match response.invoices[1].state == 'success'
    And string convert_num_to_string = response.invoices[1].amountPaid
    And match convert_num_to_string == '200'
    
    #Standard Plan Assertions
    And match response.invoices[2].planName == 'Standard'
    And match response.invoices[2].orderType == 'Subscription'
    And match response.invoices[2].state == 'success'
    And string convert_num_to_string = response.invoices[2].amountPaid
    And match convert_num_to_string == '100'