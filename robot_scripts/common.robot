*** Settings ***
Resource   settings.robot
Resource   PageObjects/login.robot
Resource   PageObjects/dashboard.robot
Resource   PageObjects/group_and_role.robot
Resource   Support/Processing.robot
Resource   PageObjects/Navigator.robot
Library    String
Library    ./Support/StringUtils.py
Library    Screenshot
Library    ./Support/Speaker.py
Library    Dialogs
Library    Process

*** Variables ***
${file_menu_shortcut}   !f
${exit_option_shortcut}   x
${ok_button_shortcut}   !o
${close_button_shortcut}  {TAB}{ENTER}	

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

Ensure EBusiness Center
        ${exists}=  Win Exists  eBusiness Center

        LogV    eBusinessCenterWindow - Value of exists is: ${exists}

        IF  ${exists} == 0
                   Log To Console    "We are not on eBusiness Center window, going to it now."
                   Back To Choose Window
                   Send Keys    ${close_button_shortcut}
        END
        
        Focus EBS Forms
        sleep  1s

Focus EBS Forms
    Win Activate  Oracle Applications - UAT

Focus Browser
    Win Activate  Oracle

Image With Text Exists On Screen
    [Arguments]  ${img}  ${text}  ${expect_unique}=False  ${strict}=False

    ${foundText}=  Get Text From Image Matching    ${img}
    ${foundText}=  Encode String To Bytes    ${foundText}    ASCII  errors=replace
    
    IF  "${DEBUG}" == "True"
        Highlight    ${img}  ${DEBUG_HIGHLIGHT_TIME}
        ${matches}=  Get Match Score    ${img}

        LogV  Found text: ${foundText} in image ${img}, Match score ${matches}  False
    END

    IF  """${foundText}""" == "False" or """${foundText}""" == ""
        LogV   No text found inside image ${img}
    END
    ${result}=  Set Variable  False

    IF  "${expect_unique}" == "True"
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
    ELSE IF  "${strict}" == "True"
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

        IF  "${DEBUG}" == "True"
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

    IF  "${DEBUG}" == "True"
        Highlight    ${img}  ${DEBUG_HIGHLIGHT_TIME}
        ${count}=  Image Count    ${img}
        LogV   Count of Image: ${count}
    END

Wait Until Screen Contains With Text
    [Arguments]  ${img}  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=True

    ${result}=  Set Variable  False
    FOR    ${i}    IN RANGE    ${tries}
        LogV   Try ${i}
        TRY
            Image With Text Exists On Screen    ${img}    ${text}  strict=True
            ${result}=  Set Variable  True
            Exit For Loop
        EXCEPT  AS    ${error_message}
            LogV  ${error_message}  False
        END

        Sleep  ${GLOBAL_RETRY_WAIT_INTERVAL}
    END

    IF  "${strict}" == "True" and "${result}" != "True"
        Fail   Waited for '${tries}' tries, but could not find '${img}' with text '${text}'
    END

    RETURN  ${result}

Input Text Until Appears
    [Arguments]  ${img}  ${text}  ${tries}=${GLOBAL_RETRY_TIME}

    ${result}=  Set Variable  False
    FOR    ${i}    IN RANGE    ${tries}
        LogV   Try ${i}
        TRY
            IF  "${DEBUG}" == "True"
                Highlight    ${img}  ${DEBUG_HIGHLIGHT_TIME}
                LogV  Looking for ${img} on screen.  VoiceMsg=False
            END

            SikuliLibrary.Input Text    ${img}    ${text}
            ${result}=  Set Variable  True
            Exit For Loop
        EXCEPT  AS    ${error_message}
            LogV  ${error_message}
        END

        Sleep  ${GLOBAL_RETRY_WAIT_INTERVAL}
    END

    IF  "${result}" != "True"
        Fail   Waited for '${tries}' tries, but could not find input '${img}'.
    END

Input Text Where Label Is
    [Documentation]  Under development, does not work yet. Need to figure out how to match on all images.
    [Arguments]  ${label}  ${text}

    IF  "${DEBUG}" == "True"
        Highlight  ${input_box_image}   ${DEBUG_HIGHLIGHT_TIME}
    END

    ${label_with_input}=  Get Extended Region From Image    ${input_box_image}   left    1

    LogV     found image regions ${label_with_input}

    ${matching_text}=  Get Text From Image Matching    ${label_with_input}

    LogV    Matching text: ${matching_text}

    IF  "${matching_text}" == "${text}"
        SikuliLibrary.Input Text    ${label_with_input}   ${text}
    END

