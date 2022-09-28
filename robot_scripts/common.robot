*** Settings ***
Resource   settings.robot
Resource   PageObjects/login.robot
Resource   PageObjects/dashboard.robot
Resource   PageObjects/group_and_role.robot
Library    String
Library    ./Support/StringUtils.py
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
    LogV  InternetExplorer - Value of exists is: ${exists}
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

    LogV    OracleApplicationsUAT - Value of exists is: ${exists}
    
    IF  ${exists} == 0
        LogV    "EBS forms not open, starting up from beginning."
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
    [Arguments]  ${img}  ${text}  ${expect_unique}=FALSE  ${strict}=FALSE ${GLOBAL_WAIT_TIMEOUT}

    ${foundText}=  Get Text From Image Matching    ${img}
    ${foundText}=  Encode String To Bytes    ${foundText}    ASCII  errors=replace

    IF  "${DEBUG}" == "TRUE"
        Highlight    ${img}  ${DEBUG_HIGHLIGHT_TIME}
        ${matches}=  Get Match Score    ${img}

        LogV  Found text: ${foundText} in image ${img}, Match score ${matches}  False
    END

    IF  """${foundText}""" == "False" or """${foundText}""" == ""
        ${Screenshot}=  Take Screenshot
        Fail  No text found inside image ${img}, screenshot: ${Screenshot}
    END
    ${result}=  Set Variable  False

    IF  "${expect_unique}" == "TRUE"
        ${count}=  Image Count    ${img}

        LogV    Number of times image found on screen ${count}
        IF  "${count}" != "1"
            Fail   Expected the image to appear once on the screen, got ${count} times.
        END
    END

    ${contains}=  String Contains  ${foundText}  ${text}

    Log To Console    CONTAINS RESULT: ${contains}

    IF  ${contains}
        LogV               Yes we have found the text in the image ${text}
        ${result}=  Set Variable  True
    ELSE IF  "${strict}" == "TRUE"
        LogV   Expected image was found, but text did not match. Expected '${text}', Found '${foundText}'.
        Fail   Expected image was found, but text did not match. Expected '${text}', Found '${foundText}'.
    END

    RETURN  ${result}

Get Text From Image Matching
    [Arguments]  ${img}
    ${exists}=  Exists    ${img}
    ${text}=   Set Variable  False
    
    IF  "${exists}" != "False"
        ${region}=  Get Extended Region From    ${img}    original    1
        LogV  Region to get text from: ${region}   False

        IF  "${DEBUG}" == "TRUE"
            Highlight Region    ${region}   ${DEBUG_HIGHLIGHT_TIME}
        END
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
        Highlight    ${img}  ${DEBUG_HIGHLIGHT_TIME}
        ${count}=  Image Count    ${img}
        LogV   Count of Image: ${count}
    END

Wait Until Screen Contains With Text
    [Arguments]  ${img}  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=TRUE

    ${result}=  Set Variable  FALSE
    FOR    ${i}    IN RANGE    ${tries}
        LogV   Try ${i}
        TRY
            Image With Text Exists On Screen    ${img}    ${text}  strict=TRUE
            ${result}=  Set Variable  TRUE
            Exit For Loop
        EXCEPT  AS    ${error_message}
            LogV  ${error_message}  False
        END

        Sleep  ${GLOBAL_RETRY_WAIT_INTERVAL}
    END

    IF  "${strict}" == "TRUE" and "${result}" != "TRUE"
        Fail   Waited for '${tries}' tries, but could not find '${img}' with text '${text}'
    END

    RETURN  ${result}

Input Text Until Appears
    [Arguments]  ${img}  ${text}  ${tries}=${GLOBAL_RETRY_TIME}

    ${result}=  Set Variable  FALSE
    FOR    ${i}    IN RANGE    ${tries}
        LogV   Try ${i}
        TRY
            IF  "${DEBUG}" == "TRUE"
                Highlight    ${img}  ${DEBUG_HIGHLIGHT_TIME}
                LogV  Looking for ${img} on screen.  VoiceMsg=False
            END

            Input Text    ${img}    ${text}
            ${result}=  Set Variable  TRUE
            Exit For Loop
        EXCEPT  AS    ${error_message}
            LogV  ${error_message}
        END

        Sleep  ${GLOBAL_RETRY_WAIT_INTERVAL}
    END

    IF  "${result}" != "TRUE"
        Fail   Waited for '${tries}' tries, but could not find input '${img}'.
    END

Input Text Where Label Is
    [Documentation]  Under development, does not work yet. Need to figure out how to match on all images.
    [Arguments]  ${label}  ${text}

    IF  "${DEBUG}" == "TRUE"
        Highlight  ${input_box_image}   ${DEBUG_HIGHLIGHT_TIME}
    END

    ${label_with_input}=  Get Extended Region From Image    ${input_box_image}   left    1

    LogV     found image regions ${label_with_input}

    ${matching_text}=  Get Text From Image Matching    ${label_with_input}

    LogV    Matching text: ${matching_text}

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
    [Documentation]  Use to either fill inputs or press shortcut keys.
    [Arguments]  ${keys}  ${raw}=0

    LogV  Sending keys ${keys}

    Sleep  ${GLOBAL_BEFORE_SEND_KEYS_WAIT}s

    Send  ${keys}  ${raw}

Click On
    [Documentation]  Use this in favour of Click to leverage logging information.
    [Arguments]  ${img}

    Log  ${img}
    Log To Console  ${img}

    Click    ${img}

Fail With Voice
    [Arguments]  ${msg}  ${voiceMsg}=""

    Log  ${msg}
    Log To Console  ${msg}

    IF  "${voiceMsg}" != "False"
        ${voiceMsg}=  Set Variable  ${msg}
    END

    Say  ${voiceMsg}
    Fail  ${msg}



LogV
    [Arguments]  ${text}  ${voiceMsg}=True

    Log  ${text}
    Log To Console  ${text}

    IF  "${voiceMsg}" != "False"
        IF  "${DEBUG}" == "TRUE"
            Say  ${text}
        END
    END
