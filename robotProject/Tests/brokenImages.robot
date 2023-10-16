*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           RequestsLibrary
Library           Collections
#Test Teardown    Basic Selenium Test Teardown

*** Keywords ***
#Verify Broken Images
    #${item}=    Get Element Attribute    //div[@class="example"]//img    src
    #${request}=    GET    ${url}    expected_status=200

*** Variables ***
${images}               xpath=//div[@class="example"]//img
${url}                  https://the-internet.herokuapp.com
${BROWSER}              chrome
${WAIT}                 10s

*** Test Cases ***
brokenImages
    [Documentation]     Validate the broken images and available images that display in the page.
    Open Browser        https://the-internet.herokuapp.com/broken_images    ${BROWSER}
    MAXIMIZE BROWSER WINDOW
    #Validate that there are 2 broken images, and that the number of images with a link available is 1.
    ${items}=   Get Element Count    ${images}                                                                          #Get total number of images found on a specific div element.
    @{linksList}=    Create List
    FOR   ${INDEX}    IN RANGE    1   ${items}+1
            ${src}=    Get Element Attribute   xpath=(//div[@class="example"]//img)[${INDEX}]      src                  #Set variable for each image 'source' link.
        Append To List      ${linksList}     ${src}                                                                     #Add images to the list.
    END
    Remove Duplicates   ${linksList}                                                                                    #Remove all duplicated values from the list.
    ${linksList_length}    Get Length  ${linksList}
    @{brokenImages}     Create List
    @{availableImages}     Create List
    FOR   ${INDEX}    IN RANGE    ${linksList_length}                                                                   #Go through each 'src' image link.
        Create Session      brokenImg        ${linksList[${INDEX}]}
        ${response}=    Run Keyword And Ignore Error    GET On Session     brokenImg    /                               #Get HTTP request response.
        Convert To List   ${response}
        ${brokenImage}=   Run Keyword And Return Status     Should Contain Match   ${response}   FAIL                   #Validate failed response due to broken image.
        IF     ${brokenImage}
            Append To List    ${brokenImages}     ${linksList[${INDEX}]}                                                #Add image elements to list depending on http response.
        ELSE IF     ${brokenImage} != ${TRUE}
            Append To List    ${availableImages}     ${linksList[${INDEX}]}
        END
    END
    Log    ${brokenImages}                                                                                              #Display list of total of broken images.
    Log    ${availableImages}                                                                                           #Display list of total of images with available links.


