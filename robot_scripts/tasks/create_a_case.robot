*** Settings ***
Resource   ../PageObjects/apply_case_details.robot
Resource   ../PageObjects/apply_client_details.robot
Resource   ../PageObjects/apply_submit_application.robot
Resource   ../PageObjects/apply_income_payments_assets.robot

*** Variables ***
${apply_url}  https://main-applyforlegalaid-uat.cloud-platform.service.justice.gov.uk/
${browser}    chrome
${start_button}  id:start
${email_input_field}  id:email
${password_input_field}  id:password
${sign_in_button}  css:input[type=submit]

${EXECUTION_MODE}  Human    #Human/Machine

*** Keywords ***
Test Startup Hook
        Say If Human    Starting task ${TEST NAME}
        Open Browser    ${apply_url}  ${browser}
        Click Element   ${start_button} 
        Input Text      ${email_input_field}     ${apply_username}
        Input Text      ${password_input_field}  ${apply_password}
        Click Button    ${sign_in_button}
Test Pass Hook
   Say If Human  Done with ${TEST NAME} task
   Close Browser

Test Failure Hook
   Say If Human  ${TEST NAME} task failed continue manually

*** Tasks ***
Create a Case
   Given apply_client_details.Apply Client Details
   And apply_income_payments_assets.Apply Income Payments Assets
   And apply_case_details.Apply Case Details
   Then apply_submit_application.Apply Submit Application
   Then apply_submit_application.Write CCMS Caseid In File
   Then apply_submit_application.Write Apply Caseid In File
 