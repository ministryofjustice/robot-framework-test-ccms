*** Settings ***
Resource            settings.robot
Resource            Support/Hooks.robot

Suite Setup         Run Keyword   Suite Setup Hook

Test Setup          Run Keyword   Test Startup Hook

Suite Teardown      Run Keyword   Stop Remote Server

Test Teardown       Run Keyword   Test Teardown Hook
