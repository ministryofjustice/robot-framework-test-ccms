*** Settings ***
Resource   ../settings.robot
Resource   ../Common.robot
Resource   case_details.robot
Library    Dialogs

*** Variables ***
${subject_assess_means}                  ${IMG_PATH}/meansAssessment/meansCaseDetails.PNG
${subject_assess_means_selected}         ${IMG_PATH}/meansAssessment/MeansCaseDetailsSelected.PNG
${toolbar_tools_button}                  ${IMG_PATH}/meritsAssessment/ToolbarToolsButton.PNG
${toolbar_tools_details_link}            ${IMG_PATH}/meritsAssessment/ToolbarToolsDetailsLink.PNG
${decision_field_custom_application}     ${IMG_PATH}/meritsAssessment/DecisionFieldCustomApplication.PNG
${decision_field_proceedings}            ${IMG_PATH}/meritsAssessment/DecisionFieldProceedings.PNG
${cost_limits_button}                    ${IMG_PATH}/meritsAssessment/CostLimitsButton.PNG
${close_form_button}                     ${IMG_PATH}/meritsAssessment/CloseFormButton.PNG
${means_task_status_field}               ${IMG_PATH}/meansAssessment/meansTaskStatusField.PNG
${decision_field_costlimit_proceedings}  ${IMG_PATH}/meansAssessment/costLimitsMeansProceeding.PNG

${ok_button_shortcut}   !k
${case_reference}
${save_button}   ^s
${ENTER}  {ENTER}
${backspace}  {BACKSPACE}

*** Keywords ***
Access Means
    Log To Console    Access Means
    Common.Wait Until Screen Contains  ${service_request_screen}

Skip if Means Status Auto Granted
    [Arguments]  ${proceeding_decision}
     Log To Console    Skip if Means Status Auto Granted
     Common.Wait Until Screen Contains  ${service_request_screen}
     Common.Click On    ${subject_assess_means}
     Common.Wait Until Screen Contains  ${subject_assess_means_selected}
     ${exists}=  Get Text From Image Matching  ${means_task_status_field}
     IF  ${exists} == "True"
          BuiltIn.Pass Execution If  "${exists}" == "True"  Ignoring means process as its in Grant Status
     END

Service Request Task
    Log To Console    Service Request Task

    Common.Click On    ${subject_assess_means}
    Common.Click On    ${toolbar_tools_button}
    Common.Click On    ${toolbar_tools_details_link}

Change Status Proceedings
    [Arguments]   ${proceeding_decision}

    Log To Console    Change Status Proceedings

    Common.Input Text Until Appears    ${decision_field_custom_application}  ${proceeding_decision}
    Send Keys  ${save_button}
    Send Keys    ${ok_button_shortcut}
    Common.Input Text Until Appears    ${decision_field_proceedings}  ${proceeding_decision}
    Send Keys  ${save_button}

Change Status Costlimits
    [Arguments]   ${proceeding_decision}

    Log To Console    Change Status Costlimits

    Send Keys  ${ok_button_shortcut}
    Common.Click On    ${cost_limits_button}
    Send Keys  ${backspace}
    Common.Input Text Until Appears    ${decision_field_costlimit_proceedings}  ${proceeding_decision}
    Send Keys  ${save_button}
    Common.Click On    ${close_form_button}