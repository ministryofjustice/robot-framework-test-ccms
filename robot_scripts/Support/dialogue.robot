*** Settings ***
Library    Dialogs
Resource  ../Support/ebs_helper.robot
Resource  ../Support/hooks.robot

*** Keywords ***
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

Get User Input If Not Exists
    [Documentation]  Prompt user for input if the value is empty of the variable passed in.
    [Arguments]  ${input}  ${input_name}

    IF  "${input}" == ""
        Speaker.Say    Please enter ${input_name}
        ${input}=    Get Value From User    ${input_name}
    END

    RETURN  ${input}