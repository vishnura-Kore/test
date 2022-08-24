Feature: Run time execution of the Dialogs having the Bot Actions
  To validate the get end point response

  Background: Setup the base url
    Given url 'https://bots.kore.ai/botbuilder'

  Scenario: Verifying the Bot Actions Functionality
    
    #Execute the Dialog having the Service Node in the Webhook channel
    Given path '/chatbot/hooks/st-2d3a9db6-972f-52b9-8a17-033350fcbdff'
    And header Authorization = 'bearer '+'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiYXBwSWQiOiJjcy1hMTQxODIzMS1hNTg0LTVmNDQtYmNjMy03MDQ0OWY2MmFkN2EifQ.9zoip7QVeTjKRq9yOvUOutdtJjvN7VKB-J7HExz29ZM'
    And header Content-Type = 'application/json'
    * def webhookPayloadService = read("ServicePayload.json")
    And request webhookPayloadService
		When method post
    Then status 200
    And print response
    And match response.text[0] == 'Service Executed Successfully'
    
    
    #Execute the Dialog having the Script Node in the Webhook channel
    Given path '/chatbot/hooks/st-2d3a9db6-972f-52b9-8a17-033350fcbdff'
    And header Authorization = 'bearer '+'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiYXBwSWQiOiJjcy1hMTQxODIzMS1hNTg0LTVmNDQtYmNjMy03MDQ0OWY2MmFkN2EifQ.9zoip7QVeTjKRq9yOvUOutdtJjvN7VKB-J7HExz29ZM'
    And header Content-Type = 'application/json'
    * def webhookPayloadScript = read("ScriptPayload.json")
    And request webhookPayloadScript
		When method post
    Then status 200
    And print response
    And match response.text[0] == 'Script Executed Successfully'
    