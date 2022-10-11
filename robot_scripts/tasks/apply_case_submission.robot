*** Settings ***
Resource     ../Support/Cypress.robot
Library      ../Support/case_reference_locator.py
Library    OperatingSystem
Resource     ../settings.robot


*** Tasks ***
Apply Case Submission 
    Log To Console  \nNote nothing displayed for a while - cypress output only shows upon completion
    ${cy_cwd} =  Get Root Dir  ${CURDIR}
    ${cypress_response} =  Cypress runner  cypress\\e2e\\apply_case_spec.cy.js  ${cy_cwd}
    Log To Console    ${cypress_response.stdout}
    
    ${apply_reference} =  case_reference_locator.Extract Reference Number  ${cypress_response.stdout}  LAA Reference
    ${ccms_case_reference} =  case_reference_locator.Extract Reference Number  ${cypress_response.stdout}

    Log To Console  \nNew Apply Reference: ${apply_reference}
    Log To Console  \nNew Case Reference: ${ccms_case_reference}\n 

    Set Environment Variable  case_reference  ${ccms_case_reference}
    Set Environment Variable  apply_reference  ${apply_reference}

    IF  "${apply_reference}" == "" or "${ccms_case_reference}" == ""
        Fail  Unable to generate case reference due to an error, inspect logs.
    END
    