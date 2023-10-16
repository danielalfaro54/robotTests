*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

*** Keywords ***

*** Variables ***
${checkbox1}            xpath=(//input[@type='checkbox'])[1]
${checkbox2}            xpath=(//input[@type='checkbox'])[2]
${BROWSER}              chrome
${WAIT}                 10s

*** Test Cases ***
checkboxes
    [Documentation]     Validate that both checkboxes are selected.
    Open Browser        https://the-internet.herokuapp.com/checkboxes    ${BROWSER}
    MAXIMIZE BROWSER WINDOW
    #Step 1: Select the checkbox “Checkbox 1”.
    Select Checkbox     ${checkbox1}
    #Step 2: Validate that the checkbox was checked.
    Checkbox Should Be Selected    ${checkbox1}
    #Step 3: Select the checkbox “Checkbox 2”.
    Select Checkbox     ${checkbox2}
    #Step 4: Validate that the checkboxes were checked.
    Checkbox Should Be Selected    ${checkbox1}
    Checkbox Should Be Selected    ${checkbox2}
