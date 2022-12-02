*** Settings ***
Library    SikuliLibrary  mode=NEW
Library    String
Library    Dialogs
Resource   ../settings.robot
Resource   debug.robot
Resource   browser_helper.robot
Resource   ../PageObjects/navigator.robot
Resource   ../PageObjects/dashboard.robot

*** Variables ***
${file_menu_shortcut}   !f
${exit_option_shortcut}   x
${ok_button_shortcut}   !o
${close_button_shortcut}  {TAB}{ENTER}
${inactive_window_image}  InactiveWindowTitleBar.PNG

*** Keywords ***
Ensure EBS Web Screen
    [Documentation]  Uses: Selenium/Sikuli/AutoIt Returns: None
    ...   Closes IE and relogs in, land on the dashboard.
    [Arguments]  ${login_username}  ${login_password}

    Close IE
    Login.Login    ${login_username}    ${login_password}

    ${exists}=  Dashboard.On Dashboard

    # We may be logged out now...
    IF  "${exists}" == "False"
        Fail  "Expected to be on dashboard, but not."
    END

    sleep  1s

Ensure EBS Forms Screen
    [Documentation]  Uses: Selenium/Sikuli/AutoIt Returns: None
    ...   Ensure on ebs forms screen. Will re-login if needs to be.
    [Arguments]  ${login_username}  ${login_password}

    ${exists}=  Win Exists  ${EBS_WINDOW_TITLE}

    IF  ${exists} == 0
        LogV    "EBS forms not open, starting up from beginning."
        Dashboard.Start EBS merits
    END

    Focus EBS Forms
    sleep  1s

Ensure EBusiness Center
    [Documentation]  Uses: Selenium/Sikuli/AutoIt Returns: None
    ...   Closes IE and relogs in, land on the ebusiness center window.
    ${exists}=  Win Exists  eBusiness Center

    IF  ${exists} == 0
        Log To Console    "We are not on eBusiness Center window, going to it now."
        Back To Choose Window
        Send Keys    ${close_button_shortcut}
    END

    Focus EBS Forms
    sleep  1s

Focus EBS Forms
    [Documentation]  Uses: AutoIt Returns: None
    ...   Focus the EBS forms.
    Win Activate  ${EBS_WINDOW_TITLE}
    # nFlags=3 to maximise window
    Win Set State    ${EBS_WINDOW_TITLE}  strText=${EMPTY}  nFlags=3

If On EBS Forms
    [Documentation]  Uses: AutoIt Returns: Number
    ...   Check if EBS forms are open, returns 0 or 1.

    ${exists}=  Win Exists  ${EBS_WINDOW_TITLE}

    RETURN  ${exists}

Close EBS Forms
    [Documentation]  Uses: AutoIt Returns: None
    ...   Closes EBS forms.
    Send Keys  ${file_menu_shortcut}${exit_option_shortcut}${ok_button_shortcut}

Get EBS Window Dialogue Title Text
    [Documentation]  Get the value of any EBS window title bar. This title bar must have
    ...              the minimise, maximise and close buttons on the right.
    [Arguments]  ${img-width}
    ${region}=  Get Extended Region From Image     ${WINDOW_TITLE_IMAGE}    left   ${img-width}
    ${score}=  Get Match Score    ${WINDOW_TITLE_IMAGE}

    IF  "${DEBUG}" == "True"
        Highlight Region    ${region}   ${DEBUG_HIGHLIGHT_TIME}
    END
    ${text}=  Read Text From Region     ${region}

    RETURN    ${text}

Image With Text Exists On Screen
    [Documentation]  Find an image with particular text on the current screen view.
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
    [Documentation]  Get text from an image that exists on the screen.
    ...    Usually used in conjunction with region keywords to capture extended views on the screen.
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

Wait Until Screen Contains
    [Documentation]  Wait for the provided image to appear on screen.
    ...  Use in favour of Wait Until Screen Contain so Debug can be used.
    [Arguments]  ${img}  ${timeout}=${GLOBAL_WAIT_TIMEOUT}
    Wait Until Screen Contain    ${img}    ${timeout}

    IF  "${DEBUG}" == "True"
        Highlight    ${img}  ${DEBUG_HIGHLIGHT_TIME}
        ${count}=  Image Count    ${img}
        LogV   Count of Image: ${count}
    END

Wait Until Screen Contains With Text
    [Documentation]  Wiat for the image with particular text to appear on screen.
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

Window With Title Exists
    [Documentation]  Check if a window with a certain title exists on the screen. Returns True or False.
    [Arguments]  ${title}
    ${exists}=  Win Exists  ${title}

    IF  "${exists}" == "0"
        RETURN  False
    END

    RETURN  True

Input Text Until Appears
    [Documentation]  Find an image on screen, click on it and then input text.
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

# Input Text Where Label Is
#     [Documentation]  Not being used. Under development, does not work yet. Need to figure out how to match on all images.
#     [Arguments]  ${label}  ${text}

#     IF  "${DEBUG}" == "True"
#         Highlight  ${input_box_image}   ${DEBUG_HIGHLIGHT_TIME}
#     END

#     ${label_with_input}=  Get Extended Region From Image    ${input_box_image}   left    1

