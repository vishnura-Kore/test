@R10.0
Feature: Enable Language

  Background: 
    * url appUrl
    * def JavaClass = Java.type('data.HashMap')
    * def JavaMethods = Java.type('data.commonJava')
    * def name = JavaMethods.generateRandom('number')
    * def streamId = JavaClass.get('streamId')
    * def adminaccountID1 = JavaClass.get('adminaccountID1')
    * def botadminaccesstokenuser1 = JavaClass.get('botadminaccesstokenuser1')
    * def JWTToken = JavaClass.get('JWTToken')
    * def botadminUserID1 = JavaClass.get('botadminUserID1')
    * def pattern = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    * def getDate =
      """
      function() {
        var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
        var sdf = new SimpleDateFormat(pattern);
        var date = new java.util.Date();
        return sdf.format(date);
      } 
      """
    * def today = getDate()
    * def Appenddays = JavaMethods.getRequiredDate(7,'yyyy-MM-dd',"HH:mm:ss")
    * def decrease = JavaMethods.getdecrementdays(-7,'yyyy-MM-dd',"'T'HH:mm:ss.SSS'Z'")
    * def Threedays = JavaMethods.getdecrementdays(-3,'yyyy-MM-dd',"'T'HH:mm:ss.SSS'Z'")
    * def Oneday = JavaMethods.getdecrementdays(-1,'yyyy-MM-dd',"'T'HH:mm:ss.SSS'Z'")
    * def future = JavaMethods.ConvertDateFormat(Appenddays,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    * def SevenDays = JavaMethods.ConvertDateFormat(decrease,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    * def ThreedaysFilter = JavaMethods.ConvertDateFormat(Threedays,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    * def OnedaysFilter = JavaMethods.ConvertDateFormat(Oneday,'yyyy-MM-dd',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")

  Scenario: To Enable Language
    Given url publicUrl
    Then path '/1.1/public/bot/'+streamId+'/language'
    And header accountid = adminaccountID1
    And header auth = JWTToken
    And header content-type = 'application/json'
    * def Payload =
      """
       {
        "enableLanguage": "fr",
        "langDefinitionMode":
         {
            "baseLanguage": "en",
            "type": "advancedConfig",
            "preferredData": 
            {
            "training": true,
            "faqs": true,
            "ontology": true,
            "smalltalk": true,
            "traits": true
        }
            },
        "multiLingualConfigurations": 
        {
            "nluLanguage": "en",
            "inputTranslation": true,
            "responseTranslation": true
        }
      }
      """
    And request Payload
    When method Post
    Then status 200
    * print response

  Scenario: To Disable Language
    Given url publicUrl
    Then path '/1.1/public/bot/'+streamId+'/language/status'
    And header accountid = adminaccountID1
    And header auth = JWTToken
    And header content-type = 'application/json'
    * def Payload =
      """
       {  "language" : "fr", 
          "enable": false 
          
       }

      """
    And request Payload
    When method Post
    Then status 200
    * print response

  Scenario: To Enable Language
    Given url publicUrl
    Then path '/1.1/public/bot/'+streamId+'/language/status'
    And header accountid = adminaccountID1
    And header auth = JWTToken
    And header content-type = 'application/json'
    * def Payload =
      """
       {  
       "language" : "fr", 
          "enable": true     
       }
      """
    And request Payload
    When method Post
    Then status 200
    * print response
    
    Scenario: LanguageDefinition File upload
    Given url publicUrl
    * def file = '/public/uploadfile'
    Given path file
    And header Content-Type = 'multipart/form-data'
    And header auth = JWTToken
    And multipart file file = { read: 'French.json', filename: 'French.json', contentType: 'application/json' }
    And multipart field fileContext = 'bulkImport'
    And multipart field fileExtension = 'json'
    When method post
    Then status 200
    * def LanguageFileId = response.fileId
    * JavaClass.add('LanguageFileId', LanguageFileId)
    * print LanguageFileId

  Scenario: To Update Language configurations
  * def LanguageFileId = JavaClass.get('LanguageFileId')
    Given url publicUrl
    Then path '/1.1/public/bot/'+streamId+'/language'
    And header auth = JWTToken
    And header content-type = 'application/json'
    * def Payload =
      """
       {  
       "updateLanugage" : "fr",  
           "fileId" : LanguageFileId,
          "multiLingualConfigurations" : 
          {
             "nluLanguage" : "en",
             "inputTranslation": true,
             "responseTranslation": true
             
          }
        
          
       }
      """
      * set Payload.fileId = LanguageFileId
    And request Payload
    When method put
    Then status 200
    * print response
