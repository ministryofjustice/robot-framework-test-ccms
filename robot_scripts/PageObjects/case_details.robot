*** Settings ***
Resource    ../settings.robot
Resource    ../Support/ebs_helper.robot
Resource    ../Support/Dialogue.robot

*** Variables ***
${all_details_checkbox}             AllCheckbox.png
${case_refresh_button}              RefreshButton.png
${submissions_text}                 SubmissionsText.PNG
${details_button}                   DetailsButton.PNG
${ebusiness_center_window}          EBusinessCenterWindow.PNG
${drill_down_list_details_button}   DrilldownListDetailsButton.PNG
${drilldown_list_screen}            DrilldownlistSubmissionsScreen.PNG
${service_request_screen}           meritsAssessment/service_request_screen.PNG

${down_arrow_shortcut}  {DOWN}

*** Keywords ***
Refresh Case
    [Documentation]  Uses: Sikuli. Retruns: none.
    ...   Refreshes the case details.
    Log To Console    Refresh case status

    Wait Until Window With Title Appears    eBusiness Center
    Click On    ${all_details_checkbox}
    Click On    ${case_refresh_button}

Submissions Status Check
    [Documentation]  Uses: Sikuli. Retruns: none.
    ...   Opens the service request screen for a case.
    ...   TODO: The method name probably needs to change.
    Log To Console     Submission status check
    #Down arrow is used to move focus from above image
    Send Keys   ${down_arrow_shortcut}
    Click On    ${submissions_text}
    Click On    ${details_button}
    Wait Until Screen Contains  ${drilldown_list_screen}
    Click On    ${drill_down_list_details_button}
    Wait Until Screen Contains  ${service_request_screen}