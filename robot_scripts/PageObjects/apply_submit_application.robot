*** Settings ***
Library   ../Support/StringUtils.py
Library    OperatingSystem
Resource  ../PageObjects/apply_case_details.robot

*** Variables ***
${path}      robot_scripts\\tasks\\Casedetails\\
${ccms_case_reference_id_from_application_page}   //*[@id="main-content"]/div[2]/div/div[1]/dl/dd[3]
${apply_case_reference_id_from_application_page}  //*[@id="main-content"]/div[2]/div/div[1]/dl/dd[2]

*** Keywords ***
Apply Submit Application
      #Getting the client name, LAA reference and CCMS reference 
      Sleep    5
      Reload Page
      Wait Until Element Is Visible    ${ccms_case_reference_id_from_application_page}  
     
Write CCMS Caseid In File
   ${ccms_caseId}=   Get Element Attribute  ${ccms_case_reference_id_from_application_page}   innerHTML
      ${ccmscaseid}=   addnewline   ${ccms_caseId}
      Log To Console   ${ccmscaseid}
  Append to file  ${path}/ccms_case_reference .txt  ${ccmscaseid}  encoding='UTF-8'

Write Apply Caseid In File
   ${apply_caseId}=  Get Element Attribute  ${apply_case_reference_id_from_application_page}  innerHTML
      ${applycaseid}=   addnewline   ${apply_caseId}
      Log To Console   ${applycaseid}
  Append to file  ${path}/apply_laa_reference .txt  ${applycaseid}  encoding='UTF-8'