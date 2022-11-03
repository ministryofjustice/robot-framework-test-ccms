*** Settings ***
Resource    ../Support/ebs_helper.robot
Resource    ../Support/ebs_helper.robot

*** Variables ***
${open_search_shortcut}            {UP}{UP}{DOWN}{ENTER}
${navigator_shortcut}              !w1
${window_menu_shortcut}            !w2
${service_request_menu_shortcut}   !w4

*** Keywords ***
Open Batch Request Run Window
    [Documentation]  Uses: AutoIt/Sikuli Returns: None
    ...  Waits until the batch request window is present and opens the request run window.
    Wait Until Navigator Window With Title Appears    CCMS Batch User
    Send Keys   rrr

Back To Navigator
    [Documentation]  Uses: AutoIt Returns: None
    ...  Goes back to the navigator window.
    Send Keys  ${navigator_shortcut}

Back To Choose Window
    [Documentation]  Uses: AutoIt Returns: None
    ...  Goes back to choose window.
    Send Keys  ${window_menu_shortcut}

Refresh Service Request Window
    [Documentation]  Uses: AutoIt Returns: None
    ...  Refreshes the service request window.
    Send Keys  ${service_request_menu_shortcut}

Open Universal Search
    [Documentation]  Uses: AutoIt Returns: None
    ...  Opens up universal search from within EBS.
    # Wait Until Navigator Window With Title Appears    Navigator
    Sleep  2
    Send Keys  ${open_search_shortcut}

