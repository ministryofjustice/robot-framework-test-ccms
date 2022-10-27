*** Settings ***
Resource    ../Support/interaction_helper.robot

*** Variables ***
${request_name}
${business_rule_group}

*** Keywords ***
Get Request Name
    ${value}=   Get User Input If Not Exists  ${request_name}  request name

    RETURN  ${value}

Get Business Rule Group
    ${value}=   Get User Input If Not Exists  ${business_rule_group}  business rule group

    RETURN  ${value}
