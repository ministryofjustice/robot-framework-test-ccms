*** Settings ***
Resource  Common.robot

*** Tasks ***
Close Forms
    Common.Focus EBS Forms
    Common.Close EBS Forms
    Common.Focus Browser

Close IE
    Common.Focus Browser
    Dashboard.Logout
    Common.Close IE
