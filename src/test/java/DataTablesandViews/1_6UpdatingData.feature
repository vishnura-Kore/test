Feature: Creating App for Table

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def Tablename = JavaClass.get('Tablename')
    * def TableViewname = JavaClass.get('TableViewname')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * def botadminorgID1 = JavaClass.get('botadminorgID1')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')

  Scenario: updating datatable
    * def Payload = read("CreateTableView.json")
    * set Payload.query.dataSet = Tablename
    Given path '/users/'+botadminUserID1+'/builder/views/'+TableViewname
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: Getting roled is
    Given path '/organization/'+botadminorgID1+'/roles'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print 'Response is: ', response
    * def name = 'Bot Owner'
    * def name1 = 'BT2'
    * def OwnerRoleid = response.find(x => x.role == name)._id
    * print OwnerRoleid
    * JavaClass.add('OwnerRoleid', OwnerRoleid)
    * def Tester = response.find(x => x.role == name1)._id
    * print Tester
    * JavaClass.add('Tester', Tester)

  Scenario: Inviting user
    * def Tester = JavaClass.get('Tester')
    * def OwnerRoleid = JavaClass.get('OwnerRoleid')
    * def Payload =
      """
       {
        "codevelopers": {
            "users": [
                {
                    "userId": "u-1e92d894-e029-52f9-868a-9ee08a9fbc60",
                    "roleId": "5ef18834cf43275b5b1205e3"
                },
                {
                    "emailId": "ramakrishna.ravuru27@gmail.com",
                    "roleId": "5ef18834cf43275b5b1205e4"
                }
            ],
            "groups": []
        }
      }
      """
    * set Payload.codevelopers.users[0].userId = botadminUserID1
    * set Payload.codevelopers.users[0].roleId = OwnerRoleid
    * set Payload.codevelopers.users[1].roleId = Tester
    Given path '/users/'+botadminUserID1+'/builder/streams/'+SanitystreamId+'/sharebot'
    And header Authorization = 'bearer '+botadminaccesstokenuser1
    And header Content-Type = 'application/json'
    And header AccountId = adminaccountID1
    And header X-HTTP-Method-Override = 'put'
    And request Payload
    When method post
    Then status 200
    And print 'Response is: ', response
