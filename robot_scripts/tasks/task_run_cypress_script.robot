*** Settings ***
Library     Process
Library     ../Support/case_reference_locator.py

*** Variables ***
# Note the two Cypress paths are relative to the project
# root directory. This is because Cypress has trouble if invoked 
# from robot scripts dir (even with correct paths specified)
${cypress_executable_path}    node_modules\\.bin\\cypress
${cypress_config_file}  cypress.config.js


*** Keywords ***
Cypress runner
    # Cypress script path is relative to the project root directory and the scripts should be within
    # cypress/e2e otherwise Cypress may raise "no spec files were found." error even with a valid path.
    # Use ${cwd} parameter to change cwd value when running Cypress
    [Arguments]    ${cypress_script_path}    ${cwd}=../../
    # Care with spaces - two (or more) after Run Process but then each component of the command to be executed are only separated by one,
    # after this back to 2 (or more) spaces for any subsequent parameters. (if you compare with Python subprocess.run the single-space 
    # separated items correspond with those within a list)
    # Other things to note:
    # The cwd= parameter is important because Cypress has trouble with spec paths when it's invoked sub dir
    # The shell=True needed for paths to work (seems to be a Windows thing)
    # Using '--browser chrome' cypress option because Apply script fails with default cypress electron headless browser
    ${result} =    Run Process  ${cypress_executable_path} run --config-file ${cypress_config_file} --spec ${cypress_script_path} --browser chrome  cwd=${cwd}  stderr=STDOUT  stdout=PIPE  shell=True  output_encoding=UTF-8
    [return]    ${result}


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
