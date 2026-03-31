*** Settings ***
Library     String

Resource    common_keywords.robot
Resource    ../locators/simple_crud_locators.robot
Resource    ../variables/common_variables.robot

*** Keywords ***
#  Navigation Helpers
Open Simple CRUD App
    [Documentation]    Navigates to the Simple CRUD App and waits for the product list to load.
    Navigate To URL    ${SIMPLE_CRUD_APP_URL}
    Verify Product List Loaded

Verify Product List Loaded
    [Documentation]    Verifies the product list container is present and visible.
    Wait Until Element Is Visible    ${LOC_PRODUCT_LIST_CONTAINER}    timeout=${ELEMENT_TIMEOUT}

Add Product
    [Arguments]    ${name}    ${price}    ${quantity}
    [Documentation]    Adds a product with the given name, price, and quantity.
    Wait And Input Text    ${LOC_PRODUCT_NAME_FIELD}        ${name}
    Wait And Input Text    ${LOC_PRODUCT_PRICE_FIELD}       ${price}
    Wait And Input Text    ${LOC_PRODUCT_QUANTITY_FIELD}    ${quantity}
    Wait And Click Element    ${LOC_ADD_PRODUCT_BUTTON}
    Verify Notification Visible

Get Notification Message
    [Documentation]    Waits for a notification message to appear and returns its text.
    ${message}=    Verify Notification Visible
    RETURN    ${message}

Get Product Id From Notification
    [Documentation]    Extracts and returns the Product ID shown in the notification.
    ${message}=    Get Notification Message
    ${matches}=    Get Regexp Matches    ${message}    Product ID:\\s*([a-f0-9]+)    1
    Should Not Be Empty    ${matches}    msg=Unable to extract a Product ID from notification: ${message}
    RETURN    ${matches}[0]

# Update Product
Update Product
    [Arguments]    ${product_id}    ${new_name}=${EMPTY}    ${new_price}=${EMPTY}    ${new_quantity}=${EMPTY}
    [Documentation]    Updates a product by ID and confirms the notification is displayed.
    Click Product Action Button    ${product_id}    ${LOC_UPDATE_PRODUCT_BUTTON}
    Wait Until Element Is Visible    ${LOC_UPDATE_MODAL}    timeout=${ELEMENT_TIMEOUT}

    IF    "${new_name}" != ""
        Wait And Input Text    ${LOC_UPDATE_NAME_FIELD}        ${new_name}
    END
    IF    "${new_price}" != ""
        Wait And Input Text    ${LOC_UPDATE_PRICE_FIELD}       ${new_price}
    END
    IF    "${new_quantity}" != ""
        Wait And Input Text    ${LOC_UPDATE_QUANTITY_FIELD}    ${new_quantity}
    END

    Wait And Click Element    ${LOC_CONFIRM_UPDATE_BUTTON}
    Verify Notification Visible

# Delete Product
Delete Product
    [Arguments]    ${product_id}
    [Documentation]    Deletes a product by ID and confirms the success notification appears.
    Click Product Action Button    ${product_id}    ${LOC_DELETE_PRODUCT_BUTTON}
    Wait Until Element Is Visible    ${LOC_DELETE_MODAL}    timeout=${ELEMENT_TIMEOUT}
    Wait And Click Element    ${LOC_CONFIRM_DELETE_BUTTON}
    Verify Notification Visible

Click Product Action Button
    [Arguments]    ${identifier}    ${button_locator}
    [Documentation]    Clicks an action button inside the product row matching the given identifier.
    ${row_locator}=      Get Product Row Locator    ${identifier}
    ${button_class}=     Replace String    ${button_locator}    css:.    ${EMPTY}
    ${action_locator}=   Set Variable    ${row_locator}//button[contains(@class, "${button_class}")]
    Wait And Click Element    ${action_locator}

Get Product Row Locator
    [Arguments]    ${identifier}
    [Documentation]    Builds a row locator for the product list item containing the given identifier.
    ${row_locator}=    Set Variable    xpath=//*[@id="productList"]/div[contains(normalize-space(.), "${identifier}")]
    RETURN    ${row_locator}

Verify Notification Visible
    [Documentation]    Waits for the notification to be visible and returns its text.
    Wait Until Element Is Visible    ${LOC_NOTIFICATION_MESSAGE}    timeout=${ELEMENT_TIMEOUT}
    ${message}=    Get Text    ${LOC_NOTIFICATION_MESSAGE}
    Should Not Be Empty    ${message}
    RETURN    ${message}

Wait Notification To Disappear
    [Documentation]    Waits until the notification is no longer visible.
    Wait Until Element Is Not Visible    ${LOC_NOTIFICATION_MESSAGE}    timeout=${ELEMENT_TIMEOUT}

Assert Product Details
    [Arguments]    ${identifier}    ${expected_id}=${EMPTY}    ${expected_name}=${EMPTY}    ${expected_price}=${EMPTY}    ${expected_quantity}=${EMPTY}
    [Documentation]    Asserts product details for the row identified by the given value.
    ${row_locator}=    Get Product Row Locator    ${identifier}
    Wait Until Element Is Visible    ${row_locator}    timeout=${ELEMENT_TIMEOUT}

    IF    "${expected_id}" != ""
        Row Field Text Should Be    ${row_locator}    product-id          ${expected_id}
    END
    IF    "${expected_name}" != ""
        Row Field Text Should Be    ${row_locator}    product-name        ${expected_name}
    END
    IF    "${expected_price}" != ""
        Row Field Text Should Be    ${row_locator}    product-price       ${expected_price}
    END
    IF    "${expected_quantity}" != ""
        Row Field Text Should Be    ${row_locator}    product-quantity    ${expected_quantity}
    END

Row Field Text Should Be
    [Arguments]    ${row_locator}    ${field_class}    ${expected_value}
    [Documentation]    Verifies the value of a product field within a product row.
    ${field_locator}=    Set Variable    ${row_locator}//*[contains(@class, "${field_class}")]
    Wait Until Element Is Visible    ${field_locator}    timeout=${ELEMENT_TIMEOUT}
    ${actual_value}=    Get Text    ${field_locator}
    IF    "${field_class}" == "product-price"
        ${normalized_actual}=      Replace String Using Regexp    ${actual_value}      [^0-9]    ${EMPTY}
        ${normalized_expected}=    Replace String Using Regexp    ${expected_value}    [^0-9]    ${EMPTY}
        Should Start With    ${normalized_actual}    ${normalized_expected}
        ...    msg=Expected ${field_class} to reflect price "${expected_value}" but found "${actual_value}"
    ELSE IF    "${field_class}" == "product-quantity"
        ${normalized_actual}=      Replace String Using Regexp    ${actual_value}      [^0-9]    ${EMPTY}
        ${normalized_expected}=    Replace String Using Regexp    ${expected_value}    [^0-9]    ${EMPTY}
        Should Be Equal    ${normalized_actual}    ${normalized_expected}
        ...    msg=Expected ${field_class} to reflect quantity "${expected_value}" but found "${actual_value}"
    ELSE
        Should Be Equal    ${actual_value}    ${expected_value}
        ...    msg=Expected ${field_class} to be "${expected_value}" but found "${actual_value}"
    END

Product Should Not Be Present
    [Arguments]    ${identifier}
    [Documentation]    Verifies that no product row exists for the provided identifier.
    ${row_locator}=    Get Product Row Locator    ${identifier}
    Wait Until Page Does Not Contain Element    ${row_locator}    timeout=${ELEMENT_TIMEOUT}