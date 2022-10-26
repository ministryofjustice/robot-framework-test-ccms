*** Settings ***
Library    String
Library    SikuliLibrary
Library    string_utils.py
Library    AutoItLibrary
Resource   ../settings.robot
Resource   debug.robot

*** Keywords ***
Get EBS Window Dialogue Title Text
    [Documentation]  Get the value of any EBS window title bar. This title bar must have
    ...              the minimise, maximise and close buttons on the right.
    ${region}=  Get Extended Region From Image     ${WINDOW_TITLE_IMAGE}    left    10
    ${score}=  Get Match Score    ${WINDOW_TITLE_IMAGE}

    IF  "${DEBUG}" == "True"
        Highlight Region    ${region}   ${DEBUG_HIGHLIGHT_TIME}
    END
    ${text}=  Read Text From Region     ${region}

    RETURN    ${text}

Image With Text Exists On Screen
    [Arguments]  ${img}  ${text}  ${expect_unique}=False  ${strict}=False

    ${foundText}=  Get Text From Image Matching    ${img}
    ${foundText}=  Encode String To Bytes    ${foundText}    ASCII  errors=replace

    IF  "${DEBUG}" == "True"
        Highlight    ${img}  ${DEBUG_HIGHLIGHT_TIME}
        ${matches}=  Get Match Score    ${img}

        LogV  Found text: ${foundText} in image ${img}, Match score ${matches}  False
    END

    IF  """${foundText}""" == "False" or """${foundText}""" == ""
        LogV   No text found inside image ${img}
    END
    ${result}=  Set Variable  False

    IF  "${expect_unique}" == "True"
        ${count}=  Image Count    ${img}

        LogV    Number of times image found on screen ${count}
        IF  "${count}" != "1"
            Fail   Expected the image to appear once on the screen, got ${count} times.
        END
    END

    ${contains}=  String Contains  ${foundText}  ${text}

    Log To Console    CONTAINS RESULT: ${contains}

    IF  ${contains}
        LogV               Yes we have found the text in the image ${text}
        ${result}=  Set Variable  True
    ELSE IF  "${strict}" == "True"
        LogV   Expected image was found, but text did not match. Expected '${text}', Found '${foundText}'.
        Fail   Expected image was found, but text did not match. Expected '${text}', Found '${foundText}'.
    END

    RETURN  ${result}

Get Text From Image Matching
    [Arguments]  ${img}
    ${exists}=  Exists    ${img}
    ${text}=   Set Variable  False

    IF  "${exists}" != "False"
        ${region}=  Get Extended Region From    ${img}    original    1
        LogV  Region to get text from: ${region}   False

        IF  "${DEBUG}" == "True"
            Highlight Region    ${region}   ${DEBUG_HIGHLIGHT_TIME}
        END
        ${text}=  Read Text From Region     ${region}
    END

    RETURN  ${text}

Wait Until Screen Contains
    [Documentation]  Use in favour of Wait Until Screen Contain so Debug can be used.
    [Arguments]  ${img}  ${timeout}=${GLOBAL_WAIT_TIMEOUT}
    Wait Until Screen Contain    ${img}    ${timeout}

    IF  "${DEBUG}" == "True"
        Highlight    ${img}  ${DEBUG_HIGHLIGHT_TIME}
        ${count}=  Image Count    ${img}
        LogV   Count of Image: ${count}
    END

Wait Until Screen Contains With Text
    [Documentation]  Not being used.
    [Arguments]  ${img}  ${text}  ${tries}=${GLOBAL_RETRY_TIME}  ${strict}=True

    ${result}=  Set Variable  False
    FOR    ${i}    IN RANGE    ${tries}
        LogV   Try ${i}
        TRY
            Image With Text Exists On Screen    ${img}    ${text}  strict=True
            ${result}=  Set Variable  True
            Exit For Loop
        EXCEPT  AS    ${error_message}
            LogV  ${error_message}  False
        END

        Sleep  ${GLOBAL_RETRY_WAIT_INTERVAL}
    END

    IF  "${strict}" == "True" and "${result}" != "True"
        Fail   Waited for '${tries}' tries, but could not find '${img}' with text '${text}'
    END

    RETURN  ${result}

Window With Title Exists
    [Documentation]  Returns True or False.
    [Arguments]  ${title}
    ${exists}=  Win Exists  ${title}

    IF  "${exists}" == "0"
        RETURN  False
    END

    RETURN  True