*** Settings ***
Library     Screenshot
Library     speaker.py
Library     SikuliLibrary  mode=NEW
Library     ../Support/string_utils.py
Resource    ../settings.robot
Resource    ../PageObjects/group_and_role.robot

*** Keywords ***
Suite Setup Hook
    Start Sikuli Process
    Add Image Path      ${IMG_PATH}
    Auto It Set Option    WinTitleMatchMode    2

Test Failure Hook
    ${screenshot}=    Take Screenshot
    Log To Console    Failure screenshot: ${screenshot}
    Say If Human    The task ${TEST NAME} failed to execute, please continue manually.

Test Startup Hook
    Say If Human  Starting task ${TEST NAME}

Test Pass Hook
    Say If Human  Done with ${TEST NAME} task

Test Teardown Hook
    Run Keyword If Test Failed    Test Failure Hook
    Run Keyword If Test Passed    Test Pass Hook

On Dialogue Title Search Fail
    [Arguments]    ${foundTitle}

    ${title}=    group_and_role.Dialogue Title
    ${contains}=    String Contains    ${foundTitle}    ${title}

    IF    ${contains}
        group_and_role.Fill And Submit    General Administration
    END
