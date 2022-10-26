*** Settings ***
Library    Dialogs
Resource   ../settings.robot
Resource   debug.robot

*** Keywords ***
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
    [Documentation]  Not being used.
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

Get User Input If Not Exists
    [Arguments]  ${input}  ${input_name}

    IF  "${input}" == ""
        Speaker.Say    Please enter ${input_name}
        ${input}=    Get Value From User    ${input_name}
    END

    RETURN  ${input}
