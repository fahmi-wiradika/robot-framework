*** Settings ***
Documentation       Test suite for the SauceDemo login page.
...                 Covers: successful login, failure scenarios, and logout.

Resource            ../../resources/saucedemo/keywords/common_keywords.robot
Resource            ../../resources/saucedemo/keywords/login_keywords.robot
Resource            ../../resources/saucedemo/variables/common_variables.robot

Suite Setup         Open Browser To Login Page
Suite Teardown      Close Test Browser
Test Setup          Navigate To URL    ${LOGIN_URL}

*** Test Cases ***
TC_LOGIN_001 – Standard User Can Log In Successfully
    [Documentation]    Verifies a standard user can authenticate and reach the inventory page.
    Login As    ${STANDARD_USER}
    Login Should Succeed
    Logout

TC_LOGIN_002 - Invalid User Unable To Log In
    [Documentation]    Verifies a invalid user login attempt
    Login As    ${INVALID_USER}
    Login Should Fail With Message    Epic sadface: Username and password do not match any user in this service