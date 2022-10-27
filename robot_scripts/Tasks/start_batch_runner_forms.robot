*** Settings ***
Resource    ../PageObjects/login.robot
Resource    ../PageObjects/batch_runner.robot
Resource    ../Support/browser_helper.robot
Resource    ../PageObjects/dashboard.robot

*** Tasks ***
Start Batch Runner Forms
    Close IE
    Login  ${business_login_username}  ${business_login_password}
    Say If Human    Logged in
    Open Batch Runner
    Say If Human    Opened batch runner
