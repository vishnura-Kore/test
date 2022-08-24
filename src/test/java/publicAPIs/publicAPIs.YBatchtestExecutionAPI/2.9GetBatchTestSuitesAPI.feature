Feature: GetBatchTestSuitesAPI

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def BotBuilderJWTToken = JavaClass.get('BotBuilderJWTToken')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId

  Scenario: Positive Scenario -----------> Get APi
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/testsuite'
    And header auth = BotBuilderJWTToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    * def Batchtestsuitename = response.name
    * JavaClass.add('Batchtestsuitename',Batchtestsuitename)
    * print Batchtestsuitename
