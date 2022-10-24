*** Settings ***
Resource    ../Support/screen_content_helper.robot
Resource    ../Support/interaction_helper.robot
Resource    ../Support/Dialogue.robot

*** Variables ***
${open_search_shortcut}            {UP}{UP}{DOWN}{ENTER}
${navigator_shortcut}              !w1
${window_menu_shortcut}            !w2
${service_request_menu_shortcut}   !w4

*** Keywords ***
Open Batch Request Run Window
    Wait Until Navigator Window With Title Appears    CCMS Batch User
    Send Keys   rrr

Back To Navigator
    Send Keys  ${navigator_shortcut}

Back To Choose Window
    Send Keys  ${window_menu_shortcut}

Refresh Service Request Window
    Send Keys  ${service_request_menu_shortcut}

Open Universal Search
    # Wait Until Navigator Window With Title Appears    Navigator
    Sleep  2
    Send Keys  ${open_search_shortcut}

