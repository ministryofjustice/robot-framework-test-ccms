*** Settings ***
Resource     ../Support/Cypress.robot


*** Tasks ***

Check Cypress Integration
    [Documentation]  Check integration with cypress. Runs a very simple cypress test that does not depend on any website.

    # Finding root directory of project as Cypress runner needs CWD to be set to this for cypress to work.
    # Below works for two ways of invoking the task:
    # (a) "robot task_run_cypress_script.robot" (from the tasks dir)
    # (b) "robot --task Cypress_Apply_Case_Submission robot_scripts" (from project root dir)
    # (Note "Set Variable IF has condition, value if true, value if false")
    ${cy_cwd} =  Set Variable If    r"${CURDIR}" == r"${EXECDIR}"  ../../  ${EXECDIR}  

    # Cypress runner working directory needs to be root directory of project
    # Cypress script path is always relative to that
    ${response} =  Cypress runner  cypress\\e2e\\quick_spec.cy.js  ${cy_cwd}
    
    # Full cypress output
    Log To Console    ${response.stdout}
