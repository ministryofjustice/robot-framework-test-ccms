*** Settings ***
Resource     ../Support/Cypress.robot


*** Tasks ***

Check Cypress Integration
    [Documentation]  Run a very simple cypress test that does not depend on any website.
    ${cy_cwd} =  Get Root Dir  ${CURDIR}  
    ${cypress_response} =  Cypress runner  cypress\\e2e\\quick_spec.cy.js  ${cy_cwd}
    Log To Console    ${cypress_response.stdout}
