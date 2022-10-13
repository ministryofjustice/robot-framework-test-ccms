*** Settings ***
Library             Dialogs
Resource            ../Common.robot
Resource            ../settings.robot
Resource            ../PageObjects/group_and_role.robot
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
Propagate Merits Case Status
    Focus EBS Forms
    And Group_And_Role.Choose Group and Role If Presented  ${role_group}
    And Ensure EBusiness Center
    And case_details.Submissions Status Check
    When merits_assessment.Access Merits
    Say If Human    We have accessed merits
    Then merits_assessment.Service Request Task
    Then merits_assessment.Change Status Proceedings  ${merits_proceeding_decision}
    Say If Human   changed proceeding status to ${merits_proceeding_decision}
    And merits_assessment.Change Status Costlimits  ${merits_proceeding_decision}
    Say If Human   changed costlimits status to ${merits_proceeding_decision}