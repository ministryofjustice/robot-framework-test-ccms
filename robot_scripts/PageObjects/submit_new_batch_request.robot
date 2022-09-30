*** Settings ***
Resource    ../Common.robot

*** Variables ***
${case_submit_input}   ${input_box_image}

*** Keywords ***
Submit Single Request
    [Arguments]  ${request_name}  ${business_rule_group}
    Send Keys    !o
    Wait Until Window With Title Appears   Submit Request
    Log To Console   Inputing text: ${request_name}
    SikuliLibrary.Input Text   ${case_submit_input}  ${request_name}
    Send Keys    {TAB}
    Wait Until Window With Title Appears    Parameters
    Send Keys    ${business_rule_group}
    Press Dialogue OK
    Wait Until Window With Title Appears    Submit Request
    Send Keys    !m
    Wait Until Decision Dialogue Appears
    Press Dialogue No
