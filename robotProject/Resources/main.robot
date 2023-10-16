*** Settings ***
Library           String
Library           Collections
Library           OperatingSystem
Library           DateTime
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        chrome
${DEVICE}         ${EMPTY}
${REMOTE}         ${EMPTY}
${ENVIRONMENT}    local
${PLATFORMNAME}   ${EMPTY}
${WAIT}           15s

*** Keywords ***
Basic Selenium Test Teardown
    [Documentation]    - Logs last location
    ...    - Captures screenshot if test failed
    ...    - Updates TestRail result for the test case
    ...    - Closes all browser windows
    Log Location
    Log Source
    ${randomString} =    Generate Random String    3
    Run Keyword If    "${TEST STATUS}" == "FAIL"    Capture Page Screenshot    onFailScreenshot_${randomString}.png
    Close All Browsers


