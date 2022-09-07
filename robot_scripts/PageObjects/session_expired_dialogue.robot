*** Settings ***
Resource  ../settings.robot
Resource    login.robot

*** Variables ***
${ok_button}   ${IMG_PATH}OkButtonSmall.png
${dialogue}    ${IMG_PATH}

*** Keywords ***
Re Login
    Click  ${ok_button}
    Login.Login   ${login_username}  ${login_password}

Dialogue Exists
    Exists    ${dialogue}

    RETURN   False