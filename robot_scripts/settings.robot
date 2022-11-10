*** Settings ***
Resource    secrets.robot
Resource    Support/hooks.robot

*** Variables ***
${BASE_URL}                         https://ccmsebs.uat.legalservices.gov.uk/OA_HTML/OA.jsp?OAFunc=OAHOMEPAGE#
${EBS_BROWSER}                      ie
${APPLY_URL}                        https://main-applyforlegalaid-uat.cloud-platform.service.justice.gov.uk/
${APPLY_BROWSER}                    chrome
${APP_PATH}                         C:\\Program Files\\Internet Explorer\\iexplore.exe
${IMG_PATH}                         ${CURDIR}\\Images\\
${DIALOGUE_TITLE_IMAGE}             TitleBarWindow.png
${NAVIGATOR_TITLE_IMAGE}            TitleBarWindow.png
${WINDOW_TITLE_IMAGE}               TitleBarWindow.png
${DECISION_TITLE_IMAGE}             TitleBarWindow.png
${DEBUG}                            False
${DEBUG_HIGHLIGHT_TIME}             1
${input_box_image}                  GenericInputBox.png
${GLOBAL_WAIT_TIMEOUT}              20
${IMAGE_WIDTH}                      5
${GLOBAL_LONG_WAIT_TIMEOUT}         30
${GLOBAL_RETRY_TIME}                5
${GLOBAL_RETRY_WAIT_INTERVAL}       2
${GLOBAL_BEFORE_SEND_KEYS_WAIT}     1
${EXECUTION_MODE}                   Machine    #Human/Machine
