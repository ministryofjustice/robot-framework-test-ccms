*** Settings ***
Resource   settings.robot
Resource    reusables.robot
Suite Setup       Start Sikuli Process
Suite Teardown     Stop Remote Server

*** Test Cases ***
Start EBS
    Open EBS merits

*** Keywords ***
Open EBS merits
    Start EBS merits
