*** Settings ***
Resource    ../PageObjects/login.robot

*** Tasks ***
Login Business User
    Login    ${business_login_username}  ${business_login_password} 
