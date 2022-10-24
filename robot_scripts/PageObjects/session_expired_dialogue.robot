*** Settings ***
Resource    ../settings.robot
Resource    login.robot
Resource    ../Support/interaction_helper.robot

*** Variables ***
${ok_button}   OkButtonSmall.png
${dialogue}

*** Keywords ***
Re Login
    [Documentation]  Not tested
    Click On  ${ok_button}
    Login.Login   ${login_username}  ${login_password}

Dialogue Exists
    [Documentation]  Not tested
    Exists    ${dialogue}

    RETURN   False