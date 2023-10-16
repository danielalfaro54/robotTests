*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
#Test Teardown    Basic Selenium Test Teardown

*** Keywords ***
Refresh Page Until Gallery Button Is Visible
    ${Reload}=  Run Keyword And Return Status  Page Should Contain Element      ${galleryButton}
    WHILE    ${Reload} != ${TRUE}
        ${Reload}=  Run Keyword And Return Status  Page Should Contain Element      ${galleryButton}
        Run Keyword If    ${Reload} != ${TRUE}      Reload Page
    END

Refresh Page Until Gallery Button Is Not Visible
    ${Reload}=  Run Keyword And Return Status  Page Should Not Contain Element      ${galleryButton}
    WHILE    ${Reload} != ${TRUE}
        ${Reload}=  Run Keyword And Return Status  Page Should Not Contain Element      ${galleryButton}
        Run Keyword If    ${Reload} != ${TRUE}      Reload Page
    END

*** Variables ***
${galleryButton}        xpath=//a[contains(text(),'Gallery')]
${BROWSER}              chrome
${WAIT}                 10s

*** Test Cases ***
disappearingElement
    [Documentation]     Validate the disappearing 'Gallery' button.
    Open Browser        https://the-internet.herokuapp.com/disappearing_elements    ${BROWSER}
    MAXIMIZE BROWSER WINDOW
    #Step 1: Refresh until the button is visible.
    Refresh Page Until Gallery Button Is Visible
    #Step 2: Validate the Gallery button exists.
    Wait Until Element Is Visible    ${galleryButton}     ${WAIT}    Gallery button does not exists (${galleryButton})
    #Step 3: Refresh until the button is not visible.
    Refresh Page Until Gallery Button Is Not Visible
    #Step 4: Validate the Gallery button does not exist.
    Wait Until Element Is Not Visible       ${galleryButton}     ${WAIT}    Gallery button does exists (${galleryButton})