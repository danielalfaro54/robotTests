*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
#Test Teardown    Basic Selenium Test Teardown

*** Keywords ***

*** Variables ***
${enabledOption}            css=#ui-id-3
${downloadsOption}          css=#ui-id-4
${excelOption}              css=#ui-id-7
${downloadedFilePath}       /Users/daniel.alfaro9/Downloads/menu.xls
${BROWSER}              chrome
${WAIT}                 10s

*** Test Cases ***
jQuery_menus
    [Documentation]     Navigate through jQuery menu options and validate excel file is downloaded.
    Open Browser        https://the-internet.herokuapp.com/jqueryui/menu    ${BROWSER}
    MAXIMIZE BROWSER WINDOW
    #Step 1: Click on the Enabled option.
    Click Element    ${enabledOption}
    #Step 2: Click on the Downloads.
    Wait Until Element Is Visible    ${downloadsOption}     ${WAIT}    Downloads option is not visible (${downloadsOption})
    Click Element    ${downloadsOption}
    #Step 3: Click on the Excel Options.
    Wait Until Element Is Visible    ${excelOption}     ${WAIT}    Excel option is not visible (${excelOption})
    Click Element    ${excelOption}
    #Step 4: Validate that the downloaded excel file exists.
    #NOTE: This Path will need to be modified to match the default 'downloads' folder of the current system where the...
    #... test is run. If the path is incorrect, the 'menu.xls' file will fail to be found because of it.
    File Should Exist       ${downloadedFilePath}