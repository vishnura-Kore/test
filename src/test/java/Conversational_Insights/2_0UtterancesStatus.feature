@R10.0
Feature: Utterance Status

  Background: 
    * url appUrl
    
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

  Scenario: Validating the Utterances Details
  
  * def JavaClass = Java.type('data.HashMap')
  * def streamID = JavaClass.get('streamId')
  * def accountID = JavaClass.get('accountID')
  * def accessToken = JavaClass.get('accessToken')
  * def clusterID1 = JavaClass.get('clusterID1')
  * def clusterID2 = JavaClass.get('clusterID2')
  * def clusterID3 = JavaClass.get('clusterID3')
  * def clusterIDs = ["#(clusterID1)","#(clusterID2)","#(clusterID3)"]
  * print clusterIDs
  * print streamID

  Given path 'builder/metrics/intentdiscovery/streams/'+streamID+'/utterancestatus'
  * def Payload = read('UtterancesStatus.json')
  * set Payload._id = clusterIDs
  And request Payload
  And header Content-Type = 'application/json'
  And header AccountId = accountID
  And header Authorization = 'bearer '+accessToken
  And header state = 'configured'
  And header X-Timezone-Offset = '-330'
  When method post
  Then status 200
  And print response
  
  