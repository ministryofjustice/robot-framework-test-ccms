*** Settings ***
library  Selenium2Library
Library  SikuliLibrary
Resource    ../PageObjects/login.robot
*** Variables ***
${loginbox}  usernameField
${passwordbox}  passwordField
${login1}    NB_CASEWORKER
${password1}    Welcome123
${MeansButton}  50743:170:-1:0
*** Tasks ***
tmp
    Add Image Path    ${CURDIR}
    Open Browser  url=https://ccmsebs.uat.legalservices.gov.uk/OA_HTML/AppsLocalLogin.jsp  browser=ie
    Selenium2Library.Input Text    ${loginbox}    ${login1}
    Input Password    ${passwordbox}    ${password1}
    Click Button    SubmitButton
    Wait Until Element Is Visible    50743:170:-1:0
    Click Element    50743:170:-1:0
    Wait Until Element Is Visible  CCMS Complex Merits CaseworkerUniversal Work Queue  timeout=10
    Click Element  CCMS Complex Merits CaseworkerUniversal Work Queue
    # Sleep  20s
    # Highlight    EBSUniversalSearch.PNG
    # Sleep    10s
    # Clear Highlight    EBSUniversalSearch.PNG