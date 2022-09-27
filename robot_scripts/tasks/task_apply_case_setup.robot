*** Settings ***
Resource     ../Support/Cypress.robot
Library     ../Support/case_reference_locator.py


*** Tasks ***

Cypress Apply Case Submission 
    Log To Console  \nNote nothing displayed for a while - cypress output only shows upon completion

    # Finding root directory of project as Cypress runner needs CWD to be set to this for cypress to work.
    # Below works for two ways of invoking the task:
    # (a) "robot task_run_cypress_script.robot" (from the tasks dir)
    # (b) "robot --task Cypress_Apply_Case_Submission robot_scripts" (from project root dir)
    # (Note "Set Variable IF has condition, value if true, value if false")
    ${cy_cwd} =  Set Variable If    r"${CURDIR}" == r"${EXECDIR}"  ../../  ${EXECDIR}  

    # Cypress runner working directory needs to be root directory of project
    # Cypress script path is always relative to that
    ${response} =  Cypress runner  cypress\\e2e\\apply_case_spec.cy.js  ${cy_cwd}
    ##${response} =  Cypress runner  cypress\\e2e\\quick_spec.cy.js  ${cy_cwd}
    
    # Full cypress output
    Log To Console    ${response.stdout}
    
    # Using custom Python fuction to extract the case reference from the chunk of text returned by cypress
    ${apply_reference} =  case_reference_locator.extract_reference_number  ${response.stdout}  LAA Reference
    ${ccms_case_reference} =  case_reference_locator.extract_reference_number  ${response.stdout}
    Log To Console  \nNew Apply Reference: ${apply_reference}
    Log To Console  \nNew Case Reference: ${ccms_case_reference}\n 
