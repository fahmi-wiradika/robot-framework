*** Settings ***
Documentation
...    API test suite for the Simple CRUD application.
...    Migrated from: cypress/e2e/simple-crud/api/core-api-pom.cy.js
...
...    ⚠  Test execution order matters: TC_API_002 captures ${PRODUCT_ID} via
...    Set Suite Variable and all subsequent tests depend on that value.
...    Run the full suite together — do not execute individual tests in isolation.

Resource    ../../resources/simple-crud-apps/keywords/api_keywords.robot
Resource    ../../resources/simple-crud-apps/variables/api_variables.robot

Suite Setup     Create Simple CRUD API Session

*** Test Cases ***
TC_API_001 - GET All Products Returns 200 And A List
    [Documentation]
    ...    Corresponds to: 'should get all products'
    ...    Verifies the products endpoint returns HTTP 200 and a JSON array.
    [Tags]    api    smoke    regression
    ${response}=    API Get All Products
    Response Status Should Be          ${response}    200
    Response Body Should Be A List     ${response}

TC_API_002 - POST Create New Product Returns Product Object With ID
    [Documentation]
    ...    Corresponds to: 'should create a new product'
    ...    Creates a product with fixture data and captures the returned _id
    ...    into ${PRODUCT_ID} for use by all subsequent test cases.
    [Tags]    api    smoke    regression
    ${response}=    API Create Product
    ...    ${API_PROD_NAME}
    ...    ${API_PROD_PRICE}
    ...    ${API_PROD_QUANTITY}
    Response Status Should Be              ${response}    200
    Response Body Should Contain Key       ${response}    _id
    ${body}=    Set Variable               ${response.json()}
    Set Suite Variable    ${PRODUCT_ID}    ${body}[_id]
    Log    Product created with ID: ${PRODUCT_ID}

TC_API_003 GET Product By ID Returns Correct Data
    [Documentation]
    ...    Corresponds to: 'should get a product by id'
    ...    Retrieves the product created in TC_API_002 and validates all fields.
    [Tags]    api    regression
    ${response}=    API Get Product By Id    ${PRODUCT_ID}
    Response Status Should Be              ${response}    200
    Response Field Should Equal            ${response}    name        ${API_PROD_NAME}
    Response Field Should Equal As Numbers    ${response}    quantity    ${API_PROD_QUANTITY}
    Response Field Should Equal As Numbers    ${response}    price       ${API_PROD_PRICE}

TC_API_004 - PUT Update Product Returns Updated Quantity
    [Documentation]
    ...    Corresponds to: 'should update a product'
    ...    Updates the quantity field of the product created in TC_API_002
    ...    and asserts the response reflects the new value.
    [Tags]    api    regression
    ${response}=    API Update Product
    ...    ${PRODUCT_ID}
    ...    quantity=${API_UPDATED_QUANTITY}
    Response Status Should Be              ${response}    200
    Response Field Should Equal As Numbers    ${response}    quantity    ${API_UPDATED_QUANTITY}

TC_API_005 - DELETE Product Returns Success Message
    [Documentation]
    ...    Corresponds to: 'should delete a product by id'
    ...    Deletes the product and asserts the API returns a success message.
    [Tags]    api    regression
    ${response}=    API Delete Product    ${PRODUCT_ID}
    Response Status Should Be    ${response}    200
    Response Field Should Equal  ${response}    message    ${MSG_DELETED}

TC_API_006 - GET Deleted Product Returns Not Found Message
    [Documentation]
    ...    Corresponds to: 'should get product by id not found'
    ...    Confirms the deleted product can no longer be retrieved —
    ...    the API returns HTTP 200 with a "Product not found" message body.
    [Tags]    api    regression    negative
    ${response}=    API Get Product By Id    ${PRODUCT_ID}
    Response Status Should Be    ${response}    200
    Response Field Should Equal  ${response}    message    ${MSG_NOT_FOUND}
