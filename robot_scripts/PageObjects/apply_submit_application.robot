*** Settings ***
Library     ../Support/StringUtils.py
Library     OperatingSystem
Resource    ../PageObjects/apply_case_details.robot


*** Variables ***
${path}                                             robot_scripts\\tasks\\Casedetails\\
${ccms_case_reference_id_from_application_page}     //*[@id="main-content"]/div[2]/div/div[1]/dl/dd[3]
${apply_case_reference_id_from_application_page}    //*[@id="main-content"]/div[2]/div/div[1]/dl/dd[2]


*** Keywords ***
Apply Submit Application
    #Getting the client name, LAA reference and CCMS reference
    ${caseid_present}=    Run keyword And Return Status
    ...    Element Text Should Not Be
    ...    ${ccms_case_reference_id_from_application_page}
    ...    ${EMPTY}
    ${count}     Set Variable   0
    WHILE    ${caseid_present}==False  or  ${count} >= 60
        Reload Page
        ${caseid_present}=    Run keyword And Return Status
        ...    Element Text Should Not Be
        ...    ${ccms_case_reference_id_from_application_page}
        ...    ${EMPTY}
        ${count}=    Evaluate    ${count} + 1
    END

    Wait Until Element Is Visible    ${ccms_case_reference_id_from_application_page}

Write CCMS Caseid In File
    ${ccms_case_id}=    Get Element Attribute    ${ccms_case_reference_id_from_application_page}    innerHTML
    ${ccms_case_id}=    addnewline    ${ccms_case_id}
    Log To Console    New CCMS Case Reference: ${ccms_case_id}
    Append to file    ${path}/ccms_case_reference.txt    ${ccms_case_id}    encoding='UTF-8'

Write Apply Caseid In File
    ${apply_case_id}=    Get Element Attribute    ${apply_case_reference_id_from_application_page}    innerHTML
    ${apply_case_id}=    addnewline    ${apply_case_id}
    Log To Console    New Apply Case Reference: ${apply_case_id}
    Append to file    ${path}/apply_laa_reference.txt    ${apply_case_id}    encoding='UTF-8'
