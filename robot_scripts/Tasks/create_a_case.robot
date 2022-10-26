*** Settings ***
Library     ../Support/speaker.py
Resource    ../secrets.robot
Resource    ../PageObjects/apply_client_details.robot
Resource    ../PageObjects/apply_submit_application.robot
Resource    ../PageObjects/apply_income_payments_assets.robot


*** Variables ***
${APPLY_URL}                https://main-applyforlegalaid-uat.cloud-platform.service.justice.gov.uk/
${APPLY_BROWSER}            chrome
${start_button}             id:start
${email_input_field}        id:email
${password_input_field}     id:password
${sign_in_button}           css:input[type=submit]


*** Tasks ***
Create a Case
    apply_client_details.Apply Client Details
    apply_income_payments_assets.Apply Income Payments Assets
    apply_case_details.Apply Case Details
    apply_submit_application.Apply Submit Application
    apply_submit_application.Write Apply Caseid In File    apply_laa_reference.txt
    apply_submit_application.Write CCMS Caseid In File    ccms_case_reference.txt


*** Keywords ***
Test Startup Hook
    Say If Human    Starting task ${TEST NAME}
    Open Browser    ${APPLY_URL}    ${APPLY_BROWSER}
    Click Element   ${start_button}
    Input Text      ${email_input_field}    ${apply_username}
    Input Text      ${password_input_field}    ${apply_password}
    Click Button    ${sign_in_button}

Test Pass Hook
    Say If Human    Done with ${TEST NAME} task
    Close Browser

Test Failure Hook
    Say If Human    ${TEST NAME} task failed continue manually
