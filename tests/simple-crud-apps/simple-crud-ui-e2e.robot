*** Settings ***
Documentation       End-to-end UI tests for the Simple CRUD application.
...                 Covers product creation, update by captured ID, deletion by captured ID,
...                 and final verification that the product no longer exists.

Resource            ../../resources/simple-crud-apps/keywords/common_keywords.robot
Resource            ../../resources/simple-crud-apps/keywords/simple_crud_keywords.robot
Resource            ../../resources/simple-crud-apps/variables/common_variables.robot

Suite Setup         Open Browser To Login Page
Suite Teardown      Close Test Browser

*** Test Cases ***
TC_CRUD_001 – Add Update And Delete Product Successfully
    [Documentation]
    ...    Navigates to the CRUD app, adds a product, captures its ID from the notification,
    ...    updates the same product using that ID, deletes it using the same ID,
    ...    and confirms the product is no longer displayed.
    [Tags]    crud    smoke    regression    e2e
    Open Simple CRUD App

    Add Product    ${PROD_NAME}    ${PROD_PRICE}    ${PROD_QUANTITY}
    ${product_id}=    Get Product Id From Notification
    Log    Product added with ID: ${product_id}
    # Wait Notification To Disappear
    Assert Product Details
    ...    ${product_id}
    ...    ${product_id}
    ...    ${PROD_NAME}
    ...    ${PROD_PRICE}
    ...    ${PROD_QUANTITY}

    Update Product
    ...    ${product_id}
    ...    ${UPDATED_PROD_NAME}
    ...    ${UPDATED_PROD_PRICE}
    ...    ${UPDATED_PROD_QUANTITY}
    # Wait Notification To Disappear
    Assert Product Details
    ...    ${product_id}
    ...    ${product_id}
    ...    ${UPDATED_PROD_NAME}
    ...    ${UPDATED_PROD_PRICE}
    ...    ${UPDATED_PROD_QUANTITY}

    Delete Product    ${product_id}
    Wait Notification To Disappear
    Product Should Not Be Present    ${product_id}
