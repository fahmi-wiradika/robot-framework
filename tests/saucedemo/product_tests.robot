*** Settings ***
Documentation       Test suite for the SauceDemo inventory / product listing page.
...                 Covers: page display, product name/price accuracy, Add-to-Cart availability, and sorting.

Resource            ../../resources/saucedemo/keywords/common_keywords.robot
Resource            ../../resources/saucedemo/keywords/login_keywords.robot
Resource            ../../resources/saucedemo/keywords/product_keywords.robot
Resource            ../../resources/saucedemo/locators/product_locators.robot
Resource            ../../resources/saucedemo/variables/common_variables.robot

Suite Setup         Open Browser To Login Page
Suite Teardown      Close Test Browser
Test Setup          Run Keywords
...                 Navigate To URL    ${LOGIN_URL}    AND
...                 Login As Standard User
Test Teardown       Logout

*** Test Cases ***
TC_PRD_001 – Product Page Displays 6 Products
    [Documentation]    Verifies the full product catalog shows exactly 6 items after login.
    [Tags]    product    smoke    regression
    Product Page Should Be Displayed
    Product Should Display N Items    ${PROD_TOTAL_COUNT}

TC_PRD_002 – Sauce Labs Backpack Has Correct Name, Price And Add To Cart Button
    [Documentation]
    ...    Verifies the Sauce Labs Backpack card displays the correct name ($29.99),
    ...    the correct price, and that its Add-to-Cart button is visible and enabled.
    [Tags]    product    regression
    Product Page Should Be Displayed
    Verify Product Card
    ...    ${LOC_ITEM_NAME_BACKPACK}        ${PROD_NAME_BACKPACK}
    ...    ${LOC_ITEM_PRICE_BACKPACK}       ${PROD_PRICE_BACKPACK}
    ...    ${LOC_ADD_SAUCE_LABS_BACKPACK}

TC_PRD_003 – Sauce Labs Bike Light Has Correct Name, Price And Add To Cart Button
    [Documentation]
    ...    Verifies the Sauce Labs Bike Light card displays the correct name,
    ...    the correct price ($9.99), and that its Add-to-Cart button is visible and enabled.
    [Tags]    product    regression
    Product Page Should Be Displayed
    Verify Product Card
    ...    ${LOC_ITEM_NAME_BIKE_LIGHT}      ${PROD_NAME_BIKE_LIGHT}
    ...    ${LOC_ITEM_PRICE_BIKE_LIGHT}     ${PROD_PRICE_BIKE_LIGHT}
    ...    ${LOC_ADD_SAUCE_LABS_BIKE_LIGHT}

TC_PRD_004 – Sauce Labs Bolt T-Shirt Has Correct Name, Price And Add To Cart Button
    [Documentation]
    ...    Verifies the Sauce Labs Bolt T-Shirt card displays the correct name,
    ...    the correct price ($15.99), and that its Add-to-Cart button is visible and enabled.
    [Tags]    product    regression
    Product Page Should Be Displayed
    Verify Product Card
    ...    ${LOC_ITEM_NAME_BOLT_TSHIRT}     ${PROD_NAME_BOLT_TSHIRT}
    ...    ${LOC_ITEM_PRICE_BOLT_TSHIRT}    ${PROD_PRICE_BOLT_TSHIRT}
    ...    ${LOC_ADD_SAUCE_LABS_BOLT_TSHIRT}

TC_PRD_005 – Sauce Labs Fleece Jacket Has Correct Name, Price And Add To Cart Button
    [Documentation]
    ...    Verifies the Sauce Labs Fleece Jacket card displays the correct name,
    ...    the correct price ($49.99), and that its Add-to-Cart button is visible and enabled.
    [Tags]    product    regression
    Product Page Should Be Displayed
    Verify Product Card
    ...    ${LOC_ITEM_NAME_FLEECE_JACKET}       ${PROD_NAME_FLEECE_JACKET}
    ...    ${LOC_ITEM_PRICE_FLEECE_JACKET}      ${PROD_PRICE_FLEECE_JACKET}
    ...    ${LOC_ADD_SAUCE_LABS_FLEECE_JACKET}

TC_PRD_006 – Sauce Labs Onesie Has Correct Name, Price And Add To Cart Button
    [Documentation]
    ...    Verifies the Sauce Labs Onesie card displays the correct name,
    ...    the correct price ($7.99), and that its Add-to-Cart button is visible and enabled.
    [Tags]    product    regression
    Product Page Should Be Displayed
    Verify Product Card
    ...    ${LOC_ITEM_NAME_ONESIE}      ${PROD_NAME_ONESIE}
    ...    ${LOC_ITEM_PRICE_ONESIE}     ${PROD_PRICE_ONESIE}
    ...    ${LOC_ADD_SAUCE_LABS_ONESIE}

TC_PRD_007 – Test.allTheThings() T-Shirt (Red) Has Correct Name, Price And Add To Cart Button
    [Documentation]
    ...    Verifies the Test.allTheThings() T-Shirt (Red) card displays the correct name,
    ...    the correct price ($15.99), and that its Add-to-Cart button is visible and enabled.
    [Tags]    product    regression
    Product Page Should Be Displayed
    Verify Product Card
    ...    ${LOC_ITEM_NAME_RED_TSHIRT}      ${PROD_NAME_RED_TSHIRT}
    ...    ${LOC_ITEM_PRICE_RED_TSHIRT}     ${PROD_PRICE_RED_TSHIRT}
    ...    ${LOC_ADD_TEST_ALLTHETHINGS_TSHIRT}

TC_PRD_008 – All 6 Products Have Available Add To Cart Buttons
    [Documentation]
    ...    Iterates every Add-to-Cart button on the page and asserts each one
    ...    is visible and enabled — ensures no product card is broken.
    [Tags]    product    smoke    regression
    Product Page Should Be Displayed
    ${buttons}=    Get WebElements    ${LOC_ADD_TO_CART_BUTTON}
    ${button_count}=    Get Length    ${buttons}
    Should Be Equal As Integers    ${button_count}    ${PROD_TOTAL_COUNT}
    ...    msg=Expected ${PROD_TOTAL_COUNT} Add-to-Cart buttons but found ${button_count}
    FOR    ${button}    IN    @{buttons}
        Element Should Be Visible    ${button}
        Element Should Be Enabled    ${button}
    END
