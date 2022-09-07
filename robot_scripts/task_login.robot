*** Settings ***
Resource    settings.robot
Resource    reusables.robot
Suite Setup       Start Sikuli Process
Suite Teardown     Stop Remote Server

*** Test Cases ***
Run Login
    Login    ${login_username}    ${login_password}
