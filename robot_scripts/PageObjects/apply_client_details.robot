*** Settings ***
Library    Selenium2Library
Library   ../Support/Speaker.py
Library   ../Support/StringUtils.py
Library    OperatingSystem
Library    String
Library    DateTime
Library    XML
Resource   ../secrets.robot
Resource   ../PageObjects/apply_case_details.robot

*** Variables ***
${save_and_continue}  name:continue_button
${confirm_office_page_h1}  tag:h1
${option_yes_confirm_office}  id:binary-choice-form-confirm-office-true-field
${office_choice_radio_button}  css:.gov-ukradios > div:nth-child(1) > input
${pageTitle}   your office account number?
${applicant_first_name}  id:applicant-first-name-field
${applicant_last_name}  id:applicant-last-name-field
${applicant_first_name_input_text}  CCMSTest
${applicant_last_name_input_text}  Walker
${applicant_day_of_birth}  id:applicant_date_of_birth_3i
${applicant_month_of_birth}  id:applicant_date_of_birth_2i
${applicant_year_of_birth}  id:applicant_date_of_birth_1i
${applicant_day_birth_input_text}  10
${applicant_month_of_birth_input_text}  1
${applicant_year_of_birth_input_text}  1980
${applicant_ni_number}  id:applicant-national-insurance-number-field
${applicant_ni_number_input_text}  JA293483A

${enter_address_manually_link}  link:Enter address manually
${first_line_of_address}  id:address-address-line-one-field
${first_line_address_input_text}  123 Test Stree
${address_city}  id:address-city-field
${address_city_input_text}  Test City
${address_county}  id:address-county-field
${address_county_input_text}  Test
${address_postcode}  id:address-postcode-field
${address_postcode_input_text}  TE15 1NG

*** Keywords ***
Apply Client Details
    ${response}=    Get Text  ${confirm_office_page_h1}
    ${contains}=    Run Keyword And Return Status    Should Contain     ${response}   ${pageTitle}
    Log To Console    ${contains}

    Log To Console    ${response} 
    IF  "${response}" == "Applications"
        No Operation
    ELSE IF   "${contains}" == "True"
        Click Element   ${option_yes_confirm_office}
        Click Element   ${continue_button}
    ELSE
        Click Element   ${office_choice_radio_button}
        Click Element   ${continue_button}
    END

    Click Element  ${start_button}
    Click Element  ${continue_button}

    # Client Details
    Input Text     ${applicant_first_name}   ${applicant_first_name_input_text}
    Input Text     ${applicant_last_name}    ${applicant_last_name_input_text}
    Input Text     ${applicant_day_of_birth}   ${applicant_day_birth_input_text}
    Input Text     ${applicant_month_of_birth}   ${applicant_month_of_birth_input_text}
    Input Text     ${applicant_year_of_birth}   ${applicant_year_of_birth_input_text}
    Input Text     ${applicant_ni_number}    ${applicant_ni_number_input_text}
    Click Element  ${continue_button}

    #Correspondence Address
    Click Link     ${enter_address_manually_link} 
    Input Text     ${first_line_of_address}   ${first_line_address_input_text}
    Input Text     ${address_city}    ${address_city_input_text}
    Input Text     ${address_county}   ${address_county_input_text}
    Input Text     ${address_postcode}   ${address_postcode_input_text}
    Click Element  ${continue_button}