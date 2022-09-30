*** Settings ***
Resource   ../settings.robot
Resource   ../Common.robot
Resource   case_details.robot
Library    Dialogs


*** Variables ***
${subject_assess_means}                  ${IMG_PATH}/meansAssessment/meansCaseDetails.PNG
${toolbar_tools_button}                  ${IMG_PATH}/meritsAssessment/ToolbarToolsButton.PNG
${toolbar_tools_details_link}            ${IMG_PATH}/meritsAssessment/ToolbarToolsDetailsLink.PNG
${decision_field_custom_application}     ${IMG_PATH}/meritsAssessment/DecisionFieldCustomApplication.PNG
${decision_field_proceedings}            ${IMG_PATH}/meritsAssessment/DecisionFieldProceedings.PNG
${decision_field_costlimit_proceedings}  ${IMG_PATH}/meansAssessment/costLimitsMeansProceeding.PNG
${cost_limits_button}                    ${IMG_PATH}/meritsAssessment/CostLimitsButton.PNG
${close_form_button}                     ${IMG_PATH}/meritsAssessment/CloseFormButton.PNG

${means_proceeding_decision}     Grant


${ok_button_shortcut}   !k
${case_reference}
${save_button}   ^s
${ENTER}  {ENTER}
${backspace}  {BACKSPACE}


*** Keywords ***
Access Means
    [Arguments]  ${proceeding_decision}
    Common.Wait Until Screen Contains  ${service_request_screen}

Service Request Task
    Common.Click On    ${subject_assess_means}
    Common.Click On    ${toolbar_tools_button}
    Common.Click On    ${toolbar_tools_details_link}

Change Status Proceedings
    [Arguments]   ${proceeding_decision}
    Common.Input Text Until Appears    ${decision_field_custom_application}  ${proceeding_decision}
    Send Keys  ${save_button}
    Send Keys    ${ok_button_shortcut}
    Common.Input Text Until Appears    ${decision_field_proceedings}  ${proceeding_decision}
    Send Keys  ${save_button}

Change Status Costlimits
    [Arguments]   ${proceeding_decision}
    Send Keys  ${ok_button_shortcut}
    Common.Click On    ${cost_limits_button}
    Send Keys  ${backspace}
    Common.Input Text Until Appears    ${decision_field_costlimit_proceedings}  ${proceeding_decision}
    Send Keys  ${save_button}
    Common.Click On    ${close_form_button}