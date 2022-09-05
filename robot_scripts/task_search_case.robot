*** Settings ***
Library     Dialogs
Resource    settings.robot
Resource    reusables.robot
Suite Setup       Start Sikuli Process
Suite Teardown     Stop Remote Server

*** Test Cases ***
Start EBS
    Open EBS

*** Keywords ***
Open EBS
    Auto It Set Option   WinTitleMatchMode   2

    ${case_reference}=  Get Value From User  Case reference number

    Ensure EBS Forms Screen
    Choose Group and Role
    Back To Case Search

    Click    ${IMG_PATH}OrganisationSearchInputBox.png  200  2
    Send    ^a{DEL}
    Input Text    ${IMG_PATH}OrganisationSearchInputBox.png    ${case_reference}
    Click    ${IMG_PATH}SearchButton.png
    Click    ${IMG_PATH}OkButtonLarge.png
    Click    ${IMG_PATH}AllCheckbox.png
    Click    ${IMG_PATH}RefreshButton.png

