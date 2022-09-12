*** Settings ***
Resource   settings.robot
Resource   PageObjects/login.robot
Resource   PageObjects/dashboard.robot
Library    String
Library    Screenshot
Library    ./Support/Speaker.py

*** Variables ***
${file_menu_shortcut}   !f
${exit_option_shortcut}   x
${ok_button_shortcut}   !o

*** Keywords ***
Ensure EBS Web Screen
    [Arguments]  ${login_username}  ${login_password}

    ${exists}=  Win Exists   Internet Explorer
    Log To Console    InternetExplorer - Value of exists is: ${exists}
    IF  ${exists} == 0
        Close IE
        Login.Login    ${login_username}    ${login_password}
    END

    Focus Browser

    ${exists}=  Dashboard.On Dashboard

    # We may be logged out now...
    IF  "${exists}" == "False" 
        Fail  "Expected to be on dashboard, but not."
    END

    sleep  1s

Ensure EBS Forms Screen
    [Arguments]  ${login_username}  ${login_password}
    
    ${exists}=  Win Exists  Oracle Applications - UAT

    Log To Console    OracleApplicationsUAT - Value of exists is: ${exists}
    
    IF  ${exists} == 0
        Log To Console    "EBS forms not open, starting up from beginning."
        Ensure EBS Web Screen    ${login_username}    ${login_password}
        Dashboard.Start EBS merits
    END

    Focus EBS Forms
    sleep  1s

Focus EBS Forms
    Win Activate  Oracle Applications - UAT

Focus Browser
    Win Activate  Oracle

Image With Text Exists On Screen
    [Arguments]  ${img}  ${text}  ${expect_unique}=FALSE  ${strict}=FALSE

    ${foundText}=  Get Text From Image Matching    ${img}
    ${foundText}=  Encode String To Bytes    ${foundText}    ASCII  errors=replace

    IF  """${foundText}""" == "False"
        ${Screenshot}=  Take Screenshot
        Fail  No text Found Inside Image ${img}, screenshot: ${Screenshot}
    END
    ${result}=  Set Variable  False


    IF  "${DEBUG}" == "TRUE"
        Highlight    ${img}  1
        ${matches}=  Get Match Score    ${img}

        Log To Console    Found text: ${foundText}
        Log               Found text: ${foundText}  DEBUG
        Log To Console    Match score ${matches}
        Log               Match score ${matches}  DEBUG
    END

    IF  "${expect_unique}" == "TRUE"
        ${count}=  Image Count    ${img}
        
        Log To Console    Number of times image found on screen ${count}
        IF  "${count}" != "1"
            Fail   Expected the image to appear once on the screen, got ${count} times.
        END

        Log    message
    END

    IF  '''${foundText}'''.find("${text}") != -1
        Log               Yes we have found the text in the image ${text}
        Log To Console    Yes we have found the text in the image ${text}
        ${result}=  Set Variable  True
    ELSE IF  "${strict}" == "TRUE"
        LOG    Expected image was found, but text did not match. Expected '${text}', Found '${foundText}'.
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
    [Documentation]  Use in favour of Wait Until Screen Contain so Debug can be used.
    [Arguments]  ${img}  ${timeout}=${GLOBAL_WAIT_TIMEOUT}
    Wait Until Screen Contain    ${img}    ${timeout}

    IF  "${DEBUG}" == "TRUE"
        Highlight    ${img}  1
        ${count}=  Image Count    ${img}
        Log   After - Count of Image: ${count}
        Log To Console    After - Count of Image: ${count}
    END

Wait Until Screen Contains With Text
    [Arguments]  ${img}  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=TRUE

    ${result}=  Set Variable  FALSE
    FOR    ${i}    IN RANGE    ${tries}
        Log   Try ${i}
        Log To Console    Try ${i}
        TRY
            Image With Text Exists On Screen    ${img}    ${text}  strict=TRUE
            ${result}=  Set Variable  TRUE
            Exit For Loop
        EXCEPT  AS    ${error_message}
            Log  ${error_message}
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
                Log  Looking for ${img} on screen.
                Log To Console    Looking for ${img} on screen.
            END

            Input Text    ${img}    ${text}
            ${result}=  Set Variable  TRUE
            Exit For Loop
        EXCEPT  AS    ${error_message}
            Log  ${error_message}
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

    Log     found image regions ${label_with_input}
    Log To Console    found image regions ${label_with_input}

    ${matching_text}=  Get Text From Image Matching    ${label_with_input}

    Log    Matching text: ${matching_text}
    Log To Console    Matching text: ${matching_text}

    IF  "${matching_text}" == "${text}"
        Input Text    ${label_with_input}   ${text}
    END

Window With Title Exists
    [Documentation]  Returns True or False.
    [Arguments]  ${title}
    ${exists}=  Win Exists  ${title}

    IF  "${exists}" == "0"
        RETURN  FALSE
    END

    RETURN  TRUE

Close EBS Forms
    Send Keys  ${file_menu_shortcut}${exit_option_shortcut}${ok_button_shortcut}

Close IE
    Close Application    Internet Explorer

Send Keys
    [Arguments]  ${keys}  ${raw}=0

    Log  Sending keys ${keys}
    Log To Console    Sending keys ${keys}

    Sleep  ${GLOBAL_BEFORE_SEND_KEYS_WAIT}s

    Send  ${keys}  ${raw}

Click On
    [Arguments]  ${img}

    Log  Clicking on ${img}
    Log To Console    Clicking on ${img}

    Click    ${img}

Fail With Voice
    [Arguments]  ${msg}  ${voiceMsg}=

    IF  "${voiceMsg}" == ""
        ${voiceMsg}     Set Variable  ${msg}
    END

    Say  ${voiceMsg}
    Fail  ${msg}
