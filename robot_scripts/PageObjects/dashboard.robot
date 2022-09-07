*** Settings ***
Resource   ../settings.robot
Resource   ../reusables.robot
Resource    session_expired_dialogue.robot

*** Variables ***
${merits_case_work_link_element}  ${IMG_PATH}MeritsCaseWorkerLink.PNG
${merits_case_and_clients_link_element}  ${IMG_PATH}MeritsCasesAndClientsLink.png
${return_to_search_button}  ${IMG_PATH}ReturnToSearchButton.png
${clear_form_values_button}  ${IMG_PATH}ClearButton.png

*** Keywords ***
Start EBS merits
    Auto It Set Option   WinTitleMatchMode   2

    ${exists}=  If On EBS Forms

    Log To Console    EBS Forms - Value of exists is: ${exists}

    IF  ${exists} == 0
        Log To Console    "EBS forms are not open, opening now."
        Ensure EBS Web Screen    ${login_username}    ${login_password}

        Click Merits Link When Visible
        Click Merits Case Search Link When Visible
    END

    # Run Keyword If   Session_Expired_Dialogue.Dialogue Exists   Session_Expired_Dialogue.Re Login

    Wait For Active Window    Oracle Applications - UAT

Click Merits Link When Visible
    Wait Until Screen Contains    ${merits_case_work_link_element}    10
    Click    ${merits_case_work_link_element}

Click Merits Case Search Link When Visible
    Wait Until Screen Contains    ${merits_case_and_clients_link_element}    10
    Click    ${merits_case_and_clients_link_element}