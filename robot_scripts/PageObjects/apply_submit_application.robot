*** Settings ***
Library    Selenium2Library
Library   ../Support/Speaker.py
Library  ../Support/StringUtils.py
Library    OperatingSystem
Library    String
Library    DateTime
Library    XML
Resource   ../secrets.robot
Resource   ../PageObjects/apply_case_details.robot

*** Variables ***
${Path}      robot_scripts\\tasks\\Casedetails\\
${ccms_case_reference_id_from_application_page}   //*[@id="main-content"]/div[2]/div/div[1]/dl/dd[3]
${apply_case_reference_id_from_application_page}  //*[@id="main-content"]/div[2]/div/div[1]/dl/dd[2]

*** Keywords ***
Apply Submit Application
      #Getting the client name, LAA reference and CCMS reference 
      Sleep    5
      Reload Page
      Wait Until Element Is Visible    ${ccms_case_reference_id_from_application_page}  
     
Write CCMS Caseid In File
   ${ccms-caseId}=   Get Element Attribute  ${ccms_case_reference_id_from_application_page}   innerHTML
   #CCMS case id
      ${ccmscaseid}=   cleanse   ${ccms-caseId}
      Log To Console   ${ccmscaseid}
  Append to file  ${Path}/ccms_case_reference .txt  ${ccmscaseid}  encoding='UTF-8'

Write Apply Caseid In File
   ${apply-caseId}=  Get Element Attribute  ${apply_case_reference_id_from_application_page}  innerHTML
    #Apply case id
      ${applycaseid}=   cleanse   ${apply-caseId}
      Log To Console   ${applycaseid}
  Append to file  ${Path}/apply_laa_reference .txt  ${applycaseid}  encoding='UTF-8'