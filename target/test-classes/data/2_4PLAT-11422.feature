 @public1
Feature: PLAT-10469

  Background: 
 * url appUrl
 * def JavaClass = Java.type('data.HashMap')
 * def EERSJWT = JavaClass.get('EERSJWT')
 * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
 
 Scenario: Get api with correct error code
 * def PstreamId = JavaClass.get('PstreamId')
 * print PstreamId
  Given path '/builder/streams/'+PstreamId+'/analysis?offset=0&limit=20&mode=async&rnd=n56k5'
  And request 
  """
  {
    "filters": {
        "from": "2022-04-24T08:58:47.528Z",
        "to": "2022-04-25T08:58:47.528Z",
        "sessionStatus": "all",
        "sessionCategory": [
            0,
            1
        ],
        "tags": {
            "and": [
                {
                    "name": "LoginFail",
                    "values": [
                        "Failvaule"
                    ],
                    "type": "message"
                }
            ]
        }
    },
    "type": "failtask",
    "groupby": "input",
    "sort": {
        "order": "desc",
        "by": "timestamp"
    },
    "ignoreCount": false
}
  """
  And header Authorization = 'bearer '+botadminaccesstokenuser1
  And header Content-Type = 'application/json'
  When method post
  Then status 200
   And print 'Response is: ', response
   