Window With Title Exists
    [Documentation]  Returns True or False.
    [Arguments]  ${title}
    ${exists}=  Win Exists  ${title}

    IF  "${exists}" == "0"
        RETURN  False
    END

    RETURN  True

Close EBS Forms
    Send Keys  ${file_menu_shortcut}${exit_option_shortcut}${ok_button_shortcut}

Close IE
    Task Kill  task=iexplore.exe

Send Keys
    [Documentation]  Use to either fill inputs or press shortcut keys.
    [Arguments]  ${keys}  ${raw}=0

    LogV  Sending keys ${keys}

    Sleep  ${GLOBAL_BEFORE_SEND_KEYS_WAIT}s

    Send  ${keys}  ${raw}

Click On
    [Documentation]  Use this in favour of Click to leverage logging information.
    [Arguments]  ${img}  ${tries}=3

    Log  ${img}
    Log To Console  ${img}

    ${result}=  Set Variable  False
    FOR    ${i}    IN RANGE    ${tries}
        LogV   Try ${i}
        TRY
            Click    ${img}
            ${result}=  Set Variable  True
            Exit For Loop
        EXCEPT  AS    ${error_message}
            LogV  ${error_message}
        END

        Sleep  ${GLOBAL_RETRY_WAIT_INTERVAL}
    END

    IF  "${result}" != "True"
        Fail   Waited for '${tries}' tries, but could not click on image '${img}'.
    END

Click In Until
    [Arguments]  ${region}  ${image}  ${tries}=3

    ${result}=  Set Variable  False
    FOR    ${i}    IN RANGE    ${tries}
        LogV   Try ${i}
        TRY
            IF  "${DEBUG}" == "True"
                Highlight    ${region}  ${DEBUG_HIGHLIGHT_TIME}
                LogV  Looking for ${region} on screen.  VoiceMsg=False
            END

            Click In    ${region}    ${image}
            ${result}=  Set Variable  True
            Exit For Loop
        EXCEPT  AS    ${error_message}
            LogV  ${error_message}
        END

        Sleep  ${GLOBAL_RETRY_WAIT_INTERVAL}
    END

    IF  "${result}" != "True"
        Fail   Waited for '${tries}' tries, but could not click on image ${image} inside '${region}'.
    END

Fail With Voice Old
    [Arguments]  ${msg}  ${voiceMsg}=""

    Log  ${msg}
    Log To Console  ${msg}

    IF  "${voiceMsg}" != "False"
        ${voiceMsg}=  Set Variable  ${msg}
    END

    Say  ${voiceMsg}
    Fail  ${msg}

Fail With Voice And Help
    [Documentation]  Fail with both spoken and displayed error message.
    ...    Displayed message in two places: (i) direct to console, near screenshot info and extra text 
    ...                                     (ii) part of standard "FAIL" output
    ...    Optional extra info is displayed but not spoken. 
    ...    enforce_new_line flag used to start "direct to console" message on a new line which can be tidier
    [Arguments]    ${message}  ${extra_info}=""  ${enforce_new_line}=True

    Say If Human  ${message}

    IF  ${enforce_new_line}
        Log To Console  \ 
    END
    Log to Console  ${message}
    # Triple quotes to avoid "EOL while scanning string literal" errors from \n chars 
    IF  """${extra_info}""" != ""
        Log To Console  ${extra_info}
    END

    Fail  ${message}

LogV
    [Arguments]  ${text}  ${voiceMsg}=True

    Log  ${text}
    Log To Console  ${text}

    IF  "${voiceMsg}" != "False"
        IF  "${DEBUG}" == "True"
            Say  ${text}
        END
    END

Get User Input If Not Exists
    [Arguments]  ${input}  ${input_name}

    IF  "${input}" == ""
        Speaker.Say    Please enter ${input_name}
        ${input}=    Get Value From User    ${input_name}
    END

    RETURN  ${input}
