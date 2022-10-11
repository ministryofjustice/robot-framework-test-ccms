*** Settings ***
Library    SikuliLibrary
Resource    ../Common.robot
Resource    Navigator.robot

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
Check Service Request Screen
    Log To Console     Checking if on Service request screen
    Common.Wait Until Screen Contains  ${service_request_screen}
    ${exists}=  Get Text From Image Matching  ${service_request_screen}
         IF  ${exists} == "True"
               Log To Console    "We are not on Service request Screen."
                              Back To Navigator
                              Open Universal Search
         END

