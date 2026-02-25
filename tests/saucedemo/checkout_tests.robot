*** Settings ***
Documentation       Test suite for the SauceDemo checkout flow.
...                 Covers: info validation, price calculation, and order completion.

Resource            ../../resources/saucedemo/keywords/common_keywords.robot
Resource            ../../resources/saucedemo/keywords/login_keywords.robot
Resource            ../../resources/saucedemo/keywords/product_keywords.robot
Resource            ../../resources/saucedemo/keywords/cart_keywords.robot
Resource            ../../resources/saucedemo/keywords/checkout_keywords.robot
Resource            ../../resources/saucedemo/variables/common_variables.robot

Suite Setup         Run Keywords
...                 Open Browser To Login Page    AND
...                 Login As Standard User    AND
...                 Product Page Should Be Displayed
Suite Teardown      Close Test Browser
Test Setup          Prepare Cart With One Item
Test Teardown       Clear All Cart Items


*** Keywords ***
Prepare Cart With One Item
    [Documentation]
    ...    Navigates to the inventory page, adds one backpack, then proceeds to checkout.
    ...    Cart state is guaranteed clean by the preceding Test Teardown.
    Navigate To URL    ${PRODUCT_URL}
    Add Sauce Labs Backpack To Cart
    Go To Cart
    Proceed To Checkout

*** Test Cases ***
TC_CHK_001 – Complete Purchase With Valid Information
    [Documentation]
    ...    End-to-end happy-path: fill info → review order → finish → confirm.
    [Tags]    checkout    e2e    smoke    regression
    Complete Checkout With Default Info

TC_CHK_002 – Checkout Info – Missing First Name Shows Error
    [Documentation]    Submitting the info form without a first name shows a validation error.
    [Tags]    checkout    negative    regression
    Checkout Step 1 Should Be Displayed
    Fill Checkout Information    first_name=${EMPTY}    last_name=${LAST_NAME}    postal_code=${POSTAL_CODE}
    Wait And Click Element    ${LOC_CONTINUE_BUTTON}
    Checkout Info Should Fail With Error    First Name is required

TC_CHK_003 – Checkout Info – Missing Last Name Shows Error
    [Documentation]    Submitting without a last name shows a validation error.
    [Tags]    checkout    negative    regression
    Checkout Step 1 Should Be Displayed
    Fill Checkout Information    first_name=${FIRST_NAME}    last_name=${EMPTY}    postal_code=${POSTAL_CODE}
    Wait And Click Element    ${LOC_CONTINUE_BUTTON}
    Checkout Info Should Fail With Error    Last Name is required

TC_CHK_004 – Checkout Info – Missing Postal Code Shows Error
    [Documentation]    Submitting without a postal code shows a validation error.
    [Tags]    checkout    negative    regression
    Checkout Step 1 Should Be Displayed
    Fill Checkout Information    first_name=${FIRST_NAME}    last_name=${LAST_NAME}    postal_code=${EMPTY}
    Wait And Click Element    ${LOC_CONTINUE_BUTTON}
    Checkout Info Should Fail With Error    Postal Code is required

TC_CHK_005 – Order Total Equals Subtotal Plus Tax
    [Documentation]
    ...    Adds an item, proceeds through checkout, and asserts the displayed
    ...    total matches the sum of item subtotal and tax.
    [Tags]    checkout    regression
    Checkout Step 1 Should Be Displayed
    Fill Checkout Information
    Continue To Order Overview
    Checkout Overview Should Be Displayed
    Order Total Should Equal Subtotal Plus Tax

TC_CHK_006 – Multiple Items Checkout Completes Successfully
    [Documentation]    Adds two items and completes the full checkout flow.
    [Tags]    checkout    e2e    regression
    Navigate To URL    ${PRODUCT_URL}
    Add Sauce Labs Bike Light To Cart
    Go To Cart
    Cart Should Contain N Items    2
    Proceed To Checkout
    Complete Checkout With Default Info
