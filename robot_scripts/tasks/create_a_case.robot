*** Settings ***
Library    Selenium2Library
Library   ../Support/Speaker.py
Library  ../Support/StringUtils.py
Library    OperatingSystem
Library    String
Library    DateTime
Library    XML
Resource   ../secrets.robot

*** Variables ***
${apply_url}  https://main-applyforlegalaid-uat.cloud-platform.service.justice.gov.uk/
${browser}    chrome
${pageTitle}   your office account number?
${ApplicationCompetedMessage}     Application complete
${ApplicationCivilLegalMessage}   Application for civil legal
${Path}      ${CURDIR}\\Casedetails\\
${EXECUTION_MODE}  Human    #Human/Machine


*** Keywords ***
Test Startup Hook
        Say If Human    Starting task ${TEST NAME}
        Open Browser    ${apply_url}  ${browser}
        Click Element   id:start
        Input Text      id:email     ${apply_username}
        Input Text      id:password  ${apply_password}
        Click Button    css:input[type=submit]
Test Pass Hook
   Say If Human  Done with ${TEST NAME} task
   Close Browser

Test Failure Hook
   Say If Human  ${TEST NAME} task failed continue manually

write ccms caseid in file
  [Arguments]  ${ccmscaseid}
  Append to file  ${Path}/ccms_case_reference .txt  ${ccmscaseid}  encoding='UTF-8'
  # Append to file  ${Path}/apply_laa_reference .txt  ${result1}  encoding='UTF-8'

write apply caseid in file
  [Arguments]  ${applycaseid}
  Append to file  ${Path}/apply_laa_reference .txt  ${applycaseid}  encoding='UTF-8'


