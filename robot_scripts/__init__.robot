*** Settings ***
Library    ./Support/Speaker.py
Suite Setup    Speaker.Say  Launching
Suite Teardown   Speaker.Say  Done
Test Teardown    Run Keyword If Test Failed  Speaker.Say  The task failed to execute