*** Settings ***
Library    Selenium2Library
Resource   ../settings.robot
Resource   ../Support/screen_content_helper.robot
Resource   ../Support/browser_helper.robot

*** Variables ***
${logged_in_screen}   ${IMG_PATH}EBSWebLoggedInScreen.png

*** Keywords ***
Login
    [Arguments]  ${login_username}  ${login_password}
    IF  "${login_password}" == "" or "${login_username}" == ""
        Fail  The username and password must be set in the secrets file.
    END

    Open Web Login
    Navigate To Login
    Enter Credentials And Login  ${login_username}  ${login_password}

    Wait Until Screen Contains    ${logged_in_screen}   ${GLOBAL_LONG_WAIT_TIMEOUT}

Open Web Login
    Open Browser  ${BASE_URL}  ${EBS_BROWSER}
    Maximize Browser Window

Navigate To Login
    Win Exists    Login

Enter Credentials And Login
    [Arguments]  ${login_username}  ${login_password}

    Selenium2Library.Input Text    css:input[name=usernameField]    ${login_username}
    Selenium2Library.Press Keys    css:input[name=passwordField]    ${EMPTY}
    Sleep  1s
    Selenium2Library.Press keys    css:input[name=passwordField]    CTRL+a+DELETE
    Selenium2Library.Press Keys    None   ${login_password}
    Selenium2Library.Click Button    css:#SubmitButton

    Wait Until Screen Contain    ${logged_in_screen}    timeout=${GLOBAL_LONG_WAIT_TIMEOUT}