*** Settings ***
Library  Process
Resource   secrets.robot

*** Variables ***
# Note the two Cypress paths are relative to the project
# root directory. This is because Cypress has trouble if invoked 
# from robot scripts dir (even with correct paths specified)
${cypress_executable_path}    node_modules\\.bin\\cypress
${cypress_config_file}  cypress.config.js
# Note ${apply_username} and ${apply_password} are imported from secrets.robot

*** Keywords ***
Cypress runner
    # Cypress script path is relative to the project root directory and the scripts should be within
    # cypress/e2e otherwise Cypress may raise "no spec files were found." error even with a valid path.
    [Arguments]    ${cypress_script_path}
    # Care with spaces - two (or more) after Run Process but then each component of the command to be executed are only separated by one,
    # after this back to 2 (or more) spaces for any subsequent parameters. (if you compare with Python subprocess.run the single-space 
    # separated items correspond with those within a list)
    # Other things to note:
    # The cwd=..\\ is important because Cypress has trouble with spec paths if invoked from robot_scripts dir
    # The shell=True needed for paths to work (seems to be a Windows thing)
    ${result} =    Run Process  ${cypress_executable_path} run --config-file ${cypress_config_file} --spec ${cypress_script_path}  cwd=..\\  stderr=STDOUT  stdout=PIPE  shell=True  output_encoding=UTF-8
    [return]    ${result}


*** Tasks ***
Cypress simple 
    # Cypress runner working directory is root directory of project, 
    # so cypress script path relative to that
    ${response} =  Cypress runner  quick_spec.cy.js
    Log To Console    ${response.stdout}
    


