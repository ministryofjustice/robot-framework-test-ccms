*** Settings ***
Resource   settings.robot

*** Keywords ***
Ensure EBS Web Screen
    ${exists}=  Win Exists   Internet Explorer
    Log To Console    InternetExplorer - Value of exists is: ${exists}
    IF  ${exists} == 0
        Close IE
        Login
    END

    Win Activate  Oracle
    Send  ^+r
    sleep  1s

Ensure EBS Forms Screen
    ${exists}=  Win Exists  Oracle Applications - UAT

    Log To Console    OracleApplicationsUAT - Value of exists is: ${exists}
    
    IF  ${exists} == 0
        Log To Console    "EBS forms not open, starting up from beginning."
        Close IE
        Login
        Start EBS merits
    END

    Win Activate  Oracle Applications - UAT
    sleep  1s

Close IE
    Close Application    Internet Explorer

Login
    IF  "${login_password}" == "" or "${login_username}" == ""
        Fail  The username and password must be set in the secrets file.
    END

    Auto It Set Option   WinTitleMatchMode   2
    Send    \#r
    Win Wait   Run
    Send    "C:/Program Files/Internet Explorer/iexplore.exe" "https://ccmsebs.uat.legalservices.gov.uk/OA_HTML/OA.jsp?OAFunc=OAHOMEPAGE{#}"{ENTER}
    Wait For Active Window    Internet Explorer

    Wait Until Screen Contain    ${IMG_PATH}browser.png    10
    sleep   2s
    Wait Until Screen Contain    ${IMG_PATH}EBSLoginScreen.png    30
    Win Exists    Login
    
    Send    ${login_username}{TAB}${login_password}{ENTER}

    Win Exists  Oracle Applications Home Page
    Wait Until Screen Contain    ${IMG_PATH}EBSWebLoggedInScreen.png    30
    
Start EBS merits
    Auto It Set Option   WinTitleMatchMode   2

    ${exists}=  If On EBS Forms

    Log To Console    EBS Forms - Value of exists is: ${exists}

    IF  ${exists} == 0
        Log To Console    "EBS forms are not open, opening now."
        Ensure EBS Web Screen

        Wait Until Screen Contain    ${IMG_PATH}MeritsCaseWorkerLink.PNG    10
        Click    ${IMG_PATH}MeritsCaseWorkerLink.PNG

        Wait Until Screen Contain    ${IMG_PATH}MeritsCasesAndClientsLink.PNG    10
        Click    ${IMG_PATH}MeritsCasesAndClientsLink.PNG
    END

    Wait For Active Window    Oracle Applications - UAT
    Back To Case Search

Choose Group and Role
    ${exists}=  Image With Text Exists On Screen    ${IMG_PATH}ChooseRoleUserDialogue.PNG    Choose Role and Group

    IF  "${exists}" == "True"
        Log To Console    Role group exists, dealing with it.
        Click    ${IMG_PATH}RoleGroupInputBox.png
        Click    ${IMG_PATH}MoreMenuButton.png
        Click    ${IMG_PATH}OkButtonSmall.png
        Click    ${IMG_PATH}RoleAndGroupOkButton.png
    END

Image With Text Exists On Screen
    [Arguments]  ${img}  ${text}
    ${foundText}=  Get Text From Image Matching    ${img}
    ${result}=  Set Variable  False

    Log To Console    Found text: ${foundText}

    IF  "${foundText}".find("${text}") != -1
        ${result}=  Set Variable  True
    END

    RETURN  ${result}

Get Text From Image Matching
    [Arguments]  ${img}
    ${exists}=  Exists    ${img}
    ${text}=   Set Variable  False
    
    IF  "${exists}" != "False"
        ${region}=  Get Extended Region From    ${img}    original    1
        ${text}=  Read Text From Region     ${region}
    END

    RETURN  ${text}

Back To Case Search
    ${exists}=  If On Universal Search

    Log To Console    UniversalSearch The value of exists is: ${exists}

    IF  "${exists}" == "False"
        Log To Console    "We are not on universal search dialogue, going to it now."
        Send  {ALT}w2
        Click    ${IMG_PATH}ReturnToSearchButton.png
        Click    ${IMG_PATH}ClearButton.png
    END

If On Universal Search
    [Documentation]  returns True or False
    
    ${exists}=  Image With Text Exists On Screen    ${IMG_PATH}UniversalSearchDialogue.png    Universal Search

    RETURN  ${exists}

If On EBS Forms
    [Documentation]  returns 0 or 1
    
    ${exists}=  Win Exists  Oracle Applications - UAT  

    RETURN  ${exists}
