*** Settings ***
Documentation       Test suite for the SauceDemo shopping cart page.
...                 Covers: item persistence, quantity, removal, and navigation.

Resource            ../../resources/saucedemo/keywords/common_keywords.robot
Resource            ../../resources/saucedemo/keywords/login_keywords.robot
Resource            ../../resources/saucedemo/keywords/product_keywords.robot
Resource            ../../resources/saucedemo/keywords/cart_keywords.robot
Resource            ../../resources/saucedemo/variables/common_variables.robot

Suite Setup         Run Keywords
...                 Open Browser To Login Page    AND
...                 Login As Standard User    AND
...                 Product Page Should Be Displayed
Suite Teardown      Close Test Browser
Test Setup          Navigate To URL    ${PRODUCT_URL}
Test Teardown       Continue Shopping From Cart

*** Test Cases ***
TC_CART_001 – Cart Is Empty On Fresh Session
    [Documentation]    Navigates directly to the cart page and verifies it is empty.
    [Tags]    cart    smoke    regression
    Go To Cart
    Cart Page Should Be Displayed
    Cart Should Be Empty Of Line Items

TC_CART_002 – Added Item Appears In Cart
    [Documentation]    Adds a single item from inventory and verifies it appears on the cart page.
    [Tags]    cart    smoke    regression
    Add Sauce Labs Backpack To Cart
    Add Sauce Labs Bike Light To Cart
    Add Sauce Labs Bolt T-Shirt To Cart
    Go To Cart
    Cart Should Contain N Items    3
    Cart Should Contain Item Named    Sauce Labs Backpack
    Cart Should Contain Item Named    Sauce Labs Bike Light
    Cart Should Contain Item Named    Sauce Labs Bolt T-Shirt

