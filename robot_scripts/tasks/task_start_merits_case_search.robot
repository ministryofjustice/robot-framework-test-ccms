*** Settings ***
Resource    ../Common.robot
Resource    ../PageObjects/universal_search.robot
Suite Setup       Start Sikuli Process
Suite Teardown     Stop Remote Server

*** Tasks ***
Start Merits EBS Case Search
    Dashboard.Start EBS merits
    Universal_Search.Back To Case Search
