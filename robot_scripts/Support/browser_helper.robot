*** Settings ***
Resource    ../settings.robot
Resource    ../Support/processing.robot

*** Keywords ***
Focus Browser
    Win Activate  Oracle

Close IE
    Task Kill  task=iexplore.exe