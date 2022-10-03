*** Settings ***
Resource            settings.robot
Resource            Support/Hooks.robot
Library             Support/Speaker.py

Suite Setup         Run Keywords    Start Sikuli Process
                    ...  AND    Image Paths
                    ...  AND    Auto It Set Option    WinTitleMatchMode    2

Test Setup          Run Keyword    Test Startup Hook

Suite Teardown      Run Keyword    Stop Remote Server

Test Teardown       Run Keywords  Run Keyword If Test Failed    Test Failure Hook
                                        ...  AND   Run Keyword If Test Passed    Test Pass Hook
