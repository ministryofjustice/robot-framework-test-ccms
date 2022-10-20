*** Settings ***
Resource    ../common.robot
Resource    ../settings.robot
Resource    ../Support/Cypress.robot
Library    ../Support/case_reference_locator.py
Library    OperatingSystem


*** Variables ***
${fail_message} =  ${EMPTY} 
${fail_extra_info} =  ${EMPTY}


*** Tasks ***
Apply Case Submission 
    Log To Console  \nNote nothing displayed for a while - cypress output only shows upon completion
    ${cy_cwd} =  Get Root Dir  ${CURDIR}
    ${cypress_response} =  Cypress runner  cypress\\e2e\\apply_case_spec.cy.js  ${cy_cwd}
    Log To Console    ${cypress_response.stdout}
    
    ${apply_reference} =  case_reference_locator.Extract Reference Number  ${cypress_response.stdout}  LAA Reference
    ${ccms_case_reference} =  case_reference_locator.Extract Reference Number  ${cypress_response.stdout}

    Log To Console  \nNew Apply Reference: ${apply_reference}
    Log To Console  \nNew Case Reference: ${ccms_case_reference}\n 

    Set Environment Variable  case_reference  ${ccms_case_reference}
    Set Environment Variable  apply_reference  ${apply_reference}

    IF  "${apply_reference}" == ""
        ${fail_message} =  Catenate  ${fail_message}No Apply reference found
        ${fail_extra_info} =  Catenate  ${fail_extra_info}>> Incomplete case may be available in Apply which could be updated manually
    END

    IF  "${ccms_case_reference}" == ""
        IF  "${fail_message}" != ""
            ${fail_message} =  Catenate  ${fail_message}${SPACE}and${SPACE}
        END
        ${fail_message} =  Catenate  ${fail_message}No CCMS case reference found
        IF  """${fail_extra_info}""" != ""
            ${fail_extra_info} =  Catenate  ${fail_extra_info} \n
        END      
        ${fail_extra_info} =  Catenate  ${fail_extra_info}>> Absence of CCMS reference could be due to problem with CCMS. May appear automatically when CCMS problem fixed but only if Apply reference was generated.       
    END

    IF  "${fail_message}" != ""
        Fail With Voice And Help    ${fail_message}  ${fail_extra_info}
    END
