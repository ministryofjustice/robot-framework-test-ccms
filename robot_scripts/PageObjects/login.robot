*** Settings ***
Library    Selenium2Library
Library    AutoItLibrary
Resource   ../settings.robot
Resource   ../Support/screen_content_helper.robot
Resource   ../Support/browser_helper.robot

*** Variables ***
${logged_in_screen}   EBSWebLoggedInScreen.png

*** Keywords ***
Login
    [Arguments]  ${login_username}  ${login_password}
    IF  "${login_password}" == "" or "${login_username}" == ""
        Fail  The username and password must be set in the secrets file.
    END

    Open Web Login
    Navigate To Login
    Enter Credentials And Login  ${login_username}  ${login_password}

    Wait Until Page Contains    Logged In As ${login_username}

Open Web Login
    Open Browser  ${BASE_URL}  ${EBS_BROWSER}
    Maximize Browser Window

Navigate To Login
    Win Exists    Login

Enter Credentials And Login
    [Arguments]  ${login_username}  ${login_password}
    
    Selenium2Library.Input Text    css:input[name=usernameField]    ${login_username}
    Press Keys    css:input[name=passwordField]    ${EMPTY}
    Sleep  1s
    Press keys    css:input[name=passwordField]    CTRL+a+DELETE
    Press Keys    None   ${login_password}
    Click Button    css:#SubmitButton
