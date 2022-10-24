*** Settings ***
Resource            ../settings.robot
Resource            ../Support/ebs_helpers.robot
Resource            ../PageObjects/case_details.robot
Resource            ../PageObjects/merits_assessment.robot

*** Variables ***
${means_proceeding_decision}     Grant
${means_proceeding_task_status}  Grant Decision
${merits_proceeding_decision}    Grant
${role_group}                    General Administration

*** Tasks ***
Propagate Merits Case Status
    Focus EBS Forms
    Ensure EBusiness Center
    case_details.Submissions Status Check
    merits_assessment.Access Merits
    Say If Human    We have accessed merits
    merits_assessment.Service Request Task
    merits_assessment.Change Status Proceedings  ${merits_proceeding_decision}
    Say If Human   changed proceeding status to ${merits_proceeding_decision}
    merits_assessment.Change Status Costlimits  ${merits_proceeding_decision}
    Say If Human   changed costlimits status to ${merits_proceeding_decision}