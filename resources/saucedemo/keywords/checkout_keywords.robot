*** Settings ***
Resource    common_keywords.robot
Resource    ../locators/checkout_locators.robot
Resource    ../variables/common_variables.robot

*** Keywords ***

#  Checkout Step 1 – Customer Info
Checkout Step 1 Should Be Displayed
    Wait Until Element Is Visible    ${LOC_FIRST_NAME_INPUT}    timeout=${ELEMENT_TIMEOUT}
    Verify Current URL Contains    /checkout-step-one.html

Fill Checkout Information
    [Arguments]    ${first_name}=${FIRST_NAME}    ${last_name}=${LAST_NAME}    ${postal_code}=${POSTAL_CODE}
    [Documentation]    Fills in the checkout information form fields.
    Wait And Input Text    ${LOC_FIRST_NAME_INPUT}    ${first_name}
    Wait And Input Text    ${LOC_LAST_NAME_INPUT}    ${last_name}
    Wait And Input Text    ${LOC_POSTAL_CODE_INPUT}    ${postal_code}

Continue To Order Overview
    [Documentation]    Clicks Continue and asserts navigation to step 2.
    Wait And Click Element    ${LOC_CONTINUE_BUTTON}
    Verify Current URL Contains    /checkout-step-two.html

Checkout Info Should Fail With Error
    [Arguments]    ${expected_error}
    [Documentation]    Asserts a validation error is displayed on the checkout info page.
    Wait Until Element Is Visible    ${LOC_CHECKOUT_ERROR}    timeout=${ELEMENT_TIMEOUT}
    ${actual_error}=    Get Text    ${LOC_CHECKOUT_ERROR}
    Should Contain    ${actual_error}    ${expected_error}
    ...    msg=Expected checkout error "${expected_error}" but got "${actual_error}"

#  Checkout Step 2 – Overview
Checkout Overview Should Be Displayed
    Wait Until Element Is Visible    ${LOC_CHECKOUT_SUMMARY}    timeout=${ELEMENT_TIMEOUT}
    Verify Current URL Contains    /checkout-step-two.html

Get Order Subtotal
    [Documentation]    Returns the item subtotal as a float (strips label text and $ sign).
    ${raw}=    Wait And Get Text    ${LOC_SUMMARY_ITEM_TOTAL}
    # Text format: "Item total: $XX.XX"
    ${price_str}=    Evaluate    "${raw}".split("$")[-1]
    ${subtotal}=    Convert To Number    ${price_str}
    RETURN    ${subtotal}

Get Order Tax
    ${raw}=    Wait And Get Text    ${LOC_SUMMARY_TAX}
    ${price_str}=    Evaluate    "${raw}".split("$")[-1]
    ${tax}=    Convert To Number    ${price_str}
    RETURN    ${tax}

Get Order Total
    ${raw}=    Wait And Get Text    ${LOC_SUMMARY_TOTAL}
    ${price_str}=    Evaluate    "${raw}".split("$")[-1]
    ${total}=    Convert To Number    ${price_str}
    RETURN    ${total}

Order Total Should Equal Subtotal Plus Tax
    [Documentation]    Asserts Total = Subtotal + Tax (within $0.01 rounding tolerance).
    ${subtotal}=    Get Order Subtotal
    ${tax}=    Get Order Tax
    ${total}=    Get Order Total
    ${expected_total}=    Evaluate    round(${subtotal} + ${tax}, 2)
    Should Be Equal As Numbers    ${total}    ${expected_total}
    ...    msg=Total ($${total}) does not equal subtotal ($${subtotal}) + tax ($${tax}) = $${expected_total}

Finish Order
    [Documentation]    Clicks Finish to complete the purchase.
    Wait And Click Element    ${LOC_FINISH_BUTTON}
    Verify Current URL Contains    /checkout-complete.html

#  Checkout Step 3 – Complete
Order Confirmation Should Be Displayed
    [Documentation]    Asserts the order success/confirmation page is shown.
    Wait Until Element Is Visible    ${LOC_ORDER_COMPLETE_HEADER}    timeout=${ELEMENT_TIMEOUT}
    ${header_text}=    Get Text    ${LOC_ORDER_COMPLETE_HEADER}
    Should Be Equal    ${header_text}    Thank you for your order!
    ...    msg=Order confirmation header was "${header_text}", expected "Thank you for your order!"
    Verify Current URL Contains    /checkout-complete.html


#  Composite – Full Checkout Flow
Complete Checkout With Default Info
    [Documentation]
    ...    High-level keyword that covers the full checkout journey from the cart page:
    ...    fill info → overview → finish → confirm.
    Checkout Step 1 Should Be Displayed
    Fill Checkout Information
    Continue To Order Overview
    Checkout Overview Should Be Displayed
    Order Total Should Equal Subtotal Plus Tax
    Finish Order
    Order Confirmation Should Be Displayed
