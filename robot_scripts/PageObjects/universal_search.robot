*** Settings ***
Resource   ../settings.robot
Resource   ../Common.robot

*** Variables ***
${merits_case_work_link_element}  MeritsCaseWorkerLink.PNG
${merits_case_and_clients_link_element}  MeritsCasesAndClientsLink.png
${return_to_search_button}  ReturnToSearchButton.png
${clear_form_values_button}  ClearButton.png
${dialogue_title_bar}  ChooseRoleUserDialogue.png
${organisation_input_box}  OrganisationSearchInputBox.png
${search_button}  SearchButton.png
${search_ok_button}  OkButtonLarge.png
${search_results_dialogue}  SearchResultsDialogue.png
${navigator_dialgue}  NavigatorDialogue.png
${ok_button_shortcut}   !k
${clear_button_shortcut}  !c
${search_button_shortcut}  !s
${open_search_shortcut}   c
${back_to_search_shortcut}  !n
${universal_search_shortcut}  !w1

*** Keywords ***
Back To Case Search
    ${exists}=  If On Universal Search

    Log To Console    UniversalSearch The value of exists is: ${exists}

    IF  "${exists}" == "False"
        Log To Console    "We are not on universal search dialogue, going to it now."
        Send  ${universal_search_shortcut}
        Wait Until Screen Contains    ${navigator_dialgue}    ${GLOBAL_WAIT_TIMEOUT}
        Send  ${open_search_shortcut}
    END

Search Case
    [Arguments]  ${case_reference}
    Send    ${back_to_search_shortcut}
    Send    ${clear_button_shortcut}
    Input Text Until Appears    ${organisation_input_box}    ${case_reference}
    Send   ${search_button_shortcut}
    Wait Until Screen Contains    ${search_results_dialogue}   timeout=10
    Click   ${search_ok_button}
    Wait Until Dialogue With Text   eBusiness Center

If On Universal Search
    [Documentation]  returns True or False
    
    ${exists}=  Image With Text Exists On Screen    ${dialogue_title_bar}    Universal Search

    RETURN  ${exists}
