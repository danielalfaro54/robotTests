*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
#Test Teardown    Basic Selenium Test Teardown

*** Keywords ***

*** Variables ***
${alertButton}          xpath=//button[text()='Click for JS Alert']
${promptButton}         xpath=//button[text()='Click for JS Prompt']
${BROWSER}              chrome
${WAIT}                 10s

*** Test Cases ***
javaScript_alerts
    [Documentation]     Validate the JavaScript alerts and prompts
    Open Browser        https://the-internet.herokuapp.com/javascript_alerts   ${BROWSER}
    MAXIMIZE BROWSER WINDOW
    #Step 1: Click on the button “Click For JS Alert”.
    Click Button    ${alertButton}
    #Step 2: Verify that Alert shows and Click on the Accept button.
    Alert Should Be Present    I am a JS Alert      ACCEPT
    #Step 3: Validate the result “You successfully clicked an alert”.
    Element Text Should Be      id:result   You successfully clicked an alert
    #Step 4: Click on the button “Click for JS Prompt”.
    Click Button    ${promptButton}
    #Step 5: Fill the text “testing”.
    Input Text Into Alert  testing  action=ACCEPT   #Input text and click 'OK' on prompt.
    #Step 6: Validate the result “You entered: testing”.
    Element Text Should Be      id:result   You entered: testing