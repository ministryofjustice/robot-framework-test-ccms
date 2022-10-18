*** Settings ***
Library             Dialogs
Resource            ../Common.robot
Resource            ../settings.robot
Resource            ../PageObjects/service_request.robot
Resource            ../PageObjects/universal_search.robot
Resource            ../PageObjects/case_details.robot
Resource            ../PageObjects/merits_assessment.robot
Resource            ../PageObjects/means_assessment.robot

*** Variables ***
${means_proceeding_decision}     Grant
${means_proceeding_task_status}  Grant Decision
${merits_proceeding_decision}    Grant
${role_group}                    General Administration

*** Tasks ***
Propagate Means Case Status
    Focus EBS Forms
    And Ensure EBusiness Center
    And case_details.Submissions Status Check
    When means_assessment.Access Means
    AND means_assessment.Skip if Means Status Auto Granted   ${means_proceeding_task_status}
    Say If Human    We have accessed means
    Then means_assessment.Service request task
    Then means_assessment.Change Status Proceedings  ${means_proceeding_decision}
    Say If Human   changed proceeding status to ${means_proceeding_decision}
    And means_assessment.Change Status Costlimits  ${means_proceeding_decision}
    Say If Human   changed costlimits status to ${means_proceeding_decision}