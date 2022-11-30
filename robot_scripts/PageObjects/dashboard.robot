*** Settings ***
Resource    session_expired_dialogue.robot
Resource    ../Support/ebs_helper.robot

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
    [Documentation]  Uses: AutoIt. Retruns: Boolean.
    ...   Checks if we're on the dashboard page.
    ${exists}=    Window With Title Exists    Oracle Applications Home Page

    RETURN    ${exists}

Start EBS merits
    [Documentation]  Uses: Selenium/AutoIt. Retruns: none.
    ...   Opens the case search for merits case worker. If the user is not logged in, will log in.
    Auto It Set Option    WinTitleMatchMode    2

    ${exists}=    If On EBS Forms

    Log To Console    EBS Forms - Value of exists is: ${exists}

    IF    ${exists} == 0
        Log To Console    "EBS forms are not open, opening now."
        Ensure EBS Web Screen    ${login_username}    ${login_password}
        Click Merits Link When Visible
        Click Merits Case Search Link When Visible
    END

    Wait For Active Window    Oracle Applications

Click Merits Link When Visible
    [Documentation]  Uses: Selenium. Retruns: none.
    ...   Click on the merits caseworker link.
    Wait Until Element Is Visible    css:#mainMenuRow .rootmenu

    Click Link    CCMS Complex Merits Caseworker

Click Merits Case Search Link When Visible
    [Documentation]  Uses: Selenium. Retruns: none.
    ...   Click on the cases and clients link.
    Wait Until Page Contains    Cases and Clients
    Click Link    Cases and Clients

Logout
    [Documentation]  Uses: Selenium. Retruns: none.
    ...   Clicks on the logout link on the dashboard.
    Click Link    Logout

Open Batch Runner
    [Documentation]  Uses: Selenium/Sikuli/AutoIt. Retruns: none.
    ...   Opens the batch runner when logged in as ccms batch user.
    ...   Will wait until the batch runner is opened.
    Wait Until Element Is Visible    ${menu_items_locator}

    Click Link    CCMS Batch User

    Wait Until Element Is Visible
    ...    ${requests_menu_item_locator}
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
    Wait Until Window With Title Appears  Submit a New Request  tries=10   img-width=2