*** Tasks ***
Create a Case
    [Documentation]  Create Case in Apply
    ${response}=    Get Text  tag:h1
    ${contains}=    Run Keyword And Return Status    Should Contain     ${response}   ${pageTitle}
    Log To Console    ${contains}

    Log To Console    ${response} 
    IF  "${response}" == "Applications"
        No Operation
    ELSE IF   "${contains}" == "True"
        Click Element   id:binary-choice-form-confirm-office-true-field
        Click Element   id:continue
    ELSE
        Click Element   css:.gov-ukradios > div:nth-child(1) > input
        Click Element   id:continue
    END

    Click Element  id:start
    Click Element  id:continue

    # Client Details
    Input Text     id:applicant-first-name-field   CCMSTest
    Input Text     id:applicant-last-name-field    Walker
    Input Text     id:applicant_date_of_birth_3i   10
    Input Text     id:applicant_date_of_birth_2i   1
    Input Text     id:applicant_date_of_birth_1i   1980
    Input Text     id:applicant-national-insurance-number-field    JA293483A
    Click Element  id:continue

    #Correspondence Address
    Click Link     link:Enter address manually 
    Input Text     id:address-address-line-one-field   123 Test Street
    Input Text     id:address-city-field    Test City
    Input Text     id:address-county-field   Test
    Input Text     id:address-postcode-field   TE15 1NG
    Click Element  id:continue


    #What is legal aid for
    Input Text     id:proceeding-search-input   Domestic Abuse
    Wait Until Element Is Visible   css:label[for=id-da004-field]
    Click Element  css:label[for=id-da004-field]
    Click Element  id:continue
 
    #Add Another Proceeding?
    Click Element  id:legal-aid-application-has-other-proceeding-field
    Click Element  id:continue

    # #What is your client’s role in this proceeding?
     Click Element  id:proceeding-client-involvement-type-ccms-code-a-field
     Click Element  id:continue

    #Delegated Functions?
    #  Click Element   css:label[for=legal-aid-applications-used-multiple-delegated-functions-form-none-selected-true-field]
     Click Element   id:proceeding-used-delegated-functions-field
     Click Element   id:continue

    #Do you want the default level of service?
      Click Element  id:proceeding-accepted-substantive-defaults-true-field
      Click Element  id:continue

    #What you're applying for
     Click Element  id:continue

    #Check your answers
     Click Element  id:continue

    #Passported Benefit
     Click Element  id:continue

    #What you need to do
     Click Element  id:continue

    #Does your client own the home they live in?
    Click Element  id:legal-aid-application-own-home-no-field
    Click Element  id:continue

    #Does your client own a vehicle?
    Click Element  id:legal-aid-application-own-vehicle-field
    Click Element  id:continue

    #Bank Account
    Click Element  id:savings-amount-check-box-offline-current-accounts-true-field
    Input Text     id:savings-amount-offline-current-accounts-field   100
    Click Element  id:continue

    #Savings or Investments
    Click Element  id:savings-amount-none-selected-true-field
    Click Element  id:continue

    #Client Assets
    Click Element  id:other-assets-declaration-none-selected-true-field
    Click Element  id:continue

    #Client Prohibited from selling?
     Click Element  id:legal-aid-application-has-restrictions-field
     Click Element  id:continue

    #Charity Payments
      Click Element  id:policy-disregards-none-selected-true-field
      Click Element  id:continue

    #Check your answers
      Click Element  id:continue

    #Client Eligibility
      Click Element  id:continue

    #Detail of case
      Click Link     link:Latest incident details 
      Input Text     id:application_merits_task_incident_told_on_3i      1
      Input Text     id:application_merits_task_incident_told_on_2i      1
      Input Text     id:application_merits_task_incident_told_on_1i      2022
      Input Text     id:application_merits_task_incident_occurred_on_3i  1
      Input Text     id:application_merits_task_incident_occurred_on_2i  12
      Input Text     id:application_merits_task_incident_occurred_on_1i  2021
      Click Element  id:continue

     #Opponent Details
      Input Text     id:application-merits-task-opponent-full-name-field                                  Test Opponent
      Click Element  id:application-merits-task-opponent-understands-terms-of-court-order-true-field
      Click Element  id:application-merits-task-opponent-warning-letter-sent-true-field
      Click Element  id:application-merits-task-opponent-police-notified-true-field
      Input Text     id:application-merits-task-opponent-police-notified-details-true-field               Test
      Click Element  id:application-merits-task-opponent-bail-conditions-set-field
      Click Element  id:continue

      #Statement of Case
      Input Text     id:application-merits-task-statement-of-case-statement-field   Statement Test
      Click Element  id:continue

      #Chances of success
      Click Link   link:Chances of success

      #Outcomes 50% or better?
      Click Element  id:proceeding-merits-task-chances-of-success-success-likely-true-field
      Click Element  id:continue
      Click Element  id:continue

      #Check your answers
      Click Element  id:continue

      #Confirm the following
      Click Element  id:legal-aid-application-client-declaration-confirmed-true-field
      Click Element  id:continue

      #Submit the application
      Click Element  id:continue
      ${response1}=    Get Text  tag:h1
      Run Keyword And Return Status    Should Contain     ${response1}   ${ApplicationCompetedMessage}

      #Go on to "View completed application"
      Click Element  id:continue
      ${response2}=     Get Text  tag:h1
      Run Keyword And Return Status    Should Contain     ${response2}   ${ApplicationCivilLegalMessage}

      #Getting the client name, LAA reference and CCMS reference 
      Wait Until Element Is Visible    //*[@id="main-content"]/div[2]/div/div[1]/dl/dd[3]        timeout=10 
      Sleep    5
      Reload Page   
      ${ccms-caseId}=   Get Element Attribute  //*[@id="main-content"]/div[2]/div/div[1]/dl/dd[3]  innerHTML
      ${apply-caseId}=  Get Element Attribute  //*[@id="main-content"]/div[2]/div/div[1]/dl/dd[2]  innerHTML

      #CCMS case id
      ${ccmscaseid}=   cleanse   ${ccms-caseId}
      Log To Console   ${ccmscaseid}

      #Apply case id
      ${applycaseid}=   cleanse   ${apply-caseId}
      Log To Console   ${applycaseid}


      write ccms caseid in file   ${ccmscaseid}${\n}
      write apply caseid in file  ${applycaseid}${\n}
     





