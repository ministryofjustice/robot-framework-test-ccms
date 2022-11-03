*** Settings ***
Resource    ../settings.robot
Resource    login.robot
Resource    ../Support/ebs_helper.robot

*** Variables ***
${ok_button}   OkButtonSmall.png
${dialogue}

*** Keywords ***
Re Login
    [Documentation]  Uses: AutoIt/Sikuli Returns: None
    ...  Re-logs in when the session has expired.
    Click On  ${ok_button}
    Login.Login   ${login_username}  ${login_password}

Dialogue Exists
    [Documentation]  Uses: AutoIt/Sikuli Returns: None
    ...  Checks if the session expired message exists.
    Exists    ${dialogue}

    RETURN   False