*** Settings ***
Resource   settings.robot
Resource   PageObjects/login.robot
Resource    PageObjects/dashboard.robot
Library    String

*** Keywords ***
Ensure EBS Web Screen
    [Arguments]  ${login_username}  ${login_password}

    ${exists}=  Win Exists   Internet Explorer
    Log To Console    InternetExplorer - Value of exists is: ${exists}
    IF  ${exists} == 0
        Close IE
        Login.Login    ${login_username}    ${login_password}
    END

    Win Activate  Oracle
    Send  ^+r
    sleep  1s

Ensure EBS Forms Screen
    [Arguments]  ${login_username}  ${login_password}
    
    ${exists}=  Win Exists  Oracle Applications - UAT

    Log To Console    OracleApplicationsUAT - Value of exists is: ${exists}
    
    IF  ${exists} == 0
        Log To Console    "EBS forms not open, starting up from beginning."
        Close IE
        Login.Login    ${login_username}    ${login_password}
        Dashboard.Start EBS merits
    END

    Win Activate  Oracle Applications - UAT
    sleep  1s

Close IE
    Close Application    Internet Explorer

Image With Text Exists On Screen
    [Arguments]  ${img}  ${text}  ${expect_unique}=FALSE  ${strict}=FALSE

    ${foundText}=  Get Text From Image Matching    ${img}
    ${result}=  Set Variable  False

    ${foundText}=  Replace String    "${foundText}"    ${\n}    ${EMPTY}

    IF  "${DEBUG}" == "TRUE"
        Highlight    ${img}  1
        ${matches}=  Get Match Score    ${img}

        Log To Console    Found text: ${foundText}
        Log To Console    Match score ${matches}
    END

    IF  "${expect_unique}" == "TRUE"
        ${count}=  Image Count    ${img}
        
        Log To Console    Number of times image found on screen ${count}
        IF  "${count}" != "1"
            Fail   Expected the image to appear once on the screen, got ${count} times.
        END
    END

    IF  '''${foundText}'''.find("${text}") != -1
        Log To Console    Yes we have found the text in the image ${text}
        ${result}=  Set Variable  True
    ELSE IF  "${strict}" == "TRUE"
        Fail   Expected image was found, but text did not match. Expected '${text}', Found '${foundText}'.
    END

    RETURN  ${result}

Get Text From Image Matching
    [Arguments]  ${img}
    ${exists}=  Exists    ${img}
    ${text}=   Set Variable  False
    
    IF  "${exists}" != "False"
        ${region}=  Get Extended Region From    ${img}    original    1
        ${text}=  Read Text From Region     ${region}
    END

    RETURN  ${text}

If On EBS Forms
    [Documentation]  returns 0 or 1
    
    ${exists}=  Win Exists  Oracle Applications - UAT  

    RETURN  ${exists}

Wait Until Screen Contains
    [Arguments]  ${img}  ${timeout}=${GLOBAL_WAIT_TIMEOUT}
    Wait Until Screen Contain    ${img}    ${timeout}

    IF  "${DEBUG}" == "TRUE"
        Highlight    ${img}  1
        ${count}=  Image Count    ${img}
        Log To Console    After - Count of Image: ${count}
    END

Wait Until Screen Contains With Text
    [Arguments]  ${img}  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=TRUE

    ${result}=  Set Variable  FALSE
    FOR    ${i}    IN RANGE    ${tries}
        Log   Try ${i}
        TRY
            Image With Text Exists On Screen    ${img}    ${text}  strict=TRUE
            ${result}=  Set Variable  TRUE
            Exit For Loop
        EXCEPT  AS    ${error_message}
            Log To Console    ${error_message}
        END
    END

    IF  "${strict}" == "TRUE" and "${result}" != "TRUE"
        Fail   Waited for '${tries}' tries, but could not find '${img}' with text '${text}'
    END

    RETURN  ${result}

Wait Until Dialogue With Text
    [Arguments]  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=TRUE

    Wait Until Screen Contains With Text    ${DIALOGUE_IMAGE}    ${text}  ${tries}  ${strict}

Input Text Until Appears
    [Arguments]  ${img}  ${text}  ${tries}=${GLOBAL_RETRY_TIME}

    ${result}=  Set Variable  FALSE
    FOR    ${i}    IN RANGE    ${tries}
        Log   Try ${i}
        TRY
            IF  "${DEBUG}" == "TRUE"
                Highlight    ${img}  1
                Log To Console    Looking for ${img} on screen.
            END

            Input Text    ${img}    ${text}
            ${result}=  Set Variable  TRUE
            Exit For Loop
        EXCEPT  AS    ${error_message}
            Log To Console    ${error_message}
        END
    END

    IF  "${result}" != "TRUE"
        Fail   Waited for '${tries}' tries, but could not find input '${img}'.
    END

Input Text Where Label Is
    [Documentation]  Under development, does not work yet. Need to figure out how to match on all images.
    [Arguments]  ${label}  ${text}

    Highlight  ${input_box_image}   1

    ${label_with_input}=  Get Extended Region From Image    ${input_box_image}   left    1

    Log To Console    found image regions ${label_with_input}

    ${matching_text}=  Get Text From Image Matching    ${label_with_input}

    Log To Console    Matching text: ${matching_text}

    IF  "${matching_text}" == "${text}"
        Input Text    ${label_with_input}   ${text}
    END
