*** Settings ***
Library    SeleniumLibrary

Resource    ../variables/common_variables.robot

*** Keywords ***
# Browser Lifecycle
Open Browser To Login Page
    [Documentation]    Opens Chrome and navigates to the SauceDemo login page.
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    ...    options=add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--incognito")
    Maximize Browser Window
    Set Selenium Page Load Timeout    ${PAGE_LOAD_TIMEOUT}
    Wait Until Page Is Loaded

Close Test Browser
    [Documentation]    Captures a screenshot on failure then closes the browser.
    Run Keyword If Any Tests Failed     Capture Page Screenshot
    Close Browser

#  Navigation Helpers
Wait Until Page Is Loaded
    [Documentation]    Waits for the browser to finish loading (document.readyState = complete).
    Wait For Condition    return document.readyState == "complete"    timeout=${PAGE_LOAD_TIMEOUT}

Navigate To URL
    [Arguments]    ${url}
    [Documentation]    Navigates to a URL and waits for the page to fully load.
    Go To    ${url}
    Wait Until Page Is Loaded

Verify Current URL Contains
    [Arguments]    ${expected_url_fragment}
    [Documentation]    Asserts the current URL contains the given fragment.
    ${current_url}=    Get Location
    Should Contain    ${current_url}    ${expected_url_fragment}
    ...    msg=Expected URL to contain "${expected_url_fragment}" but got "${current_url}"

#    Element Interaction

Wait And Click Element
    [Arguments]    ${locator}
    [Documentation]    Waits for an element to be visible and clickable, then clicks it.
    Wait Until Element Is Visible    ${locator}    timeout=${ELEMENT_TIMEOUT}
    Wait Until Element Is Enabled    ${locator}    timeout=${ELEMENT_TIMEOUT}
    Click Element    ${locator}

Wait And Input Text
    [Arguments]    ${locator}    ${text}
    [Documentation]    Waits for an element, clears it, then types text.
    Wait Until Element Is Visible    ${locator}    timeout=${ELEMENT_TIMEOUT}
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}

Wait And Get Text
    [Arguments]    ${locator}
    [Documentation]    Waits for an element to be visible and returns its text.
    Wait Until Element Is Visible    ${locator}    timeout=${ELEMENT_TIMEOUT}
    ${text}=    Get Text    ${locator}
    RETURN    ${text}

Wait And Select From List By Value
    [Arguments]    ${locator}    ${value}
    [Documentation]    Waits for a dropdown, then selects an option by value.
    Wait Until Element Is Visible    ${locator}    timeout=${ELEMENT_TIMEOUT}
    Select From List By Value    ${locator}    ${value}

Element Should Be Present
    [Arguments]    ${locator}    ${timeout}=${ELEMENT_TIMEOUT}
    [Documentation]    Asserts that an element exists in the DOM (visible or not).
    Wait Until Page Contains Element    ${locator}    timeout=${timeout}

Element Should Not Be Present
    [Arguments]    ${locator}    ${timeout}=5s
    [Documentation]    Asserts that an element is NOT present in the DOM.
    Wait Until Page Does Not Contain Element    ${locator}    timeout=${timeout}