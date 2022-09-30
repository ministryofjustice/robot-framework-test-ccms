*** Settings ***
Resource    ../Common.robot
Resource    session_expired_dialogue.robot
Resource    ../Support/Dialogue.robot

*** Variables ***
${merits_case_work_link_element}            ${IMG_PATH}MeritsCaseWorkerLink.PNG
${merits_case_and_clients_link_element}     ${IMG_PATH}MeritsCasesAndClientsLink.png
${menu_item_ccms_batch_user}                ${IMG_PATH}MenuItemCcmsBatchUser.png


*** Keywords ***
On Dashboard
    ${exists}=    Window With Title Exists    Oracle Applications Home Page

    RETURN    ${exists}

Start EBS merits
    Auto It Set Option    WinTitleMatchMode    2

    ${exists}=    If On EBS Forms

    Log To Console    EBS Forms - Value of exists is: ${exists}

    IF    ${exists} == 0
        Log To Console    "EBS forms are not open, opening now."
        Ensure EBS Web Screen    ${login_username}    ${login_password}

        Click Merits Link When Visible
        Click Merits Case Search Link When Visible
    END

    Wait For Active Window    Oracle Applications - UAT

Click Merits Link When Visible
    Wait Until Screen Contains    ${merits_case_work_link_element}    ${GLOBAL_WAIT_TIMEOUT}

    Click Link    CCMS Complex Merits Caseworker

Click Merits Case Search Link When Visible
    Wait Until Screen Contains    ${merits_case_and_clients_link_element}    ${GLOBAL_WAIT_TIMEOUT}

    Click Link    Cases and Clients

Logout
    Click Link    Logout

Open Batch Runner
    Wait Until Screen Contains    ${menu_item_ccms_batch_user}

    Click Link   CCMS Batch User

    Wait Until Element Is Visible    css:li.rootMenu li.submenu   ${GLOBAL_WAIT_TIMEOUT}   Expected to find Requests in the menu, but not found.
    Click Link   Requests

    Wait Until Element Is Visible    css:li.rootMenu li.submenu li.submenu  ${GLOBAL_WAIT_TIMEOUT}  Expected to find Requests within the requests menu, but not found.
    Click Element    css:li.rootMenu li.submenu li.submenu

    Wait Until Element Is Visible    css:li.rootMenu li.submenu li.submenu li#requests  ${GLOBAL_WAIT_TIMEOUT}  Expected to find Run in the requests menu, but not found.
    Click Link   Run

    Wait Until Window With Title Appears    Submit a New Request    tries=10