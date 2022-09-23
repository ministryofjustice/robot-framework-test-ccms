*** Settings ***
Resource   ../settings.robot
Resource   ../Common.robot
Resource   case_details.robot
Library    Dialogs

*** Variables ***
${subject_assess_merits}                 ${IMG_PATH}/meritsAssessment/MeritCaseDetails.PNG
${toolbar_tools_button}                  ${IMG_PATH}/meritsAssessment/ToolbarToolsButton.PNG
${toolbar_tools_details_link}            ${IMG_PATH}/meritsAssessment/ToolbarToolsDetailsLink.PNG
${decision_field_custom_application}     ${IMG_PATH}/meritsAssessment/DecisionFieldCustomApplication.PNG
${decision_field_proceedings}            ${IMG_PATH}/meritsAssessment/DecisionFieldProceedings.PNG
${cost_limits_button}                    ${IMG_PATH}/meritsAssessment/CostLimitsButton.PNG
${close_form_button}                     ${IMG_PATH}/meritsAssessment/CloseFormButton.PNG

${ok_button_shortcut}   !k
${clear_button_shortcut}  !c
${search_button_shortcut}  !s
${open_search_shortcut}   {UP}{UP}{DOWN}{ENTER}
${back_to_search_shortcut}  !n
${universal_search_shortcut}  !w1
${case_reference}
${save_button}   ^s
${ENTER}  {ENTER}


*** Keywords ***
Access merits
    Common.Wait Until Screen Contains  ${service_request_screen}
    Common.Click On    ${subject_assess_merits}
    Common.Click On    ${toolbar_tools_button}
    Common.Click On    ${toolbar_tools_details_link}
    Common.Input Text Until Appears    ${decision_field_custom_application}  Grant
    Send Keys  ${save_button}
    Common.Input Text Until Appears    ${decision_field_proceedings}  Grant
    Send Keys  ${save_button}
    Send Keys  ${ENTER}
    Common.Click On    ${cost_limits_button}
    Common.Input Text Until Appears    ${decision_field_custom_application}  Grant
    Send Keys  ${save_button}
    Common.Click On    ${close_form_button}
