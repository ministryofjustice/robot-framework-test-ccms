*** Settings ***
Resource            settings.robot
Resource            Support/Hooks.robot
Library             Support/Speaker.py

Suite Setup         Run Keywords    Start Sikuli Process
                    ...  AND    Image Paths
                    ...  AND    Auto It Set Option    WinTitleMatchMode    2

Test Setup          Run Keywords   no operation
                    ...  AND    Speaker.Say If Human  Starting task ${TEST NAME}

Suite Teardown      Run Keywords    Stop Remote Server
                    ...  AND    Speaker.Say If Human  Done with ${PREV_TEST_NAME} task

Test Teardown       Run Keyword If Test Failed    Failure Hook