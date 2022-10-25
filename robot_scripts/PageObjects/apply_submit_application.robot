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
    WHILE    ${caseid_present}==False
        Reload Page
        ${caseid_present}=    Run keyword And Return Status
        ...    Element Text Should Not Be
        ...    ${ccms_case_reference_id_from_application_page}
        ...    ${EMPTY}
        CONTINUE
        IF    ${caseid_present}==True            BREAK
    END

    Wait Until Element Is Visible    ${ccms_case_reference_id_from_application_page}

Write CCMS Caseid In File
    ${ccms_caseId}=    Get Element Attribute    ${ccms_case_reference_id_from_application_page}    innerHTML
    ${ccmscaseid}=    addnewline    ${ccms_caseId}
    Log To Console    New CCMS Case Reference: ${ccmscaseid}
    Append to file    ${path}/ccms_case_reference .txt    ${ccmscaseid}    encoding='UTF-8'

Write Apply Caseid In File
    ${apply_caseId}=    Get Element Attribute    ${apply_case_reference_id_from_application_page}    innerHTML
    ${applycaseid}=    addnewline    ${apply_caseId}
    Log To Console    New Apply Case Reference: ${applycaseid}
    Append to file    ${path}/apply_laa_reference .txt    ${applycaseid}    encoding='UTF-8'
