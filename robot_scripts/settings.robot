*** Settings ***
Library     SikuliLibrary    mode=NEW
Library     AutoItLibrary
Resource    secrets.robot
Resource    ./Support/Hooks.robot


*** Variables ***
${base_url}                         https://ccmsebs.uat.legalservices.gov.uk/OA_HTML/OA.jsp?OAFunc=OAHOMEPAGE#
${APP_PATH}                         C:\\Program Files\\Internet Explorer\\iexplore.exe
${IMG_PATH}                         ${CURDIR}\\Images\\
${DIALOGUE_TITLE_IMAGE}             ${IMG_PATH}DialogueTitleBar.png
${NAVIGATOR_TITLE_IMAGE}            ${IMG_PATH}NavigatorTitle.png
${WINDOW_TITLE_IMAGE}               ${IMG_PATH}WindowTitleBar.png
${DECISION_TITLE_IMAGE}             ${IMG_PATH}DecisionTitleBar.png
${DEBUG}                            False
${DEBUG_HIGHLIGHT_TIME}             1
${input_box_image}                  ${IMG_PATH}GenericInputBox.png
${GLOBAL_WAIT_TIMEOUT}              10
${GLOBAL_LONG_WAIT_TIMEOUT}         30
${GLOBAL_RETRY_TIME}                3
${GLOBAL_RETRY_WAIT_INTERVAL}       2
${GLOBAL_BEFORE_SEND_KEYS_WAIT}     1
${EXECUTION_MODE}                   Human    #Human/Machine


*** Keywords ***
Image Paths
    Add Image Path    ${IMG_PATH}
