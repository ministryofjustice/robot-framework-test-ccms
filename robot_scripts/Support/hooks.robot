*** Settings ***
Library     Screenshot
Library     speaker.py
Library     SikuliLibrary  mode=NEW
Library     ../Support/string_utils.py
Resource    ../settings.robot
Resource    ../PageObjects/group_and_role.robot

*** Keywords ***
Suite Setup Hook
    [Documentation]  Runs before the suite of tests/tasks runs.
    Start Sikuli Process
    Add Image Path      ${IMG_PATH}
    Auto It Set Option    WinTitleMatchMode    2

Test Failure Hook
    [Documentation]  Runs after a task fails to execute.
    ${screenshot}=    Take Screenshot
    Log To Console    Failure screenshot: ${screenshot}
    Say If Human    The task ${TEST NAME} failed to execute, please continue manually.

Test Startup Hook
    [Documentation]  Runs for each test/task starts up.
    Say If Human  Starting task ${TEST NAME}

Test Pass Hook
    [Documentation]  Runs after a test/task passes.
    Say If Human  Done with ${TEST NAME} task

Test Teardown Hook
    [Documentation]  Runs after a test/task finishes regardless of pass/fail.
    Run Keyword If Test Failed    Test Failure Hook
    Run Keyword If Test Passed    Test Pass Hook

On Dialogue Title Search Fail
    [Documentation]  Runs when dialogue title is being searched but fails to find the title provided.
    [Arguments]    ${foundTitle}

    ${title}=    group_and_role.Dialogue Title
    ${contains}=    String Contains    ${foundTitle}    ${title}

    IF    ${contains}
        group_and_role.Fill And Submit    General Administration
    END
