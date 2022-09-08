*** Settings ***
Resource   ../settings.robot
Resource   ../Common.robot

*** Variables ***
${choose_role_user_dialogue_title_bar}  ${IMG_PATH}ChooseRoleUserDialogue.png
${role_group_input_box}  ${IMG_PATH}RoleGroupInputBox.png
${more_menu_button}  ${IMG_PATH}MoreMenuButton.png
${ok_button_small}  ${IMG_PATH}OkButtonSmall.png
${ok_button_dialogue}  ${IMG_PATH}RoleAndGroupOkButton.png
${role}  General Administration
${ok_button_shortcut}  !o

*** Keywords ***
Choose Group and Role If Presented
    ${exists}=  Image With Text Exists On Screen    ${choose_role_user_dialogue_title_bar}    Choose Role and Group

    IF  "${exists}" == "True"
        Log To Console    Role group exists, dealing with it.
        Click    ${role_group_input_box}
        Send     ${role}${ok_button_shortcut}
    END
