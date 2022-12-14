*** Settings ***
Library     Dialogs
Resource    ../settings.robot
Resource    navigator.robot

*** Variables ***
${universal_search_screen}      UniversalSearchDialogue.png
${dialogue_title_bar}           ChooseRoleUserDialogue.png
${organisation_input_box}       OrganisationSearchInputBox.png
${search_button}                SearchButton.png
${search_ok_button}             OkButtonLarge.png
${search_results_dialogue}      SearchResultsDialogue.png
${navigator_dialgue}            NavigatorDialogue.png

${ok_button_shortcut}           !k
${clear_button_shortcut}        !c
${search_button_shortcut}       !s
${back_to_search_shortcut}      !n
${backspace}                    {BACKSPACE}

${case_reference}

*** Keywords ***
Back To Case Search
    [Documentation]  Uses: AutoIt/Sikuli Returns: None
    ...  Goes back to the universal search window.
    ${exists}=    If On Universal Search

    IF    "${exists}" == "False"
        Log To Console    "We are not on universal search dialogue, going to it now."
        Back To Navigator
        Open Universal Search
    END

Search Case
    [Documentation]  Uses: AutoIt/Sikuli Returns: None
    ...  Search for a case in universal search window.
    [Arguments]    ${case_reference}
    Wait Until Screen Contains    ${universal_search_screen}
    Send Keys    ${back_to_search_shortcut}
    Send Keys    ${clear_button_shortcut}
    Input Text Until Appears    ${organisation_input_box}    ${case_reference}
    Send Keys    ${search_button_shortcut}
    Wait Until Screen Contains    ${search_results_dialogue}
    Click On    ${search_ok_button}

If On Universal Search
    [Documentation]  Uses: Sikuli, Returns: Boolean
    ...  Returns True if we're on universal search, False otherwise.
    TRY
        ${exists}=    Wait Until Window With Title Appears    Universal Search    2
    EXCEPT    AS    ${error_message}
        ${exists}=    Set Variable    False
    END

    RETURN    ${exists}

Get Case Reference
    [Documentation]  Uses: Robot, Returns: String
    ...  Prompts the user for a case reference number and returns it.
    IF    "${case_reference}" == ""
        Speaker.Say    Please enter case reference number
        ${case_reference}=    Get Value From User    Case reference number
    END

    RETURN    ${case_reference}
