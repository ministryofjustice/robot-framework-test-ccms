*** Settings ***
Library    SikuliLibrary
Resource    ../common.robot

*** Variables ***
${all_details_checkbox}  ${IMG_PATH}AllCheckbox.png
${case_refresh_button}   ${IMG_PATH}RefreshButton.png

*** Keywords ***
Refresh Case
    Common.Click On    ${all_details_checkbox}
    Common.Click On   ${case_refresh_button}