*** Settings ***
Resource   ../settings.robot
Resource   case_details.robot

*** Variables ***
${subject_assess_means}                  meansAssessment/meansCaseDetails.PNG
${subject_assess_means_selected}         meansAssessment/MeansCaseDetailsSelected.PNG
${toolbar_tools_button}                  meritsAssessment/ToolbarToolsButton.PNG
${toolbar_tools_details_link}            meritsAssessment/ToolbarToolsDetailsLink.PNG
${decision_field_custom_application}     meritsAssessment/DecisionFieldCustomApplication.PNG
${decision_field_proceedings}            meritsAssessment/DecisionFieldProceedings.PNG
${cost_limits_button}                    meritsAssessment/CostLimitsButton.PNG
${close_form_button}                     meritsAssessment/CloseFormButton.PNG
${means_task_status_field}               meansAssessment/meansTaskStatusField.PNG
${decision_field_costlimit_proceedings}  meansAssessment/costLimitsMeansProceeding.PNG

${ok_button_shortcut}   !k
${case_reference}
${save_button}   ^s
${ENTER}  {ENTER}
${backspace}  {BACKSPACE}

*** Keywords ***
Access Means
    Log To Console    Access Means
    Wait Until Screen Contains  ${service_request_screen}

Skip if Means Status Auto Granted
    [Arguments]  ${proceeding_decision}
     Log To Console    Skip if Means Status Auto Granted
     Wait Until Screen Contains  ${service_request_screen}
     Click On    ${subject_assess_means}
     Wait Until Screen Contains  ${subject_assess_means_selected}
     ${exists}=  Image With Text Exists On Screen  ${means_task_status_field}  ${proceeding_decision}
     IF   "${exists}" == "True"
         Say If Human    Ignoring means process as its in Grant Status
         BuiltIn.Pass Execution If  "${exists}" == "True"   Ignoring means process as its in Grant Status
     END

Service Request Task
    Log To Console    Service Request Task

    Click On    ${subject_assess_means}
    Click On    ${toolbar_tools_button}
    Click On    ${toolbar_tools_details_link}

Change Status Proceedings
    [Arguments]   ${proceeding_decision}

    Log To Console    Change Status Proceedings

    Input Text Until Appears    ${decision_field_custom_application}  ${proceeding_decision}
    Send Keys  ${save_button}
    Send Keys    ${ok_button_shortcut}
    Input Text Until Appears    ${decision_field_proceedings}  ${proceeding_decision}
    Send Keys  ${save_button}

Change Status Costlimits
    [Arguments]   ${proceeding_decision}

    Log To Console    Change Status Costlimits

    Send Keys  ${ok_button_shortcut}
    Click On    ${cost_limits_button}
    Send Keys  ${backspace}
    Input Text Until Appears    ${decision_field_costlimit_proceedings}  ${proceeding_decision}
    Send Keys  ${save_button}
    Click On    ${close_form_button}