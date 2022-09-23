*** Settings ***
Resource   ../settings.robot
Resource   ../Common.robot
Resource    ../Support/Dialogue.robot

*** Variables ***
${choose_role_user_dialogue_title_bar}  ${IMG_PATH}ChooseRoleUserDialogue.png
${role_group_input_box}  ${IMG_PATH}RoleGroupInputBox.png
${more_menu_button}  ${IMG_PATH}MoreMenuButton.png
${ok_button_small}  ${IMG_PATH}OkButtonSmall.png
${ok_button_dialogue}  ${IMG_PATH}RoleAndGroupOkButton.png

*** Keywords ***
Dialogue Title
    RETURN   Choose Role and Group

Choose Group and Role If Presented
    [Arguments]  ${role_group}
    ${title}=  Dialogue Title
    ${exists}=  Image With Text Exists On Screen    ${choose_role_user_dialogue_title_bar}    ${title}
    Log    exists value is ${exists}

    IF  "${exists}" == "True"
        Fill And Submit    ${role_group}
    END

Fill And Submit
    [Arguments]  ${role_group}
    Log To Console    Role group exists, dealing with it.
    Click On    ${role_group_input_box}
    Send Keys     ${role_group}
    Press Dialogue OK
