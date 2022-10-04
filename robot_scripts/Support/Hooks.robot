*** Settings ***
Library     Speaker.py
Library     Screenshot
Resource    ../settings.robot
Resource    ../PageObjects/group_and_role.robot


*** Keywords ***
Test Failure Hook
    ${screenshot}=    Take Screenshot
    Log To Console    Failure screenshot: ${screenshot}
    Speaker.Say If Human    The task ${TEST NAME} failed to execute

Test Startup Hook
   Speaker.Say If Human  Starting task ${TEST NAME}

Test Pass Hook
   Speaker.Say If Human  Done with ${TEST NAME} task



On Dialogue Title Search Fail
    [Arguments]    ${foundTitle}

    ${title}=    group_and_role.Dialogue Title
    ${contains}=    String Contains    ${foundTitle}    ${title}

    IF    ${contains}
        group_and_role.Fill And Submit    General Administration
    END
