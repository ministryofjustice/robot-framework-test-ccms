*** Settings ***
Resource   ../Support/processing.robot
Resource   ../settings.robot
Resource   ../Support/hooks.robot

*** Tasks ***
Recover
    Task Kill  task=java.exe
    Task Kill  task=firefox.exe
    Task Kill  task=IEDriverServer.exe
