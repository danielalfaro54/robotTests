*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

*** Keywords ***

*** Variables ***
${boxA}                 xpath=//div[@id='column-a']//header[text()='A']
${boxB}                 xpath=//div[@id='column-a']//header[text()='B']
${columnB}              xpath=//div[@id='column-b']
${boxAInColumnB}        xpath=//div[@id='column-b']//header[text()='A']
${boxBInColumnB}        xpath=//div[@id='column-b']//header[text()='B']
${BROWSER}              chrome
${WAIT}                 10s

*** Test Cases ***
dragAndDrop
    [Documentation]     Validate drag and drop of box A to B and vice versa.
    Open Browser        https://the-internet.herokuapp.com/drag_and_drop    ${BROWSER}
    MAXIMIZE BROWSER WINDOW
    #Step 1: Drag and drop the box A to the box B.
    Drag And Drop       ${boxA}     ${columnB}
    #Step 2: Validate that the boxes were changed.
    Wait Until Element Is Visible       ${boxAInColumnB}
    #Step 3: Drag and drop the box B to the box A.
    Drag And Drop       ${boxB}     ${columnB}
    #Step 4: Validate that the boxes were changed.
    Wait Until Element Is Visible       ${boxBInColumnB}