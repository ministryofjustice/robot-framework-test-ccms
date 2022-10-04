*** Settings ***
Resource    ../Common.robot
Suite Setup       Start Sikuli Process
Suite Teardown     Stop Remote Server

*** Tasks ***
Login Business User
    Login    ${business_login_username}  ${business_login_password} 
