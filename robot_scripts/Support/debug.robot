*** Settings ***
Resource   ../settings.robot

*** Keywords ***
Fail With Voice And Help
    [Documentation]  Fail with both spoken and displayed error message.
    ...    Displayed message in two places: (i) direct to console, near screenshot info and extra text 
    ...                                     (ii) part of standard "FAIL" output
    ...    Optional extra info is displayed but not spoken. 
    ...    enforce_new_line flag used to start "direct to console" message on a new line which can be tidier
    [Arguments]    ${message}  ${extra_info}=""  ${enforce_new_line}=True

    Say If Human  ${message}

    IF  ${enforce_new_line}
        Log To Console  \ 
    END
    Log to Console  ${message}
    # Triple quotes to avoid "EOL while scanning string literal" errors from \n chars 
    IF  """${extra_info}""" != ""
        Log To Console  ${extra_info}
    END

    Fail  ${message}

LogV
    [Arguments]  ${text}  ${voiceMsg}=True

    Log  ${text}
    Log To Console  ${text}

    IF  "${voiceMsg}" != "False"
        IF  "${DEBUG}" == "True"
            Say  ${text}
        END
    END
