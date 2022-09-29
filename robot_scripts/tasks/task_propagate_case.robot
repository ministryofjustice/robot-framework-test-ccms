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
${proceeding_decision}     Grant

*** Tasks ***
Propagate Case Status
    ${case_reference}=  Universal_Search.Get Case Reference

    Given Common.Ensure EBS Forms Screen  ${login_username}  ${login_password}
    Say If Human    Opened forms
    And Universal_Search.Back To Case Search
    Say If Human    Searching for case
    When Universal_Search.Search Case    ${case_reference}
    And Group_And_Role.Choose Group and Role If Presented   role_group=General Administration
    Say If Human    Showing case details now
    And case_Details.Refresh Case
    And case_details.Submissions Status Check
    When merits_assessment.Access Merits
    Then merits_assessment.Service Request Task
    Then merits_assessment.Change Status Proceedings  ${proceeding_decision}
    And merits_assessment.Change Status Costlimits  ${proceeding_decision}
    When means_assessment.Access Means    $proceeding_decision
    Then means_assessment.Service request task
    Then means_assessment.Change Status Proceedings  ${proceeding_decision}
    And means_assessment.Change Status Costlimits  ${proceeding_decision}