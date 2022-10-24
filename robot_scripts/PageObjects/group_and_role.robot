*** Settings ***
Resource    ../settings.robot
Resource    ../Support/Dialogue.robot

*** Variables ***
${choose_role_user_dialogue_title_bar}      ChooseRoleUserDialogue.png
${role_group_input_box}                     RoleGroupInputBox.png
${more_menu_button}                         MoreMenuButton.png
${ok_button_small}                          OkButtonSmall.png
${ok_button_dialogue}                       RoleAndGroupOkButton.png

*** Keywords ***
Dialogue Title
    RETURN    Choose Role and Group

Fill And Submit
    [Arguments]    ${role_group}
    Log To Console    Role group exists, dealing with it.
    Click On    ${role_group_input_box}
    Send Keys    ${role_group}
    Press Dialogue OK
