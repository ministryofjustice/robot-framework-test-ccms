*** Settings ***
Resource            settings.robot
Resource            Support/Hooks.robot
Library            Support/Speaker.py

Suite Setup         Run Keywords    Start Sikuli Process
                    ...  AND    Image Paths
                    ...  AND    Auto It Set Option    WinTitleMatchMode    2
                    ...  AND    Speaker.Say If Human  Launching
Suite Teardown      Run Keywords    Stop Remote Server
                    ...  AND    Speaker.Say If Human  Done
Test Teardown       Run Keyword If Test Failed    Failure Hook

