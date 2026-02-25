*** Settings ***
Resource    common_keywords.robot
Resource    ../locators/login_locators.robot
Resource    ../variables/common_variables.robot
Resource    ../locators/product_locators.robot

*** Keywords ***
# Login Action
Fill Login Form
    [Arguments]    ${username}    ${password}
    [Documentation]    Enter Credential Data
    Wait And Input Text    ${LOC_USERNAME_INPUT}    ${username}
    Wait And Input Text    ${LOC_PASSWORD_INPUT}    ${password}

Submit Login Form
    [Documentation]    Clicks the Login button.
    Wait And Click Element    ${LOC_LOGIN_BUTTON}

Login As
    [Arguments]    ${username}    ${password}=${VALID_PASSWORD}
    [Documentation]    Full login flow: fill form and submit.
    Fill Login Form    ${username}    ${password}
    Submit Login Form

Login As Standard User
    [Documentation]    Convenience keyword – logs in with the standard_user account.
    Login As    ${STANDARD_USER}

#  Login Assertions
Login Should Succeed
    [Documentation]    Asserts a successful login by verifying the inventory page is displayed.
    Wait Until Element Is Visible    ${LOC_PRODUCT_CONTAINER}    timeout=${ELEMENT_TIMEOUT}
    ...    error=Login failed – inventory page not loaded within ${ELEMENT_TIMEOUT}.
    Verify Current URL Contains    /inventory.html

Login Should Fail With Message
    [Arguments]    ${expected_message}
    [Documentation]    Asserts a failed login by checking the error message text.
    Wait Until Element Is Visible    ${LOC_ERROR_MESSAGE}    timeout=${ELEMENT_TIMEOUT}
    ${actual_message}=    Get Text    ${LOC_ERROR_MESSAGE}
    Should Contain    ${actual_message}    ${expected_message}
    ...    msg=Expected error message to contain "${expected_message}" but got "${actual_message}"

#  Logout Action
Logout
    [Documentation]    Opens the sidebar menu and clicks Logout.
    Wait And Click Element    ${LOC_BURGER_MENU}
    Wait And Click Element    ${LOC_LOGOUT_LINK}
    Wait Until Element Is Visible    ${LOC_LOGIN_BUTTON}    timeout=${ELEMENT_TIMEOUT}
    Verify Current URL Contains    ${LOGIN_URL}