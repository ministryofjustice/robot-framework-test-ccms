*** Settings ***
Resource    settings.robot
Resource    Common.robot
Suite Setup       Start Sikuli Process
Suite Teardown     Stop Remote Server

*** Tasks ***
Run Login
    Login    ${login_username}    ${login_password}
