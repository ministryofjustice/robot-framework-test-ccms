*** Settings ***
Resource  ../secrets.robot
Resource  ../Support/debug.robot
Resource  ../Support/browser_helper.robot
Resource  ../Support/ebs_helpers.robot

*** Tasks ***
Close EBS
    Focus EBS Forms
    Close EBS Forms
    Focus Browser
