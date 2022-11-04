*** Settings ***
Library     AutoItLibrary
Resource    ../settings.robot
Resource    ../Support/processing.robot

*** Keywords ***
Focus Browser
    [Documentation]  Uses: AutoIt, Returns: None
    ...  Returns focus to the browser with title Oracle.
    Win Activate  Oracle

Close IE
    [Documentation]  Uses: Robot, Returns: None
    ...  Closes all instances of internet explorer.
    Task Kill  task=iexplore.exe