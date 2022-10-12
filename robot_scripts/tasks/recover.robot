*** Settings ***
Library    Process
Resource   ../settings.robot
Resource    ../Support/Processing.robot

*** Tasks ***
Recover
    Task Kill  task=java.exe
    Task Kill  task=firefox.exe
    Task Kill  task=IEDriverServer.exe
