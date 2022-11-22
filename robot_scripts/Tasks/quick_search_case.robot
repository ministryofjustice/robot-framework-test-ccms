*** Settings ***
Resource            ../settings.robot
Resource            ../Support/ebs_helper.robot
Resource            ../PageObjects/universal_search.robot
Resource            ../PageObjects/case_details.robot


*** Variables ***
${quick_search_tab}    QuickSearchTab(unhighlighted).PNG
${quick_organisation_input_box}    QuickOrganisationSearchInputBox.PNG
${quick_seach_selected}    QuickSearchSelected.PNG
# Images below are the same for both default search and quick search
${search_results_dialogue}    SearchResultsDialogue.png
${search_ok_button}             OkButtonLarge.png

${search_button_shortcut}       !s

*** Keywords ***
Go To Quick Search Tab
    Click On  ${quick_search_tab}
    Wait Until Screen Contains  ${quick_seach_selected}

Do Quick Search
    [Arguments]    ${case_reference}
    Input Text Until Appears    ${quick_organisation_input_box}    ${case_reference}
    Send Keys    ${search_button_shortcut}
    Wait Until Screen Contains    ${search_results_dialogue}
    Click On    ${search_ok_button}
    

*** Tasks ***
Quick Search Case
    # This part same as search case
    ${case_reference}=  Universal_Search.Get Case Reference

    Ensure EBS Forms Screen  ${login_username}  ${login_password}
    Say If Human    Opened forms
    Universal_Search.Back To Case Search

    # New for Quick Search
    Say If Human  Going to quick search, we've no time to lose!
    Go To Quick Search Tab
    Say if Human  Warning Quick Search, hold on to your hat!
    Do Quick Search  ${case_reference}
    Say If Human    Showing speedy case details now
    
    # Same as seach case
    case_Details.Refresh Case
    