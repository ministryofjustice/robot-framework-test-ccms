*** Settings ***
Library     Selenium2Library

*** Variables ***
${application_completed_message}                            Application complete
${application_civil_legal_message}                          Application for civil legal

${continue_button}                                          id:continue
${start_button}                                             id:start
${confirm_office_page_h1}                                   tag:h1
${latest_incident_details_link}                             link:Latest incident details
${client_contact_about_incident_day}                        id:application_merits_task_incident_told_on_3i
${client_contact_about_incident_day_input_text}             1
${client_contact_about_incident_month}                      id:application_merits_task_incident_told_on_2i
${client_contact_about_incident_month_input_text}           01
${client_contact_about_incident_year}                       id:application_merits_task_incident_told_on_1i
${client_contact_about_incident_year_input_text}            2022
${when_did_incident_occur_day}                              id:application_merits_task_incident_occurred_on_3i
${when_did_incident_occur_day_input_text}                   1
${when_did_incident_occured_month}                          id:application_merits_task_incident_occurred_on_2i
${when_did_incident_occured_month_input_text}               12
${when_did_incident_occured_year}                           id:application_merits_task_incident_occurred_on_1i
${when_did_incident_occured_year_input_text}                2021
${opponent_fullname_field}                                  id:application-merits-task-opponent-full-name-field
${opponent_fullname_input_text}                             Test Opponent
${opponent_has_capcacity_to_understand_court_order_yes}     id:application-merits-task-opponent-understands-terms-of-court-order-true-field
${warning_letter_sent_to_opponent_option_yes}               id:application-merits-task-opponent-warning-letter-sent-true-field
${has_police_been_notified_option_yes}                      id:application-merits-task-opponent-police-notified-true-field
${police_notified_details_field}                            id:application-merits-task-opponent-police-notified-details-true-field
${police_notified_details_input_text}                       Test
${bail_conditions_met_option_no}                            id:application-merits-task-opponent-bail-conditions-set-field
${statement_from_the_case_field}                            id:application-merits-task-statement-of-case-statement-field
${statement_from_the_case_input_text}                       Statement Test
${chances_of_success_link}                                  link:Chances of success
${chance_of_successful_outcome_option_yes}                  id:proceeding-merits-task-chances-of-success-success-likely-true-field
${client_declaration_confirm_radio_button}                  id:legal-aid-application-client-declaration-confirmed-true-field


*** Keywords ***
Apply Case Details
    # Detail of case
    Click Link    ${latest_incident_details_link}
    Input Text    ${client_contact_about_incident_day}    ${client_contact_about_incident_day_input_text}
    Input Text    ${client_contact_about_incident_month}    ${client_contact_about_incident_month_input_text}
    Input Text    ${client_contact_about_incident_year}    ${client_contact_about_incident_year_input_text}
    Input Text    ${when_did_incident_occur_day}    ${when_did_incident_occur_day_input_text}
    Input Text    ${when_did_incident_occured_month}    ${when_did_incident_occured_month_input_text}
    Input Text    ${when_did_incident_occured_year}    ${when_did_incident_occured_year_input_text}
    Click Element    ${continue_button}

    # Opponent Details
    Input Text    ${opponent_fullname_field}    ${opponent_fullname_input_text}
    Click Element    ${opponent_has_capcacity_to_understand_court_order_yes}
    Click Element    ${warning_letter_sent_to_opponent_option_yes}
    Click Element    ${has_police_been_notified_option_yes}
    Input Text    ${police_notified_details_field}    ${police_notified_details_input_text}
    Click Element    ${bail_conditions_met_option_no}
    Click Element    ${continue_button}

    # Statement of Case
    Input Text    ${statement_from_the_case_field}    ${statement_from_the_case_input_text}
    Click Element    ${continue_button}

    # Chances of success
    Click Link    ${chances_of_success_link}

    # Outcomes 50% or better?
    Click Element    ${chance_of_successful_outcome_option_yes}
    Click Element    ${continue_button}
    Click Element    ${continue_button}

    # Check your answers
    Click Element    ${continue_button}

    # Confirm the following
    Click Element    ${client_declaration_confirm_radio_button}
    Click Element    ${continue_button}

    # Submit the application
    Click Element    ${continue_button}
    ${response1}=    Get Text    ${confirm_office_page_h1}
    Run Keyword And Return Status    Should Contain    ${response1}    ${application_completed_message}

    # Go on to "View completed application"
    Click Element    ${continue_button}
    ${response2}=    Get Text    ${confirm_office_page_h1}
    Run Keyword And Return Status    Should Contain    ${response2}    ${application_civil_legal_message}
