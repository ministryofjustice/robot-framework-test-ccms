*** Settings ***
Resource    ../PageObjects/dashboard.robot
Resource    ../PageObjects/universal_search.robot

*** Tasks ***
Start Merits Case Search
    Dashboard.Start EBS merits
    Universal_Search.Back To Case Search
