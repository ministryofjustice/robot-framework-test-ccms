*** Settings ***
Resource    ../PageObjects/login.robot
Resource    ../Common.robot
Resource    ../Support/Dialogue.robot
Resource    ../PageObjects/submit_new_batch_request.robot
Resource    ../PageObjects/Navigator.robot
Resource    ../PageObjects/batch_runner.robot
Library    Dialogs

*** Variables ***
${case_submit_input}   ${input_box_image}
${business_rule_group}
${request_name}

*** Tasks ***
Open Batch Process Window
    Given Close IE
    And Login  ${business_login_username}  ${business_login_password}
    Say If Human    Logged in
    Then Open Batch Runner
    Say If Human    Opened batch runner
   
Trigger Batch Process For Case
    # Request name: CCMS Business Rules Monitor
    # Business rule group: Bill Approve
    ${request_name}=  Get Request Name
    ${business_rule_group}=  Get Business Rule Group

    Given Focus EBS Forms
    When Submit Single Request  ${request_name}   ${business_rule_group}
    Say If Human    Submitted single request
    Then Open Batch Request Run Window
    Say If Human    Opened request window
