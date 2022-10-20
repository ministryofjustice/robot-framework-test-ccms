*** Settings ***
Resource   ../settings.robot
Resource   debug.robot
Resource   browser_helper.robot
Resource   interaction_helper.robot
Resource   ../PageObjects/navigator.robot
Resource   ../PageObjects/login.robot
Resource   ../PageObjects/dashboard.robot

*** Variables ***
${file_menu_shortcut}   !f
${exit_option_shortcut}   x
${ok_button_shortcut}   !o
${close_button_shortcut}  {TAB}{ENTER}	

*** Keywords ***
Ensure EBS Web Screen
    [Arguments]  ${login_username}  ${login_password}

    ${exists}=  Win Exists   Internet Explorer
    LogV  InternetExplorer - Value of exists is: ${exists}
    IF  ${exists} == 0
        Close IE
        Login.Login    ${login_username}    ${login_password}
    END

    Focus Browser

    ${exists}=  Dashboard.On Dashboard

    # We may be logged out now...
    IF  "${exists}" == "False" 
        Fail  "Expected to be on dashboard, but not."
    END

    sleep  1s

Ensure EBS Forms Screen
    [Arguments]  ${login_username}  ${login_password}
    
    ${exists}=  Win Exists  Oracle Applications - UAT

    LogV    OracleApplicationsUAT - Value of exists is: ${exists}
    
    IF  ${exists} == 0
        LogV    "EBS forms not open, starting up from beginning."
        Ensure EBS Web Screen    ${login_username}    ${login_password}
        Dashboard.Start EBS merits
    END

    Focus EBS Forms
    sleep  1s

Ensure EBusiness Center
        ${exists}=  Win Exists  eBusiness Center

        LogV    eBusinessCenterWindow - Value of exists is: ${exists}

        IF  ${exists} == 0
                   Log To Console    "We are not on eBusiness Center window, going to it now."
                   Back To Choose Window
                   Send Keys    ${close_button_shortcut}
        END
        
        Focus EBS Forms
        sleep  1s

Focus EBS Forms
    Win Activate  Oracle Applications - UAT

If On EBS Forms
    [Documentation]  returns 0 or 1
    
    ${exists}=  Win Exists  Oracle Applications - UAT  

    RETURN  ${exists}

Close EBS Forms
    Send Keys  ${file_menu_shortcut}${exit_option_shortcut}${ok_button_shortcut}