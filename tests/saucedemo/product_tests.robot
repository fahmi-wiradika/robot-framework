*** Settings ***
Documentation       Test suite for the SauceDemo inventory / product listing page.
...                 Covers: page display, sorting, and add-to-cart interactions.

Resource            ../../resources/saucedemo/keywords/common_keywords.robot
Resource            ../../resources/saucedemo/keywords/login_keywords.robot
Resource            ../../resources/saucedemo/keywords/product_keywords.robot
Resource            ../../resources/saucedemo/variables/common_variables.robot

Suite Setup         Open Browser To Login Page
Suite Teardown      Close Test Browser
Test Setup          Navigate To URL    ${LOGIN_URL}

*** Test Cases ***
TC_PRD_001 – Product Page Displays 6 Products
    [Documentation]    Verifies the full product catalog shows exactly 6 items.
    [Tags]    product    smoke    regression
    Login As Standard User
    Product Page Should Be Displayed
    Product Should Display N Items    6
