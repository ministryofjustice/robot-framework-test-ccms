*** Settings ***
Resource   navigator.robot
Resource   ../Support/ebs_helper.robot

*** Variables ***
${service_request_screen}           meritsAssessment/service_request_screen.PNG

*** Keywords ***
Check If On Service Request Screen
    [Documentation]  Uses: AutoIt/Sikuli Returns: None
    ...  Checks if we're on the service request window, if not calls on refresh.
    Log To Console     Checking if on Service request screen
    ${exists}=  Win Exists  Service Request
    Wait Until Screen Contains  ${service_request_screen}
    IF  ${exists} == 0
        Log To Console     "We are not on Service request Screen."
        Refresh Service Request Window
    END