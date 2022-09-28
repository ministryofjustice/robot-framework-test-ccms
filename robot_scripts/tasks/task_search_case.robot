*** Settings ***
Library             Dialogs
Resource            ../Common.robot
Resource            ../settings.robot
Resource            ../PageObjects/group_and_role.robot
Resource            ../PageObjects/universal_search.robot
Resource            ../PageObjects/case_details.robot
Resource            ../PageObjects/merits_assessment.robot
Resource            ../PageObjects/means_assessment.robot

*** Tasks ***
Search For Case
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
    When merits_assessment.Access merits
    Then merits_assessment.Service request task
    Then merits_assessment.Grant proceedings  proceeding_decision=Grant
    And merits_assessment.Grant costlimits    proceeding_decision=Grant
    Then means_assessment.Access means        proceeding_decision=Grant