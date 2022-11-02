*** Settings ***
Resource    ../PageObjects/login.robot
Resource    ../PageObjects/dashboard.robot

*** Tasks ***
View Batch Processes
    Login    ${business_login_username}  ${business_login_password}
    Open Batch Runner
    Open Batch Process Status Check Window