#     LogV     found image regions ${label_with_input}

#     ${matching_text}=  Get Text From Image Matching    ${label_with_input}

#     LogV    Matching text: ${matching_text}

#     IF  "${matching_text}" == "${text}"
#         SikuliLibrary.Input Text    ${label_with_input}   ${text}
#     END

Send Keys
    [Documentation]  Use to either fill inputs or press shortcut keys.
    [Arguments]  ${keys}  ${raw}=0

    Log  Sending keys ${keys}
    Sleep  ${GLOBAL_BEFORE_SEND_KEYS_WAIT}s
    Send  ${keys}  ${raw}

Press Shortcut Keys
    [Documentation]  Wrapper for Send Keys but more expressive for shortcuts.
    [Arguments]  ${keys}  ${raw}=0
    Send Keys  ${keys}  ${raw}

Click On
    [Documentation]  Will click on an image until a few times before failing. Use this in favour of Click to leverage logging information.
    [Arguments]  ${img}  ${tries}=3

    Log  ${img}
    Log To Console  ${img}

    IF  ${DEBUG} == "True"
        Highlight    ${img}  1
    END

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

Press Dialogue OK
    [Documentation]  Uses: AutoIt Returns: None
    Send Keys    !o

Press Dialogue Cancel
    [Documentation]  Uses: AutoIt Returns: None
    Send Keys    !c

Press Dialogue Yes
    [Documentation]  Uses: AutoIt Returns: None
    Send Keys    !y

Press Dialogue No
    [Documentation]  Uses: AutoIt Returns: None
    Send Keys    !n

Find Dialogue With Title
    [Documentation]  Uses: AutoIt/Sikuli Returns: None
    ...   Find dialogue with a title, will try a few times based on the tries argument.
    [Arguments]  ${img}  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=True  ${img-width}=${IMAGE_WIDTH}

    ${result}=  Set Variable  False
    FOR    ${i}    IN RANGE    ${tries}
        LogV   Try ${i}
        TRY
            ${foundText}=  Get EBS Window Dialogue Title Text  ${img-width}
            ${contains}=  String Contains  ${foundText}  ${text}

            Log To Console    CONTAINS RESULT: ${contains}

            IF  ${contains}
                LogV               Yes we have found the text in the image ${text}
                ${result}=  Set Variable  True
            ELSE IF  "${strict}" == "True"
                LogV   Expected image was found, but text did not match. Expected '${text}', Found '${foundText}'.
                Fail   Expected image was found, but text did not match. Expected '${text}', Found '${foundText}'.
            END

            ${result}=  Set Variable  True
            Exit For Loop
        EXCEPT  AS    ${error_message}
            LogV  ${error_message}  False
            On Dialogue Title Search Fail    ${foundText}
        END

        Sleep  ${GLOBAL_RETRY_WAIT_INTERVAL}
    END

    IF  "${strict}" == "True" and "${result}" != "True"
        Fail   Waited for '${tries}' tries, but could not find '${img}' with text '${text}'
    END

    RETURN  ${result}

Wait Until Navigator Window With Title Appears
    [Documentation]  Expects the window to have the navigator icon.
    [Arguments]  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=True  ${img-width}=${IMAGE_WIDTH}

    Find Dialogue With Title    ${NAVIGATOR_TITLE_IMAGE}    ${text}  ${tries}  ${strict}  ${img-width}

Wait Until Window With Title Appears
    [Documentation]  Expects the window to have the red oracle icon.
    [Arguments]  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=True  ${img-width}=${IMAGE_WIDTH}

    Find Dialogue With Title    ${WINDOW_TITLE_IMAGE}    ${text}  ${tries}  ${strict}  ${img-width}

Wait Until Dialogue With Title Appears
    [Documentation]  Expects the window to have no icon but close button on the right.
    [Arguments]  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=True  ${img-width}=${IMAGE_WIDTH}

    Find Dialogue With Title    ${DIALOGUE_TITLE_IMAGE}    ${text}  ${tries}  ${strict}  ${img-width}

Wait Until Decision Dialogue Appears
    [Documentation]  Expects the window to have no icon but close button on the right.
    [Arguments]  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=True  ${img-width}=${IMAGE_WIDTH}

    Find Dialogue With Title    ${DECISION_TITLE_IMAGE}    Decision  ${tries}  ${strict}  ${img-width}

Get User Input If Not Exists
    [Documentation]  Prompt user for input if the value is empty of the variable passed in.
    [Arguments]  ${input}  ${input_name}

    IF  "${input}" == ""
        Speaker.Say    Please enter ${input_name}
        ${input}=    Get Value From User    ${input_name}
    END

    RETURN  ${input}

Maximise Active EBS Subwindow
    [Documentation]  Maximise the active EBS sub window. Works by double-clicking the blue title bar.
    Double Click    ${WINDOW_TITLE_IMAGE}
    
Activate Any Subwindow
    [Documentation]  Check if there is an active subwindow, if not, then try and click on an inactive one.
    ${exists}=  Exists    ${WINDOW_TITLE_IMAGE}

    IF  "${exists}" == "False"
        Click On    ${inactive_window_image}
    END
