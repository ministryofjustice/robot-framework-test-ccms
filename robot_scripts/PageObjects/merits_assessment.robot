*** Settings ***
Resource   ../settings.robot
Resource   case_details.robot

*** Variables ***
${subject_assess_merits}                 meritsAssessment/MeritCaseDetails.PNG
${toolbar_tools_button}                  meritsAssessment/ToolbarToolsButton.PNG
${toolbar_tools_details_link}            meritsAssessment/ToolbarToolsDetailsLink.PNG
${decision_field_custom_application}     meritsAssessment/DecisionFieldCustomApplication.PNG
${decision_field_proceedings}            meritsAssessment/DecisionFieldProceedings.PNG
${decision_field_costlimit_proceedings}  meansAssessment/costLimitsMeansProceeding.PNG
${cost_limits_button}                    meritsAssessment/CostLimitsButton.PNG
${close_form_button}                     meritsAssessment/CloseFormButton.PNG

${ok_button_shortcut}   !k
${case_reference}
${save_button}   ^s
${ENTER}  {ENTER}
${backspace}  {BACKSPACE}

*** Keywords ***
Access Merits
    Log To Console    Access merits

    Wait Until Screen Contains  ${service_request_screen}

Service Request Task
    Log To Console    Service request task

    Click On    ${subject_assess_merits}
    Click On    ${toolbar_tools_button}
    Click On    ${toolbar_tools_details_link}

Change Status Proceedings
    [Arguments]   ${proceeding_decision}

    Log To Console    Change Status Proceedings

    Input Text Until Appears    ${decision_field_custom_application}  ${proceeding_decision}
    Send Keys  ${save_button}
    Input Text Until Appears    ${decision_field_proceedings}  ${proceeding_decision}
    Send Keys  ${save_button}
    Send Keys  ${ENTER}

Change Status Costlimits
    [Arguments]   ${proceeding_decision}

    Log To Console    Change Status Costlimits

    Click On    ${cost_limits_button}
    Send Keys  ${backspace}
    Input Text Until Appears    ${decision_field_custom_application}  ${proceeding_decision}
    Send Keys  ${save_button}
    Click On    ${close_form_button}