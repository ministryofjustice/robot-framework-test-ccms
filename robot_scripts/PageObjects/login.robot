*** Settings ***
Resource   ../settings.robot
Resource    ../Common.robot

*** Variables ***
${login_screen}  ${IMG_PATH}EBSLoginScreen.png
${logged_in_screen}   ${IMG_PATH}EBSWebLoggedInScreen.png
${ie_path}  C:/Program Files/Internet Explorer/iexplore.exe
${base_url}  https://ccmsebs.uat.legalservices.gov.uk/OA_HTML/OA.jsp?OAFunc=OAHOMEPAGE{#}

*** Keywords ***
Login
    [Arguments]  ${login_username}  ${login_password}
    IF  "${login_password}" == "" or "${login_username}" == ""
        Fail  The username and password must be set in the secrets file.
    END

    Open Browser
    Navigate To Login
    Enter Credentials And Login  ${login_username}  ${login_password}

Open Browser
    Auto It Set Option   WinTitleMatchMode   2
    Send    \#r
    Win Wait   Run
    Send    "${ie_path}" "${base_url}"{ENTER}
    Wait For Active Window    Internet Explorer

    Wait Until Screen Contains    ${login_screen}    ${GLOBAL_WAIT_TIMEOUT}

Navigate To Login
    Win Exists    Login

Enter Credentials And Login
    [Arguments]  ${login_username}  ${login_password}
    Send    ${login_username}{TAB}${login_password}{ENTER}
    Win Exists  Oracle Applications Home Page
    Wait Until Screen Contain    ${logged_in_screen}    timeout=30