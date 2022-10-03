*** Settings ***
Resource     ../Support/Cypress.robot
Resource     ../settings.robot
Library     ../Support/case_reference_locator.py


*** Tasks ***

Cypress Apply Case Submission 
    Log To Console  \nNote nothing displayed for a while - cypress output only shows upon completion
    ${cy_cwd} =  Get Root Dir  ${CURDIR}
    ${cypress_response} =  Cypress runner  cypress\\e2e\\apply_case_spec.cy.js  ${cy_cwd}
    Log To Console    ${cypress_response.stdout}
    
    ${apply_reference} =  case_reference_locator.Extract Reference Number  ${cypress_response.stdout}  LAA Reference
    ${ccms_case_reference} =  case_reference_locator.Extract Reference Number  ${cypress_response.stdout}
    Log To Console  \nNew Apply Reference: ${apply_reference}
    Log To Console  \nNew Case Reference: ${ccms_case_reference}\n 
    