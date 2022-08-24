@runtime
Feature: Validating Advanced NLP Settings - Multilingual Changes

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def PstreamId = JavaClass.get('PstreamId')

 Scenario: Enabling German language
    * def PstreamId = JavaClass.get('PstreamId')
    Given path '/users/'+botadminUserID1+'/builder/streams/'+PstreamId
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID1
    And header x-http-method-override = 'put'
     And header bot-language = 'en'
    And request
      """
     {
    "multiLingualConfigurations": {
        "en": {
            "nluLanguage": "de",
            "inputTranslation": false,
            "responseTranslation": false
        }
    }
}
      """
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.multiLingualConfigurations.en.nluLanguage == 'de'
    


  Scenario: Getting configurationKeyName
    Given path '/builder/streams/'+PstreamId+'/advancedNLSettings'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID1
    And header bot-language = 'en'
    When method get
    Then status 200
    And print response
  
    
     Scenario: Getting configurationKeyName splitCompoundWords
    Given path '/builder/streams/'+PstreamId+'/advancedNLSettings'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header bot-language = 'en'
      And header accountid = adminaccountID1
    And request 
    """
   {
"configurationKeyName": "splitCompoundWords",
"nlpEngine": "ML",
"configurationValue": true
}
    """
    When method post
    Then status 200
    And print 'Response is ', response
    * def AdvanceNLPID = response._id
    * JavaClass.add('AdvanceNLPID', AdvanceNLPID)
     And match response.configurationKeyName == "splitCompoundWords"
    
    
    
    
      Scenario: Getting advancedNLSettings
      * def AdvanceNLPID = JavaClass.get('AdvanceNLPID')
    Given path '/builder/streams/'+PstreamId+'/advancedNLSettings/'+AdvanceNLPID
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header bot-language = 'en'
     And header x-http-method-override = 'put'
      And header accountid = adminaccountID1
    And request 
    """
   {
    "configurationValue":true
}
    """
    When method post
    Then status 200
    And print 'Response is ', response
    And match response.configurationKeyName == "splitCompoundWords"
    
    
  
  
    Scenario: Negative Scenario Enabling en language
    * def PstreamId = JavaClass.get('PstreamId')
    Given path '/users/'+botadminUserID1+'/builder/streams/'+PstreamId
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID1
    And header x-http-method-override = 'put'
     And header bot-language = 'en'
    And request
      """
     {
    "multiLingualConfigurations": {
        "en": {
            "nluLanguage": "en",
            "inputTranslation": false,
            "responseTranslation": false
        }
    }
}
      """
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print 'Response is: ', response
    And match response.multiLingualConfigurations.en.nluLanguage == 'en'
    


  Scenario: Negatve Scenario Getting advancedNLSettings
    Given path '/builder/streams/'+PstreamId+'/advancedNLSettings'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header accountid = adminaccountID1
    And header bot-language = 'en'
    When method get
    Then status 200
    And print response
    
     Scenario: Negatve Scenario  Getting advancedNLSettings 
    Given path '/builder/streams/'+PstreamId+'/advancedNLSettings'
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header bot-language = 'en'
      And header accountid = adminaccountID1
    And request 
    """
   {
"configurationKeyName": "splitCompoundWords",
"nlpEngine": "ML",
"configurationValue": true
}
    """
    When method post
    Then status 400
    And print 'Response is ', response
    And match $.errors..msg == ["'Split Compound Words' configuration is not supported for 'English' nlu language."]
   
    
    
    
    
    
      Scenario: Negative Scenario Getting advancedNLSettings
      * def AdvanceNLPID = JavaClass.get('AdvanceNLPID')
    Given path '/builder/streams/'+PstreamId+'/advancedNLSettings/'+AdvanceNLPID
     And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
     And header bot-language = 'en'
     And header x-http-method-override = 'put'
      And header accountid = adminaccountID1
    And request 
    """
   {
    "configurationValue":true
}
    """
    When method post
    Then status 400
    And print 'Response is ', response
    And match $.errors..msg == ["Advanced NL Settings not found with this Advanced NL Setting Id."]
    
    
    
   
    