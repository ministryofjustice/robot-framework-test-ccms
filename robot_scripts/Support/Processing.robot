*** Settings ***
Library    Process

*** Keywords ***
Task Kill
    [Arguments]  ${task}
    ${output}=  Run Process   taskkill   /F  /IM  ${task}  /T     stderr=STDOUT
    Log To Console    ${output.stdout}
