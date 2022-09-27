*** Settings ***
Resource   ../Common.robot

*** Variables ***
${windows_pass}

*** Tasks ***
Unlock
    Send Keys   {ENTER}   
    Sleep  5s
    Send Keys   ${windows_pass}
    Send Keys   {ENTER}
