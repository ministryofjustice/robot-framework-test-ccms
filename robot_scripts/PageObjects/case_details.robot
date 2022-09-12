*** Settings ***
Library    SikuliLibrary
Resource    ../Common.robot

*** Variables ***
${all_details_checkbox}  ${IMG_PATH}AllCheckbox.png
${case_refresh_button}   ${IMG_PATH}RefreshButton.png

*** Keywords ***
Refresh Case
    Common.Wait Until Dialogue With Text   eBusiness Center
    Common.Click On    ${all_details_checkbox}
    Common.Click On   ${case_refresh_button}