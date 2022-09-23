*** Settings ***
Library             Dialogs
Resource            ../Common.robot
Resource            ../settings.robot
Resource            ../PageObjects/group_and_role.robot
Resource            ../PageObjects/universal_search.robot
Resource            ../PageObjects/case_details.robot
Resource            ../PageObjects/merits_assessment.robot

*** Tasks ***
Search For Case
    ${case_reference}=  Universal_Search.Get Case Reference

    Given Common.Ensure EBS Forms Screen  ${login_username}  ${login_password}
    Say If Human    Opened forms
    Sleep    5
    When Universal_Search.Search Case    ${case_reference}
    And Group_And_Role.Choose Group and Role If Presented   role_group=General Administration
    Say If Human    Showing case details now
    And Case_Details.Refresh Case
    Then merits_assessment.Access merits