*** Settings ***
Library    Process
Resource   ../settings.robot

*** Tasks ***
Recover
    Run Process   taskkill   /F /IM java.exe /T
    Run Process   taskkill   /F /IM firefox.exe /T
