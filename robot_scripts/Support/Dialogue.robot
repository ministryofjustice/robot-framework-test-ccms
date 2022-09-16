*** Settings ***
Resource  ../Common.robot

*** Keywords ***
Press Dialogue OK
    Send Keys    !o

Press Dialogue Cancel
    Send Keys    !c

Press Dialogue Yes
    Send Keys    !y

Press Dialogue No
    Send Keys    !n

Wait Until Navigator Window With Title Appears
    [Documentation]  Expects the window to have the navigator icon.
    [Arguments]  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=TRUE

    Wait Until Screen Contains With Text    ${NAVIGATOR_TITLE_IMAGE}    ${text}  ${tries}  ${strict}

Wait Until Window With Title Appears
    [Documentation]  Expects the window to have the red oracle icon.
    [Arguments]  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=TRUE

    Wait Until Screen Contains With Text    ${WINDOW_TITLE_IMAGE}    ${text}  ${tries}  ${strict}

Wait Until Dialogue With Title Appears
    [Documentation]  Expects the window to have no icon but close button on the right.
    [Arguments]  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=TRUE

    Wait Until Screen Contains With Text    ${DIALOGUE_TITLE_IMAGE}    ${text}  ${tries}  ${strict}
