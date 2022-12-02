*** Settings ***
Library    Selenium2Library
Library    Collections
Resource   ../settings.robot

*** Variables ***
${logged_in_screen}   EBSWebLoggedInScreen.png

${username_field_locator}  css:input[name=usernameField]
${password_field_locator}  css:input[name=passwordField]
${login_button_locator}    css:#SubmitButton

*** Keywords ***
Login
    [Documentation]  Uses: Selenium. Retruns: none.
    ...   Log in to EBS with provided credentials.
    [Arguments]  ${login_username}  ${login_password}
    IF  "${login_password}" == "" or "${login_username}" == ""
        Fail  The username and password must be set in the secrets file.
    END

    Open Web Login
    Navigate To Login
    Enter Credentials And Login  ${login_username}  ${login_password}

    Wait Until Page Contains    Logged In As ${login_username}

Open Web Login
    [Documentation]  Uses: Selenium. Retruns: none.
    ...   Opens the EBS login page.
    Open Browser  ${BASE_URL}  ${EBS_BROWSER}  options=${EBS_BROWSER_OPTIONS}

    Maximize Browser Window

Navigate To Login
    [Documentation]  Uses: Selenium. Retruns: none.
    ...   Checks if the login screen is present.
    Win Exists    Login

Enter Credentials And Login
    [Documentation]  Uses: Selenium. Retruns: none.
    ...   Fill in the login credentials on the login screen and submit.
    [Arguments]  ${login_username}  ${login_password}

    Selenium2Library.Input Text    ${username_field_locator}    ${login_username}
    Press Keys    ${password_field_locator}    ${EMPTY}
    # In case the user has saved details in the browser which are autofilled, let them be filled and
    # then clear them.
    Sleep  1s
    Press keys    ${password_field_locator}    CTRL+a+DELETE
    Press Keys    None   ${login_password}
    Click Button    ${login_button_locator}
