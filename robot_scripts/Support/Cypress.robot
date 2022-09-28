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
    ...    Note cypress_script path is relative to the project root directory.  Also the scripts should be within
    ...    cypress/e2e otherwise Cypress may raise "no spec files were found" error even with a valid path.
    ...    Plus cypress needs to be invoked from the project root directory. Use ${cwd} parameter to set this. 
    [Arguments]    ${cypress_script_path}    ${cwd}=../../
    # Take care when editing  Run Process below:
    # (a) Some of the parameters must be separated by one character rather than the usual Robot Framework two (those that make up the command to be executed).
    # (b) shell=True needed for paths to work (seems to be a Windows thing)
    # (c) '--browser chrome' cypress option because Apply script fails with default cypress electron headless browser
    ${result} =    Run Process  ${cypress_executable_path} run --config-file ${cypress_config_file} --spec ${cypress_script_path} --browser chrome  cwd=${cwd}  stderr=STDOUT  stdout=PIPE  shell=True  output_encoding=UTF-8
    [return]    ${result}


Get Root Dir
    [Documentation]  Return the path to project root directory. Created to solve problem with invoking cypress.
    ...    Takes the ${CURDIR} value of its caller as Argument
    ...    Only known to work for: 
    ...        (a) scripts invoked from project root directory, e.g. as 'python -m robot --task search_for_case robot_scripts'
    ...        (b) scripts invoked from robot_scripts/tasks e.g. as 'robot task_apply_case_setup.robot'
    ...    May fail in other circumstances.
    [Arguments]    ${callers_curdir}
    ${dir} =    Set Variable If    r"${callers_curdir}" == r"${EXECDIR}"  ../../  ${EXECDIR}
    [return]    ${dir}
