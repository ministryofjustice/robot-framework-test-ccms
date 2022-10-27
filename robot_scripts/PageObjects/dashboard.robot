*** Settings ***
Resource    session_expired_dialogue.robot
Resource    ../Support/Dialogue.robot
Resource    ../Support/screen_content_helper.robot
Resource    ../Support/ebs_helpers.robot


*** Variables ***
${merits_case_work_link_element}            MeritsCaseWorkerLink.PNG
${merits_case_and_clients_link_element}     MeritsCasesAndClientsLink.png
${menu_item_ccms_batch_user}                MenuItemCcmsBatchUser.png

${menu_items_locator}                       id:treemenu1
${requests_menu_item_locator}               css:li.rootMenu li.submenu
${inside_requests_menu_item_locator}        css:li.rootMenu li.submenu li.submenu
${run_menu_item_locator}                    css:li.rootMenu li.submenu li.submenu li#requests

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
    Wait Until Element Is Visible    css:#mainMenuRow .rootmenu

    Click Link    CCMS Complex Merits Caseworker

Click Merits Case Search Link When Visible
    Wait Until Element Is Visible    css:li[id='CCMS Complex Merits Caseworker']

    Click Link    Cases and Clients

Logout
    Click Link    Logout

Open Batch Runner
    Wait Until Element Is Visible    ${menu_items_locator}

    Click Link    CCMS Batch User

    Wait Until Element Is Visible
    ...    ${requests_menu_item_locator
    ...    ${GLOBAL_WAIT_TIMEOUT}
    ...    Expected to find Requests in the menu, but not found.
    Click Link    Requests

    Wait Until Element Is Visible
    ...    ${inside_requests_menu_item_locator}
    ...    ${GLOBAL_WAIT_TIMEOUT}
    ...    Expected to find Requests within the requests menu, but not found.
    Click Element    ${inside_requests_menu_item_locator}

    Wait Until Element Is Visible
    ...    ${run_menu_item_locator}
    ...    ${GLOBAL_WAIT_TIMEOUT}
    ...    Expected to find Run in the requests menu, but not found.
    Click Link    Run

    Wait Until Window With Title Appears    Submit a New Request    tries=10
