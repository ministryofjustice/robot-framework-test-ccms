*** Settings ***
Library     Screenshot
Library     speaker.py
Library     ../Support/string_utils.py
Resource    ../settings.robot
Resource    ../PageObjects/group_and_role.robot

*** Keywords ***
Test Failure Hook
    ${screenshot}=    Take Screenshot
    Log To Console    Failure screenshot: ${screenshot}
    Say If Human    The task ${TEST NAME} failed to execute

Test Startup Hook
    Say If Human  Starting task ${TEST NAME}

Test Pass Hook
    Say If Human  Done with ${TEST NAME} task

On Dialogue Title Search Fail
    [Arguments]    ${foundTitle}

    ${title}=    group_and_role.Dialogue Title
    ${contains}=    String Contains    ${foundTitle}    ${title}

    IF    ${contains}
        group_and_role.Fill And Submit    General Administration
    END
