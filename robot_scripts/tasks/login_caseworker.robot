*** Settings ***
Resource    ../PageObjects/login.robot

*** Tasks ***
Login Caseworker
    Login    ${login_username}    ${login_password}
