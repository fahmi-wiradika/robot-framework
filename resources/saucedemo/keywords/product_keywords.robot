*** Settings ***
Resource    common_keywords.robot
Resource    ../locators/product_locators.robot
Resource    ../variables/common_variables.robot

*** Keywords ***
#  Navigation
Product Page Should Be Displayed
    [Documentation]    Asserts the inventory/products page is visible.
    Wait Until Element Is Visible    ${LOC_PRODUCT_CONTAINER}    timeout=${ELEMENT_TIMEOUT}
    Verify Current URL Contains    /inventory.html

#  Cart Actions
Add Item To Cart By Button Locator
    [Arguments]    ${add_button_locator}
    [Documentation]    Clicks an Add-to-Cart button and waits for the cart badge to update.
    ${badge_before}=    Get Cart Item Count
    Wait And Click Element    ${add_button_locator}
    ${expected_count}=    Evaluate    ${badge_before} + 1
    Wait Until Cart Badge Shows Count    ${expected_count}

Remove Item From Cart By Button Locator
    [Arguments]    ${remove_button_locator}
    [Documentation]    Clicks a Remove button and waits for the cart badge to update.
    ${badge_before}=    Get Cart Item Count
    Wait And Click Element    ${remove_button_locator}
    ${expected_count}=    Evaluate    ${badge_before} - 1
    Run Keyword If    ${expected_count} > 0
    ...    Wait Until Cart Badge Shows Count    ${expected_count}
    Run Keyword If    ${expected_count} == 0
    ...    Wait Until Element Is Not Visible    ${LOC_CART_BADGE}    timeout=${ELEMENT_TIMEOUT}

Add Sauce Labs Backpack To Cart
    Add Item To Cart By Button Locator    ${LOC_ADD_SAUCE_LABS_BACKPACK}

Add Sauce Labs Bike Light To Cart
    Add Item To Cart By Button Locator    ${LOC_ADD_SAUCE_LABS_BIKE_LIGHT}

Add Sauce Labs Bolt T-Shirt To Cart
    Add Item To Cart By Button Locator    ${LOC_ADD_SAUCE_LABS_BOLT_TSHIRT}

Add Sauce Labs Fleece Jacket To Cart
    Add Item To Cart By Button Locator    ${LOC_ADD_SAUCE_LABS_FLEECE_JACKET}

#  Sorting
Sort Products By
    [Arguments]    ${sort_value}
    [Documentation]
    ...    Selects a sort option from the dropdown.
    ...    Valid values: az, za, lohi, hilo
    Wait And Select From List By Value    ${LOC_PRODUCT_SORT_DROPDOWN}    ${sort_value}

#  Cart Badge Assertions
Get Cart Item Count
    [Documentation]    Returns the current cart badge count. Returns 0 if badge is absent.
    ${badge_visible}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${LOC_CART_BADGE}
    Return From Keyword If    not ${badge_visible}    0
    ${count_text}=    Get Text    ${LOC_CART_BADGE}
    ${count}=    Convert To Integer    ${count_text}
    RETURN    ${count}

Wait Until Cart Badge Shows Count
    [Arguments]    ${expected_count}
    [Documentation]    Polls the cart badge until it displays the expected count.
    Wait Until Keyword Succeeds    ${ELEMENT_TIMEOUT}    ${RETRY_INTERVAL}
    ...    Cart Badge Should Show Count    ${expected_count}

Cart Badge Should Show Count
    [Arguments]    ${expected_count}
    ${actual_count}=    Get Cart Item Count
    Should Be Equal As Integers    ${actual_count}    ${expected_count}
    ...    msg=Cart badge expected ${expected_count} but showed ${actual_count}

Cart Should Be Empty
    [Documentation]    Asserts no cart badge is visible (0 items).
    Element Should Not Be Present    ${LOC_CART_BADGE}    timeout=5s

#  Product List Assertions
Product Should Display N Items
    [Arguments]    ${expected_count}
    Wait Until Element Is Visible    ${LOC_PRODUCT_ITEMS}    timeout=${ELEMENT_TIMEOUT}
    ${items}=    Get WebElements    ${LOC_PRODUCT_ITEMS}
    ${actual_count}=    Get Length    ${items}
    Should Be Equal As Integers    ${actual_count}    ${expected_count}
    ...    msg=Expected ${expected_count} inventory items but found ${actual_count}

#  Product Detail Assertions
Product Name Should Be Visible
    [Arguments]    ${name_locator}    ${expected_name}
    [Documentation]    Asserts a product name element is visible and its text matches the expected value.
    Wait Until Element Is Visible    ${name_locator}    timeout=${ELEMENT_TIMEOUT}
    ${actual_name}=    Get Text    ${name_locator}
    Should Be Equal    ${actual_name}    ${expected_name}
    ...    msg=Expected product name "${expected_name}" but found "${actual_name}"

Product Price Should Be Correct
    [Arguments]    ${price_locator}    ${expected_price}
    [Documentation]    Asserts a product's displayed price matches the expected value.
    Wait Until Element Is Visible    ${price_locator}    timeout=${ELEMENT_TIMEOUT}
    ${actual_price}=    Get Text    ${price_locator}
    Should Be Equal    ${actual_price}    ${expected_price}
    ...    msg=Expected price "${expected_price}" but found "${actual_price}"

Add To Cart Button Should Be Available
    [Arguments]    ${add_button_locator}
    [Documentation]    Asserts the Add-to-Cart button is visible and enabled (ready to interact).
    Wait Until Element Is Visible    ${add_button_locator}    timeout=${ELEMENT_TIMEOUT}
    Element Should Be Enabled    ${add_button_locator}

Verify Product Card
    [Arguments]    ${name_locator}    ${expected_name}    ${price_locator}    ${expected_price}    ${add_button_locator}
    [Documentation]
    ...    Compound assertion: validates name, price, and Add-to-Cart availability for a single product card.
    Product Name Should Be Visible        ${name_locator}        ${expected_name}
    Product Price Should Be Correct       ${price_locator}       ${expected_price}
    Add To Cart Button Should Be Available    ${add_button_locator}
