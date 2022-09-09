*** Settings ***
Resource  ../settings.robot
Resource    login.robot

*** Variables ***
${ok_button}   ${IMG_PATH}OkButtonSmall.png
${dialogue}    ${IMG_PATH}

*** Keywords ***
Re Login
    [Documentation]  Not tested
    Click On  ${ok_button}
    Login.Login   ${login_username}  ${login_password}

Dialogue Exists
    [Documentation]  Not tested
    Exists    ${dialogue}

    RETURN   False