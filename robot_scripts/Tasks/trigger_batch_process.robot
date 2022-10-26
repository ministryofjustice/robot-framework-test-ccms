*** Settings ***
Resource    ../Support/ebs_helpers.robot
Resource    ../PageObjects/submit_new_batch_request.robot
Resource    ../PageObjects/batch_runner.robot

*** Variables ***
${business_rule_group}
${request_name}

*** Tasks ***
Trigger Batch Process
    ${request_name}=  Get Request Name
    ${business_rule_group}=  Get Business Rule Group

    Focus EBS Forms
    Submit Single Request  ${request_name}  ${business_rule_group}
    Say If Human   Submitted single request
    Open Batch Request Run Window
    Say If Human   Opened request window
