*** Settings ***
Resource   settings.robot

*** Keywords ***
Ensure EBS Web Screen
    ${exists}=  Win Exists   Internet Explorer
    IF  ${exists} == 0
        Close IE
        Login
    END

    Win Activate  Oracle
    Send  ^+r
    sleep  1s

Ensure EBS Case Search Screen
    ${exists}=  Win Exists  Oracle Applications - UAT
    IF  ${exists} == 0
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
    Send    C:/Program Files/Internet Explorer/iexplore.exe{ENTER}
    Wait For Active Window    Internet Explorer

    Wait Until Screen Contain    ${IMG_PATH}browser.png    10
    sleep   3s
    Send    ^l
    Sleep   1s
    Send    https://ccmsebs.uat.legalservices.gov.uk/OA_HTML/OA.jsp?OAFunc=OAHOMEPAGE{#}{ENTER}
    Wait Until Screen Contain    ${IMG_PATH}EBSLoginScreen.png    30
    Win Exists    Login
    
    Send    ${login_username}{TAB}${login_password}{ENTER}

    Win Exists  Oracle Applications Home Page
    Wait Until Screen Contain    ${IMG_PATH}EBSWebLoggedInScreen.png    30
    
Start EBS merits
    Auto It Set Option   WinTitleMatchMode   2
    Ensure EBS Web Screen

    Wait Until Screen Contain    ${IMG_PATH}MeritsCaseWorkerLink.PNG    10
    Click    ${IMG_PATH}MeritsCaseWorkerLink.PNG

    Wait Until Screen Contain    ${IMG_PATH}MeritsCasesAndClientsLink.PNG    10
    Click    ${IMG_PATH}MeritsCasesAndClientsLink.PNG

    Wait For Active Window    Oracle Applications - UAT

IfChooseRoleAndGroup
    ${exists}=  Exists    ${IMG_PATH}ChooseRoleUserDialogue.png

    IF  "${exists}" == "True"
        Click    ${IMG_PATH}RoleGroupInputBox.png
        Click    ${IMG_PATH}MoreMenuButton.png
        Click    ${IMG_PATH}SmallOkButton.png
        Click    ${IMG_PATH}SmallOkButton.png
    END

IfNotBackToSearchCaseForms
    ${exists}=  Exists    ${IMG_PATH}UniversalSearchDialogue.png

    IF  "${exists}" == "False"
        Send  {ALT}w2
        Click    ${IMG_PATH}ReturnToSearchButton.png
    END
