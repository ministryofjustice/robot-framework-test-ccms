*** Settings ***
Library    SikuliLibrary
Resource    ../Common.robot
Resource    Navigator.robot

*** Variables ***
${service_request_screen}           ${IMG_PATH}/meritsAssessment/service_request_screen.PNG

*** Keywords ***
Check If On Service Request Screen
     Log To Console     Checking if on Service request screen
    ${exists}=  Win Exists  Service Request
    Common.Wait Until Screen Contains  ${service_request_screen}
         IF  ${exists} == 0
          Log To Console     "We are not on Service request Screen."
                              Refresh Service Request Window
         END