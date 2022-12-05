Feature: Add Questions from Extract – KG with Positive and Negative Scenarios

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JWTToken = JavaClass.get('JWTToken')
    * def JavaMethods = Java.type('data.commonJava')
     * def name = JavaMethods.generateRandom('number')
    * def SanitystreamId = JavaClass.get('SanitystreamId')
    * print SanitystreamId
    * def KGID = JavaClass.get('KGID')
    * def KGTaskID = JavaClass.get('KGTaskID')
    * def KGParentId = JavaClass.get('KGParentId')
    * def ConsumerBotQn1 = JavaClass.get('ConsumerBotQn1')
    * def ConsumerBotAns1 = JavaClass.get('ConsumerBotAns1')
    * def ConsumerBotQnId1 = JavaClass.get('ConsumerBotQnId1')
     * def Botname = JavaClass.get('Botname')
   
   
    Scenario: Positive Scenario Add Questions from Extract – KG
    * def Body = 
    """
   {
    "faqs": [
        {
            "questionPayload": {
                "question": "What is the validity date?",
                "tagsPayload": []
            },
            "answerPayload": [
                {
                    "text": "Validity date is the date up to which you will enjoy the benefits associated with the current tier. You are required to achieve the current tier criteria to continue enjoying the benefits after the validity date.",
                    "type": "basic",
                    "channel": "default"
                }
            ],
            "knowledgeTaskId": "630d9dbfba21be0b81d389ee",
            "subQuestions": [],
            "responseType": "message",
            "subAnswers": [],
            "streamId": "st-5179c07d-98d1-551f-8b21-a7651e002f6e",
            "parent": "idPrefix0",
            "leafterm": "ConversationEnd",
            "qsId": "qna-1a3bf6d5-eb85-5076-8211-8cac61afc355"
        }
    ]
}
"""
* set Body.faqs[0].questionPayload.question = ConsumerBotQn1
* set Body.faqs[0].answerPayload[0].text = ConsumerBotAns1
* set Body.faqs[0].qsId = ConsumerBotQnId1
* set Body.faqs[0].knowledgeTaskId = KGTaskID
* set Body.faqs[0].parent = KGParentId
* set Body.faqs[0].streamId = SanitystreamId
* set Body.faqs[0].leafterm = Botname
    Given url publicUrl
    Then path '/public/stream/'+SanitystreamId+'/faqs/bulk'
    And param language = 'en'
    And header auth = JWTToken
    And header Content-Type = 'application/json'
    And request Body
    When method post
    Then status 200
    And print 'Response is: ', response
    And match $.status == "success"
    
    