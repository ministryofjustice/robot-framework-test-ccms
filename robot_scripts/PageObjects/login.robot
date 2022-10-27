*** Settings ***
Library    Selenium2Library
Resource   ../settings.robot

*** Variables ***
${logged_in_screen}   EBSWebLoggedInScreen.png

${username_field_locator}  css:input[name=usernameField]
${password_field_locator}  css:input[name=passwordField]
${login_button_locator}    css:#SubmitButton

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

    Selenium2Library.Input Text    ${username_field_locator}    ${login_username}
    Press Keys    ${password_field_locator}    ${EMPTY}
    # In case the user has saved details in the browser which are autofilled, let them be filled and
    # then clear them.
    Sleep  1s
    Press keys    ${password_field_locator}    CTRL+a+DELETE
    Press Keys    None   ${login_password}
    Click Button    ${login_button_locator}
