*** Settings ***
Resource  Common.robot

*** Test Cases ***
Close
    Common.Focus EBS Forms
    Common.Close EBS Forms
    Common.Focus Browser
