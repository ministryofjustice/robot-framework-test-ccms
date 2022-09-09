*** Settings ***
Library    SikuliLibrary    mode=NEW
Library    AutoItLibrary
Resource   secrets.robot

*** Variables ***
${APP_PATH}     C:\\Program Files\\Internet Explorer\\iexplore.exe
${IMG_PATH}     ${CURDIR}\\Images\\
${DIALOGUE_IMAGE}  ${IMG_PATH}ChooseRoleUserDialogue.png
${DEBUG}        FALSE
${input_box_image}  ${IMG_PATH}GenericInputBox.png
${GLOBAL_WAIT_TIMEOUT}  10
${GLOBAL_LONG_WAIT_TIMEOUT}  30
${GLOBAL_RETRY_TIME}  3
${GLOBAL_BEFORE_SEND_KEYS_WAIT}  1

*** Keywords ***
Image Paths
    Add Image Path    ${IMG_PATH}
