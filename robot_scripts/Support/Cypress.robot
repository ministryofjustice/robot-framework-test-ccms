*** Settings ***
Library     Process


*** Variables ***
# Note the two Cypress paths are relative to the project
# root directory. This is because Cypress has trouble if invoked 
# from robot scripts dir (even with correct paths specified)
${cypress_executable_path}    node_modules\\.bin\\cypress
${cypress_config_file}  cypress.config.js


*** Keywords ***
Cypress runner
    [Documentation]  Run cypress script and return its text output
    # Cypress script path is relative to the project root directory and the scripts should be within
    # cypress/e2e otherwise Cypress may raise "no spec files were found." error even with a valid path.
    # Use ${cwd} parameter to change cwd value when running Cypress
    [Arguments]    ${cypress_script_path}    ${cwd}=../../
    # Care with spaces - two (or more) after Run Process but then each component of the command to be executed are only separated by one,
    # after this back to 2 (or more) spaces for any subsequent parameters. (if you compare with Python subprocess.run the single-space 
    # separated items correspond with those within a list)
    # Other things to note:
    # The cwd= parameter is important because Cypress has trouble with spec paths when it's invoked from sub dir
    # The shell=True needed for paths to work (seems to be a Windows thing)
    # Using '--browser chrome' cypress option because Apply script fails with default cypress electron headless browser
    ${result} =    Run Process  ${cypress_executable_path} run --config-file ${cypress_config_file} --spec ${cypress_script_path} --browser chrome  cwd=${cwd}  stderr=STDOUT  stdout=PIPE  shell=True  output_encoding=UTF-8
    [return]    ${result}
