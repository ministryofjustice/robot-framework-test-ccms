*** Settings ***
Library             Dialogs
Resource            settings.robot
Resource            Common.robot
Resource            PageObjects/group_and_role.robot
Resource            PageObjects/universal_search.robot
Resource            PageObjects/case_details.robot

Suite Setup         Run Keywords  Start Sikuli Process  AND  Image Paths  AND  Auto It Set Option    WinTitleMatchMode    2
Suite Teardown      Stop Remote Server

*** Variables ***
${case_reference}

*** Test Cases ***
Search For Case
    ${case_reference}=    Get Value From User    Case reference number
    Common.Ensure EBS Forms Screen    ${login_username}    ${login_password}
    Group_And_Role.Choose Group and Role If Presented   role_group=General Administration
    Universal_Search.Back To Case Search
    Universal_Search.Search Case    ${case_reference}
    Group_And_Role.Choose Group and Role If Presented   role_group=General Administration
    Case_Details.Refresh Case
