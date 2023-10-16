*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
#Test Teardown    Basic Selenium Test Teardown

*** Keywords ***

*** Variables ***
${addElementButton}         xpath=//button[contains(text(),'Add Element')]
${deleteElementButton}      xpath=//div[@id='elements']//button[@onclick='deleteElement()']
${elementsList}             xpath=//div[@id='elements']//button[@class='added-manually']
${BROWSER}              chrome
${WAIT}                 10s

*** Test Cases ***
addRemoveElements
    [Documentation]     Validate that button elements are added and then removed.
    Open Browser        https://the-internet.herokuapp.com/add_remove_elements/    ${BROWSER}
    MAXIMIZE BROWSER WINDOW
    #Step 1: Add 20 Elements and verify that the element button is added/visible each time.
    FOR     ${elementsAdded}     IN RANGE    1   21  1
        Click Button    ${addElementButton}
        ${buttonsAdded}=   Get Element Count    ${elementsList}
        Should Be Equal As Integers    ${buttonsAdded}    ${elementsAdded}          #Compare 'elements' list with the buttons added.
        #Log    ${buttonsAdded}
    END
    #Step 2: Remove element by element and verify each element is deleted.
    FOR     ${deleted}     IN RANGE    0   ${elementsAdded}  1
        Click Button    ${deleteElementButton}
        ${elements}=   Evaluate    ${elementsAdded}-${deleted}              #Verify the 'elements added' list is reduced by '1' each time an element is deleted.
    END                                                                         #Where '${elements}' are equal to the remaining elements of the list.
