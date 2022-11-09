*** Settings ***
Library     ../Support/speaker.py
Library      ListenerLibrary
Resource    ../settings.robot
Resource    ../PageObjects/apply_client_details.robot
Resource    ../PageObjects/apply_submit_application.robot
Resource    ../PageObjects/apply_income_payments_assets.robot

*** Variables ***
${start_button}             id:start
${email_input_field}        id:email
${password_input_field}     id:password
${sign_in_button}           css:input[type=submit]

*** Tasks ***
Create a Case
    Set Library Search Order	Selenium2Library
    Open Browser    ${APPLY_URL}    ${APPLY_BROWSER}
    Click Element   ${start_button}
    Selenium2Library.Input Text      ${email_input_field}    ${apply_username}
    Selenium2Library.Input Text      ${password_input_field}    ${apply_password}
    Click Button    ${sign_in_button}

    apply_client_details.Apply Client Details
    apply_income_payments_assets.Apply Income Payments Assets
    apply_case_details.Apply Case Details
    apply_submit_application.Apply Submit Application
    apply_submit_application.Write Apply Caseid In File    apply_laa_reference.txt
    apply_submit_application.Write CCMS Caseid In File    ccms_case_reference.txt
    Close Browser
    Register End Keyword listener      Log to Console   message form end keyword listener    level=TRACE

