*** Settings ***
Resource            ../settings.robot
Resource            ../Support/ebs_helper.robot
Resource            ../PageObjects/universal_search.robot
Resource            ../PageObjects/case_details.robot

*** Tasks ***
Search Case
    ${case_reference}=  Universal_Search.Get Case Reference

    Ensure EBS Forms Screen  ${login_username}  ${login_password}
    Universal_Search.Back To Case Search
    Universal_Search.Search Case    ${case_reference}
    case_Details.Refresh Case