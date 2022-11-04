*** Settings ***
Resource    ../Support/ebs_helper.robot

*** Variables ***
${request_name}
${business_rule_group}

*** Keywords ***
Get Request Name
    [Documentation]  Uses: Robot. Returns: String.
    ...  Prompts the user for request name input.
    ${value}=   Get User Input If Not Exists  ${request_name}  request name

    RETURN  ${value}

Get Business Rule Group
    [Documentation]  Uses: Robot. Returns: String.
    ...  Prompts the user for business rule group input.
    ${value}=   Get User Input If Not Exists  ${business_rule_group}  business rule group

    RETURN  ${value}
