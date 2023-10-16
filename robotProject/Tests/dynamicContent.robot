*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           Collections

*** Keywords ***

*** Variables ***
${image1}           https://the-internet.herokuapp.com/img/avatars/Original-Facebook-Geek-Profile-Avatar-1.jpg
${image2}           https://the-internet.herokuapp.com/img/avatars/Original-Facebook-Geek-Profile-Avatar-2.jpg
${image3}           https://the-internet.herokuapp.com/img/avatars/Original-Facebook-Geek-Profile-Avatar-3.jpg
${image4}           https://the-internet.herokuapp.com/img/avatars/Original-Facebook-Geek-Profile-Avatar-5.jpg
${image5}           https://the-internet.herokuapp.com/img/avatars/Original-Facebook-Geek-Profile-Avatar-6.jpg
${imageElements}    xpath=//div[@class='example']//div[@id='content']//*[img]
${BROWSER}      chrome
${WAIT}         10s

*** Test Cases ***
dynamicContent_images
    [Documentation]     Validate dynamic content on page and reload until each image appears at least once.
    Open Browser        https://the-internet.herokuapp.com/dynamic_content      ${BROWSER}
    #Step: Refresh the page until all the images appear at least one time (should be 5 in total),
        # and validate the 5 different image names or source.
    ${Items}=   Get Element Count    ${imageElements}                                                                   #Get total number of image elements on page.
    @{initialList}=   Create list                                                                                       #Create list for total of images.
    ${finalListLength}=    Get Length    ${initialList}
    ${imageNumberMatches}=  Run Keyword And Return Status   Should Be Equal As Integers   ${finalListLength}   5        #Set variable to validate list length.
    WHILE   ${imageNumberMatches} != ${TRUE}
        FOR   ${INDEX}    IN RANGE    1   ${Items}+1
            Log     ${INDEX}
            ${src}=    Get Element Attribute   xpath=(//div[@class='example']//div[@id='content']//img)[${INDEX}]      src
            Append To List      ${initialList}     ${src}                                                               #Add each image 'source' name to the list.
            ${finalList}=    Remove Duplicates   ${initialList}                                                         #Remove duplicate in case image is already on the list.
            ${finalListLength}=    Get Length    ${finalList}
            ${imageNumberMatches}=  Run Keyword And Return Status   Should Be Equal As Integers   ${finalListLength}   5
            Run Keyword If    ${imageNumberMatches} != ${TRUE}      Reload Page                                         #Compare list length against the total number of images (5) and refresh page if it doesn't match.
        END
    END
