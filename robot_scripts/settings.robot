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

*** Keywords ***
Image Paths
    Add Image Path    ${IMG_PATH}
