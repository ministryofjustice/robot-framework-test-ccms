*** Settings ***
Library   ../Support/string_utils.py
Library    OperatingSystem
Resource  ../PageObjects/apply_case_details.robot

*** Variables ***
${path}      build\\ApplyCaseDetails\\
${ccms_case_reference_id_from_application_page}   //*[@id="main-content"]/div[2]/div/div[1]/dl/dd[3]
${apply_case_reference_id_from_application_page}  //*[@id="main-content"]/div[2]/div/div[1]/dl/dd[2]

*** Keywords ***
Apply Submit Application
    [Documentation]  Uses: Selenium. Returns: None.
    ...  Performs the action of the final submission.
    #Getting the client name, LAA reference and CCMS reference
    ${caseid_present}=  Run keyword And Return Status  Element Text Should Not Be  ${ccms_case_reference_id_from_application_page}  ${EMPTY}
    WHILE    ${caseid_present}==False  limit=10
        Reload Page
        ${caseid_present}=  Run keyword And Return Status  Element Text Should Not Be  ${ccms_case_reference_id_from_application_page}  ${EMPTY}
    END

    Wait Until Element Is Visible    ${ccms_case_reference_id_from_application_page}

Write CCMS Caseid In File
    [Documentation]  Uses: Selenium. Returns: None.
    ...  Writes the ccms caseid to a designated file for further usage.
    [Arguments]  ${file}
    ${ccms_case_id}=   Get Element Attribute  ${ccms_case_reference_id_from_application_page}   innerHTML
    Log To Console   New Case Reference: ${ccms_case_id}${\n}
    Append to file  ${path}/${file}  ${ccms_case_id}  encoding='UTF-8'

Write Apply Caseid In File
    [Documentation]  Uses: Selenium. Returns: None.
    ...  Writes the apply caseid to a designated file for further usage.
    [Arguments]  ${file}
    ${apply_case_id}=  Get Element Attribute  ${apply_case_reference_id_from_application_page}  innerHTML
    Log To Console   New Case Reference:${apply_case_id}${\n}
    Append to file  ${path}/${file}  ${apply_case_id}  encoding='UTF-8'
