*** Settings ***
Library             Speaker.py
Library    Screenshot
Resource            ../settings.robot

*** Keywords ***
Failure Hook
    ${screenshot}=  Take Screenshot
    Log To Console    Failure screenshot: ${screenshot}
    Speaker.Say If Human    The task failed to execute
