*** Settings ***
Resource    ../PageObjects/apply_case_details.robot


*** Variables ***
${proceeding_search_input}                          id:proceeding-search-input
${proceeding_search_input_text}                     Domestic Abuse
${non_molestation_order_radio_button}               css:label[for=id-da004-field]
${add_another_proceeding_no_option}                 id:legal-aid-application-has-other-proceeding-field
${applicant_claimant_petitioner_radio_button}       id:proceeding-client-involvement-type-ccms-code-a-field
${applicant_not_used_delegated_functions}
...                                                 id:legal-aid-applications-used-multiple-delegated-functions-form-none-selected-true-field
${used_delegated_functions_option_no}               id:proceeding-used-delegated-functions-field
${do_you_want_default_service_option_yes}           id:proceeding-accepted-substantive-defaults-true-field
${does_client_own_the_home_option_no}               id:legal-aid-application-own-home-no-field
${does_client_own_the_vehicle_option_no}            id:legal-aid-application-own-vehicle-field
${savings_account_check_box}                        id:savings-amount-check-box-offline-current-accounts-true-field
${savings_amount_text_field}                        id:savings-amount-offline-current-accounts-field
${savings_amount_input_text}                        100
${savings_and_investments_option_no}                id:savings-amount-none-selected-true-field
${client_other_assets_declaration_option_no}        id:other-assets-declaration-none-selected-true-field
${client_restrictions_on_selling_option_no}         id:legal-aid-application-has-restrictions-field
${charities_option_no}                              id:policy-disregards-none-selected-true-field


*** Keywords ***
Apply Income Payments Assets
    #What is legal aid for
    Input Text    ${proceeding_search_input}    ${proceeding_search_input_text}
    Wait Until Element Is Visible    ${non_molestation_order_radio_button}
    Click Element    ${non_molestation_order_radio_button}
    Click Element    ${continue_button}

    #Add Another Proceeding?
    Click Element    ${add_another_proceeding_no_option}
    Click Element    ${continue_button}

    # #What is your client’s role in this proceeding?
    #    Click Element    ${applicant_claimant_petitioner_radio_button}
    #    Click Element    ${continue_button}

    #Delegated Functions?
    Click Element    ${applicant_not_used_delegated_functions}
    #    Click Element    ${used_delegated_functions_option_no}
    Click Element    ${continue_button}

    #Do you want the default level of service?
    # Click Element    ${do_you_want_default_service_option_yes}
    # Click Element    ${continue_button}

    #What you're applying for
    Click Element    ${continue_button}

    #Check your answers
    Click Element    ${continue_button}

    #Passported Benefit
    Click Element    ${continue_button}

    #What you need to do
    Click Element    ${continue_button}

    #Does your client own the home they live in?
    Click Element    ${does_client_own_the_home_option_no}
    Click Element    ${continue_button}

    #Does your client own a vehicle?
    Click Element    ${does_client_own_the_vehicle_option_no}
    Click Element    ${continue_button}

    #Bank Account
    Click Element    ${savings_account_check_box}
    Input Text    ${savings_amount_text_field}    ${savings_amount_input_text}
    Click Element    ${continue_button}

    #Savings or Investments
    Click Element    ${savings_and_investments_option_no}
    Click Element    ${continue_button}

    #Client Assets
    Click Element    ${client_other_assets_declaration_option_no}
    Click Element    ${continue_button}

    #Client Prohibited from selling?
    Click Element    ${client_restrictions_on_selling_option_no}
    Click Element    ${continue_button}

    #Charity Payments
    Click Element    ${charities_option_no}
    Click Element    ${continue_button}
    #Check your answers
    Click Element    ${continue_button}

    #Client Eligibility
    Click Element    ${continue_button}
