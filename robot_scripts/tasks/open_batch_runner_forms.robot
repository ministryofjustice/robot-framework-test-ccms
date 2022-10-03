*** Settings ***
Resource    ../PageObjects/login.robot
Resource    ../Common.robot
Resource    ../Support/Dialogue.robot
Resource    ../PageObjects/submit_new_batch_request.robot
Resource    ../PageObjects/Navigator.robot
Resource    ../PageObjects/batch_runner.robot
Library    Dialogs

*** Tasks ***
Open Batch Runner Forms
    Given Close IE
    And Login  ${business_login_username}  ${business_login_password}
    Say If Human    Logged in
    Then Open Batch Runner
    Say If Human    Opened batch runner
