*** Settings ***
Resource    ../PageObjects/login.robot
Resource    ../Common.robot
Resource    ../Support/Dialogue.robot
Resource    ../PageObjects/submit_new_batch_request.robot
Resource    ../PageObjects/Navigator.robot
Resource    ../PageObjects/batch_runner.robot
Library    Dialogs

*** Variables ***
${business_rule_group}
${request_name}

*** Tasks ***
Trigger Batch Process
    # Request name: CCMS Business Rules Monitor
    # Business rule group: Bill Approve
    ${request_name}=  Get Request Name
    ${business_rule_group}=  Get Business Rule Group

    Given Focus EBS Forms
    Then Submit Single Request  ${request_name}  ${business_rule_group}
    Say If Human   Submitted single request 
    And Open Batch Request Run Window
    Say If Human   Opened request window
