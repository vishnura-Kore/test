Feature: Remove user from account API with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')

    
    
    #Scenario: PositiveScenario....>> Remove user from account API 
    #* def Payload = 
#"""
#{
    #"userIds": [
        #"DataUserId1"
    #],
    #"botIds": [
        #"SanityBotStreamId"
    #],
    #"RemoveDataFromAllBots": false
#}
#"""
#
    #
    #Given url publicUrl
    #Then path '/public/bot/eraseUsersData'
    #And request Payload
    #And header auth = JWTToken
    #And header Content-Type = 'application/json'
    #When method delete
    #Then status 200
    #And print 'Response is: ', response