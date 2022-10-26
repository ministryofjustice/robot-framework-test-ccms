*** Settings ***
Resource    ../settings.robot
Resource    ../Support/interaction_helper.robot
Resource    ../Support/screen_content_helper.robot

*** Variables ***
${all_details_checkbox}             ${IMG_PATH}AllCheckbox.png
${case_refresh_button}              ${IMG_PATH}RefreshButton.png
${submissions_text}                 ${IMG_PATH}SubmissionsText.PNG
${details_button}                   ${IMG_PATH}DetailsButton.PNG
${ebusiness_center_window}          ${IMG_PATH}EBusinessCenterWindow.PNG
${drill_down_list_details_button}   ${IMG_PATH}DrilldownListDetailsButton.PNG
${drilldown_list_screen}            ${IMG_PATH}/DrilldownlistSubmissionsScreen.PNG
${service_request_screen}           ${IMG_PATH}/meritsAssessment/service_request_screen.PNG

${down_arrow_shortcut}  {DOWN}

*** Keywords ***
Refresh Case
    Log To Console    Refresh case status

    Wait Until Window With Title Appears    eBusiness Center
    Click On    ${all_details_checkbox}
    Click On    ${case_refresh_button}

Submissions Status Check
    Log To Console     Submission status check
    #Down arrow is used to move focus from above image
    Send Keys   ${down_arrow_shortcut}
    Click On    ${submissions_text}
    Click On    ${details_button}
    Wait Until Screen Contains  ${drilldown_list_screen}
    Click On    ${drill_down_list_details_button}
    Wait Until Screen Contains  ${service_request_screen}