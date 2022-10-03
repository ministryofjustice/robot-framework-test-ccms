*** Settings ***
Resource    ../Common.robot
Suite Setup       Start Sikuli Process
Suite Teardown     Stop Remote Server

*** Tasks ***
Login Caseworker
    Login    ${login_username}    ${login_password}
