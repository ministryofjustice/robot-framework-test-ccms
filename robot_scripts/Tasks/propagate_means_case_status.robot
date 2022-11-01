*** Settings ***
Resource            ../settings.robot
Resource            ../Support/ebs_helper.robot
Resource            ../PageObjects/case_details.robot
Resource            ../PageObjects/means_assessment.robot

*** Variables ***
${means_proceeding_decision}     Grant
${means_proceeding_task_status}  Grant Decision
${merits_proceeding_decision}    Grant
${role_group}                    General Administration

*** Tasks ***
Propagate Means Case Status
    Focus EBS Forms
    Ensure EBusiness Center
    case_details.Submissions Status Check
    means_assessment.Access Means
    means_assessment.Skip if Means Status Auto Granted   ${means_proceeding_task_status}
    Say If Human    We have accessed means
    means_assessment.Service request task
    means_assessment.Change Status Proceedings  ${means_proceeding_decision}
    Say If Human   changed proceeding status to ${means_proceeding_decision}
    means_assessment.Change Status Costlimits  ${means_proceeding_decision}
    Say If Human   changed costlimits status to ${means_proceeding_decision}
