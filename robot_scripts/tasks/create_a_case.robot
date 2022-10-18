*** Settings ***
Library  Selenium2Library
Resource  ../settings.robot

*** Variables ***
${pageTitle}   your office account number?
${ApplicationCompetedMessage}   Application complete
${ApplicationCivilLegalMessage}   Application for civil legal

*** Tasks ***
Create a Case
    [Documentation]  case search test

    Open Browser  https://main-applyforlegalaid-uat.cloud-platform.service.justice.gov.uk/  chrome
    Selenium2Library.Click Element   id:start
    Selenium2Library.Input Text      id:email       ${apply_username}
    Selenium2Library.Input Text      id:password    ${apply_password}
    Selenium2Library.Click Element   css:input[type=submit]


    ${response}=    Selenium2Library.Get Text  tag:h1
    ${contains}=    Run Keyword And Return Status    Should Contain     ${response}   ${pageTitle}
     Log To Console    ${contains} 

    Log To Console    ${response} 
    IF    "${response}" == "Applications"
    No Operation
    ELSE IF   "${contains}" == "True"
       
    Selenium2Library.Click Element   id:binary-choice-form-confirm-office-true-field
    Selenium2Library.Click Element   id:continue
    ELSE
    Selenium2Library.Click Element   css:.gov-ukradios > div:nth-child(1) > input
    Selenium2Library.Click Element   id:continue
    END

    Selenium2Library.Click Element  id:start
    Selenium2Library.Click Element  id:continue

    # Client Details
    Selenium2Library.Input Text     id:applicant-first-name-field   CCMSTest
    Selenium2Library.Input Text     id:applicant-last-name-field    Walker
    Selenium2Library.Input Text     id:applicant_date_of_birth_3i   10
    Selenium2Library.Input Text     id:applicant_date_of_birth_2i   1
    Selenium2Library.Input Text     id:applicant_date_of_birth_1i   1980
    Selenium2Library.Input Text     id:applicant-national-insurance-number-field    JA293483A
    Selenium2Library.Click Element  id:continue

    #Correspondence Address
    Selenium2Library.Click Link     link:Enter address manually 
    Selenium2Library.Input Text     id:address-address-line-one-field   123 Test Street
    Selenium2Library.Input Text     id:address-city-field    Test City
    Selenium2Library.Input Text     id:address-county-field   Test
    Selenium2Library.Input Text     id:address-postcode-field   TE15 1NG
    Selenium2Library.Click Element  id:continue


    #What is legal aid for
    Selenium2Library.Input Text     id:proceeding-search-input   Domestic Abuse
    Wait Until Element Is Visible   css:label[for=id-da004-field]
    Selenium2Library.Click Element  css:label[for=id-da004-field]
    Selenium2Library.Click Element  id:continue
 
    #Add Another Proceeding?
    Selenium2Library.Click Element  id:legal-aid-application-has-other-proceeding-field
    Selenium2Library.Click Element  id:continue


    # #What is your client’s role in this proceeding?
    # Selenium2Library.Click Element  id:proceeding-client-involvement-type-ccms-code-a-field
    # Selenium2Library.Click Element  id:continue

    #Delegated Functions?
     Selenium2Library.Click Element   css:label[for=legal-aid-applications-used-multiple-delegated-functions-form-none-selected-true-field]
     #Selenium2Library.Click Element  id:proceeding-used-delegated-functions-field
     Selenium2Library.Click Element   id:continue

    #Do you want the default level of service?
    #  Selenium2Library.Click Element  id:proceeding-accepted-substantive-defaults-true-field
    #  Selenium2Library.Click Element  id:continue

    #What you're applying for
     Selenium2Library.Click Element  id:continue

    #Check your answers
     Selenium2Library.Click Element  id:continue

    #Passported Benefit
     Selenium2Library.Click Element  id:continue

    #What you need to do
     Selenium2Library.Click Element  id:continue

    #Does your client own the home they live in?
    Selenium2Library.Click Element  id:legal-aid-application-own-home-no-field
    Selenium2Library.Click Element  id:continue

    #Does your client own a vehicle?
    Selenium2Library.Click Element  id:legal-aid-application-own-vehicle-field
    Selenium2Library.Click Element  id:continue

    #Bank Account
    Selenium2Library.Click Element  id:savings-amount-check-box-offline-current-accounts-true-field
    Selenium2Library.Input Text     id:savings-amount-offline-current-accounts-field   100
    Selenium2Library.Click Element  id:continue

    #Savings or Investments
    Selenium2Library.Click Element  id:savings-amount-none-selected-true-field
    Selenium2Library.Click Element  id:continue

    #Client Assets
    Selenium2Library.Click Element  id:other-assets-declaration-none-selected-true-field
    Selenium2Library.Click Element  id:continue

    #Client Prohibited from selling?
     Selenium2Library.Click Element  id:legal-aid-application-has-restrictions-field
     Selenium2Library.Click Element  id:continue

    #Charity Payments
      Selenium2Library.Click Element  id:policy-disregards-none-selected-true-field
      Selenium2Library.Click Element  id:continue

    #Check your answers
      Selenium2Library.Click Element  id:continue

    #Client Eligibility
      Selenium2Library.Click Element  id:continue

    #Detail of case
      Selenium2Library.Click Link     link:Latest incident details 
      Selenium2Library.Input Text     id:application_merits_task_incident_told_on_3i      1
      Selenium2Library.Input Text     id:application_merits_task_incident_told_on_2i      1
      Selenium2Library.Input Text     id:application_merits_task_incident_told_on_1i      2022
      Selenium2Library.Input Text     id:application_merits_task_incident_occurred_on_3i  1
      Selenium2Library.Input Text     id:application_merits_task_incident_occurred_on_2i  12
      Selenium2Library.Input Text     id:application_merits_task_incident_occurred_on_1i  2021
      Selenium2Library.Click Element  id:continue

     #Opponent Details
      Selenium2Library.Input Text     id:application-merits-task-opponent-full-name-field                                  Test Opponent
      Selenium2Library.Click Element  id:application-merits-task-opponent-understands-terms-of-court-order-true-field
      Selenium2Library.Click Element  id:application-merits-task-opponent-warning-letter-sent-true-field
      Selenium2Library.Click Element  id:application-merits-task-opponent-police-notified-true-field
      Selenium2Library.Input Text     id:application-merits-task-opponent-police-notified-details-true-field               Test
      Selenium2Library.Click Element  id:application-merits-task-opponent-bail-conditions-set-field
      Selenium2Library.Click Element  id:continue

      #Statement of Case
      Selenium2Library.Input Text     id:application-merits-task-statement-of-case-statement-field   Statement Test
      Selenium2Library.Click Element  id:continue

      #Chances of success
            Selenium2Library.Click Link   link:Chances of success 

      #Outcomes 50% or better?
      Selenium2Library.Click Element  id:proceeding-merits-task-chances-of-success-success-likely-true-field
      Selenium2Library.Click Element  id:continue
      Selenium2Library.Click Element  id:continue

      #Check your answers
      Selenium2Library.Click Element  id:continue

      #Confirm the following
      Selenium2Library.Click Element  id:legal-aid-application-client-declaration-confirmed-true-field
      Selenium2Library.Click Element  id:continue

      #Submit the application
      Selenium2Library.Click Element  id:continue
      ${response1}=    Selenium2Library.Get Text  tag:h1
      Run Keyword And Return Status    Should Contain     ${response1}   ${ApplicationCompetedMessage}

      #Go on to "View completed application"
      Selenium2Library.Click Element  id:continue
      ${response2}=     Selenium2Library.Get Text  tag:h1
      Run Keyword And Return Status    Should Contain     ${response2}   ${ApplicationCivilLegalMessage}

      #Getting the client name, LAA reference and CCMS reference 
      Wait Until Element Is Visible   xpath://*[@id="main-content"]/div[2]/div/div[1]/dl
      ${result}=    Selenium2Library.Get Text  xpath://*[@id="main-content"]/div[2]/div/div[1]/dl
      Split String    string, separator=None, max_split=-1
      ${finalResult}    Split String    ${result}       ,${SPACE}
      Log To Console   ${finalResult}
 
    Close Browser
