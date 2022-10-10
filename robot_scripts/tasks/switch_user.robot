*** Settings ***
Resource    ../PageObjects/dashboard.robot

*** Variables ***
${switch_username}
${switch_password}

*** Tasks ***
Switch User
    Say If Human    Warning: This task will close the existing forms.
    ${login_username}=   Get User Input If Not Exists    ${switch_username}    username
    ${login_password}=   Get User Input If Not Exists    ${switch_password}    password

    Close IE
    Sleep    3s
    Login    ${login_username}    ${login_password}
