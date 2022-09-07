*** Settings ***
Library    SikuliLibrary
Resource   ../settings.robot

*** Variables ***
${all_details_checkbox}  ${IMG_PATH}AllCheckbox.png
${case_refresh_button}   ${IMG_PATH}RefreshButton.png

*** Keywords ***
Refresh Case
    Click    ${all_details_checkbox}
    Click    ${case_refresh_button}