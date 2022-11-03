*** Settings ***
Library    Process

*** Keywords ***
Task Kill
    [Documentation]  Kills all processes of a process name provided.
    [Arguments]  ${task}
    ${output}=  Run Process   taskkill   /F  /IM  ${task}  /T     stderr=STDOUT
    Log To Console    ${output.stdout}
