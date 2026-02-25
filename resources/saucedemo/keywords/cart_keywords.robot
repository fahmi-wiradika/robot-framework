*** Settings ***
Resource    common_keywords.robot
Resource    ../locators/cart_locators.robot
Resource    ../variables/common_variables.robot

*** Keywords ***
#  Cart Page Assertions
Cart Page Should Be Displayed
    [Documentation]    Asserts the cart page is loaded.
    Wait Until Element Is Visible    ${LOC_CART_LIST}    timeout=${ELEMENT_TIMEOUT}
    Verify Current URL Contains    /cart.html

Cart Should Contain N Items
    [Arguments]    ${expected_count}
    [Documentation]    Asserts the cart contains exactly N line items.
    Wait Until Element Is Visible    ${LOC_CART_ITEMS}    timeout=${ELEMENT_TIMEOUT}
    ${items}=    Get WebElements    ${LOC_CART_ITEMS}
    ${actual_count}=    Get Length    ${items}
    Should Be Equal As Integers    ${actual_count}    ${expected_count}
    ...    msg=Cart expected ${expected_count} item(s) but found ${actual_count}

Cart Should Contain Item Named
    [Arguments]    ${expected_name}
    [Documentation]
    ...    Asserts an item with the given name is in the cart.
    ...    Uses direct IF string comparison instead of Run Keyword And Return Status
    ...    so no [ FAIL ] noise is logged when iterating past non-matching names.
    Wait Until Element Is Visible    ${LOC_CART_ITEMS}    timeout=${ELEMENT_TIMEOUT}
    ${names}=    Get WebElements    ${LOC_CART_ITEM_NAME}
    ${found}=    Set Variable    ${FALSE}
    FOR    ${el}    IN    @{names}
        ${name}=    Get Text    ${el}
        IF    '${name}' == '${expected_name}'
            ${found}=    Set Variable    ${TRUE}
            Exit For Loop
        END
    END
    Should Be True    ${found}
    ...    msg=Item "${expected_name}" not found in the cart.

Cart Should Be Empty Of Line Items
    [Documentation]    Asserts no cart item rows are present on the cart page.
    Element Should Not Be Present    ${LOC_CART_ITEMS}    timeout=5s

#  Cart Actions
Proceed To Checkout
    [Documentation]    Clicks the Checkout button to start the checkout flow.
    Wait And Click Element    ${LOC_CART_CHECKOUT_BUTTON}
    Verify Current URL Contains    /checkout-step-one.html

Continue Shopping From Cart
    [Documentation]    Clicks 'Continue Shopping' to return to the inventory page.
    Wait And Click Element    ${LOC_CART_CONTINUE_SHOPPING}
    Verify Current URL Contains    /inventory.html

Clear All Cart Items
    [Documentation]
    ...    Navigates to the cart page and removes every line item found.
    ...    Uses Get Element Count instead of Run Keyword And Return Status
    ...    so no [ FAIL ] noise is written to the log when the cart is already empty.
    ...    Always returns to the inventory page on completion.
    Go To    ${CART_URL}
    Wait Until Page Is Loaded
    ${count}=    Get Element Count    ${LOC_REMOVE_FROM_CART_BTN}
    IF    ${count} > 0
        ${buttons}=    Get WebElements    ${LOC_REMOVE_FROM_CART_BTN}
        FOR    ${btn}    IN    @{buttons}
            Click Element    ${btn}
        END
    END
    Go To    ${PRODUCT_URL}
    Wait Until Page Is Loaded
