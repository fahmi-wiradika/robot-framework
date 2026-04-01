*** Settings ***
Documentation       End-to-end UI tests for the Simple CRUD application.
...                 Covers product creation, update by captured ID, deletion by captured ID,
...                 and final verification that the product no longer exists.

Resource            ../../resources/simple-crud-apps/keywords/common_keywords.robot
Resource            ../../resources/simple-crud-apps/keywords/simple_crud_keywords.robot
Resource            ../../resources/simple-crud-apps/variables/common_variables.robot

Suite Setup         Open Browser To Simple CRUD App
Suite Teardown      Close Test Browser

*** Test Cases ***
TC_CRUD_001 - Navigate To App And Verify Product List Loads
    [Documentation]
    ...    Navigates to the CRUD app, adds a product, captures its ID from the notification,
    ...    updates the same product using that ID, deletes it using the same ID,
    ...    and confirms the product is no longer displayed.
    [Tags]    crud    smoke    regression    e2e
    Open Simple CRUD App

TC_CRUD_002 - Add New Product And Verify It Appears In List
    [Documentation]
    ...    Adds a new product to the CRUD app and verifies it appears in the product list.
    [Tags]    crud    smoke    regression    e2e
    Add Product    ${PROD_NAME}    ${PROD_PRICE}    ${PROD_QUANTITY}
    ${product_id}=    Get Product Id From Notification
    Log    Product added with ID: ${product_id}
    Set Suite Variable    ${PRODUCT_ID}    ${product_id}
    Wait Notification To Disappear
    Assert Product Details
    ...    ${product_id}
    ...    ${product_id}
    ...    ${PROD_NAME}
    ...    ${PROD_PRICE}
    ...    ${PROD_QUANTITY}

TC_CRUD_003 - Update Product And Verify Changes
    [Documentation]
    ...    Updates an existing product in the CRUD app and verifies the changes are reflected.
    [Tags]    crud    regression    e2e
    Update Product
    ...    ${PRODUCT_ID}
    ...    ${UPDATED_PROD_NAME}
    ...    ${UPDATED_PROD_PRICE}
    ...    ${UPDATED_PROD_QUANTITY}
    Wait Notification To Disappear
    Assert Product Details
    ...    ${PRODUCT_ID}
    ...    ${PRODUCT_ID}
    ...    ${UPDATED_PROD_NAME}
    ...    ${UPDATED_PROD_PRICE}
    ...    ${UPDATED_PROD_QUANTITY}

TC_CRUD_004 - Delete Product And Verify It Is Removed
    [Documentation]
    ...    Deletes a product from the CRUD app and verifies it is no longer present.
    [Tags]    crud    regression    e2e
    Delete Product    ${PRODUCT_ID}
    Wait Notification To Disappear
    Product Should Not Be Present    ${PRODUCT_ID}
