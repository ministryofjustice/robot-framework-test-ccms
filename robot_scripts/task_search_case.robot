*** Settings ***
Library             Dialogs
Resource            settings.robot
Resource            Common.robot
Resource            PageObjects/group_and_role.robot
Resource            PageObjects/universal_search.robot
Resource            PageObjects/case_details.robot

Suite Setup         Run Keywords  Start Sikuli Process  AND  Image Paths
Suite Teardown      Stop Remote Server


*** Test Cases ***
Search For Case
    Auto It Set Option    WinTitleMatchMode    2

    ${case_reference}=    Get Value From User    Case reference number

    Common.Ensure EBS Forms Screen    ${login_username}    ${login_password}
    Group_And_Role.Choose Group and Role If Presented
    Universal_Search.Back To Case Search

    Universal_Search.Search Case    ${case_reference}
    Group_And_Role.Choose Group and Role If Presented
    Case_Details.Refresh Case
