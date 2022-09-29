*** Settings ***
Resource    ../Common.robot

*** Variables ***

${open_search_shortcut}   {UP}{UP}{DOWN}{ENTER}
${navigator_shortcut}     !w1

*** Keywords ***
Open Batch Request Run Window
    Wait Until Navigator Window With Title Appears    CCMS Batch User
    Send Keys   rrr

Back To Navigator
    Send Keys  ${navigator_shortcut}

Open Universal Search
    # Wait Until Navigator Window With Title Appears    Navigator
    Sleep  2
    Send Keys  ${open_search_shortcut}
