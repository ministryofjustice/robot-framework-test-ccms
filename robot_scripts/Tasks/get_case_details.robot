*** Settings ***
Library    OperatingSystem
Resource   ../PageObjects/universal_search.robot

*** Tasks ***
Get Case Details
    ${case_reference}=   Get Case Reference

    ${output}=  OperatingSystem.Run   test-data find case limit\=1 case_reference\=${case_reference}
    Log To Console    ${output}
