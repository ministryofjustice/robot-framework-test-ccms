*** Settings ***
Resource  ../Support/interaction_helper.robot
Resource  ../Support/screen_content_helper.robot
Resource  ../Support/Hooks.robot

*** Keywords ***
Press Dialogue OK
    Send Keys    !o

Press Dialogue Cancel
    Send Keys    !c

Press Dialogue Yes
    Send Keys    !y

Press Dialogue No
    Send Keys    !n

Find Dialogue With Title
    [Arguments]  ${img}  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=True
    
    ${result}=  Set Variable  False
    FOR    ${i}    IN RANGE    ${tries}
        LogV   Try ${i}
        TRY
            ${foundText}=  Get EBS Window Dialogue Title Text
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
            # ${foundText}=   Get Text From Image Matching    ${img}
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
    [Arguments]  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=True

    Find Dialogue With Title    ${NAVIGATOR_TITLE_IMAGE}    ${text}  ${tries}  ${strict}

Wait Until Window With Title Appears
    [Documentation]  Expects the window to have the red oracle icon.
    [Arguments]  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=True

    Find Dialogue With Title    ${WINDOW_TITLE_IMAGE}    ${text}  ${tries}  ${strict}

Wait Until Dialogue With Title Appears
    [Documentation]  Expects the window to have no icon but close button on the right.
    [Arguments]  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=True

    Find Dialogue With Title    ${DIALOGUE_TITLE_IMAGE}    ${text}  ${tries}  ${strict}

Wait Until Decision Dialogue Appears
    [Documentation]  Expects the window to have no icon but close button on the right.
    [Arguments]  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=True

    Find Dialogue With Title    ${DECISION_TITLE_IMAGE}    Decision  ${tries}  ${strict}
