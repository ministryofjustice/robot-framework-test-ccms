*** Settings ***
Library             Dialogs
Resource            ../Common.robot
Resource            ../PageObjects/group_and_role.robot
Resource            ../PageObjects/universal_search.robot
Resource            ../PageObjects/case_details.robot

*** Tasks ***
Search For Case
    ${case_reference}=  Universal_Search.Get Case Reference

    Given Common.Ensure EBS Forms Screen  ${login_username}  ${login_password}
    Say If Human    Opened forms
    And Universal_Search.Back To Case Search
    Say If Human    Searching for case
    When Universal_Search.Search Case    ${case_reference}
    Say If Human    Showing case details now
    And Case_Details.Refresh Case
