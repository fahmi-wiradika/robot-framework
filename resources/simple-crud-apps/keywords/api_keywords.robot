*** Settings ***
Library     RequestsLibrary
Library     Collections

Resource    ../variables/api_variables.robot

*** Keywords ***
#  Session Management
Create Simple CRUD API Session
    [Documentation]    Creates a persistent HTTP session against the Simple CRUD base URL.
    Create Session    simple_crud    ${API_BASE_URL}    verify=True

#  API Operations
API Get All Products
    [Documentation]    GET /api/products — returns all products.
    ${response}=    GET On Session    simple_crud    ${API_PRODUCTS_ENDPOINT}
    RETURN    ${response}

API Create Product
    [Arguments]    ${name}    ${price}    ${quantity}
    [Documentation]    POST /api/products — creates a product and returns the response.
    ${body}=        Create Dictionary    name=${name}    price=${price}    quantity=${quantity}
    ${response}=    POST On Session    simple_crud    ${API_PRODUCTS_ENDPOINT}    json=${body}
    RETURN    ${response}

API Get Product By Id
    [Arguments]    ${product_id}
    [Documentation]
    ...    GET /api/products/{id} — returns a product object or a not-found message body.
    ...    expected_status=any prevents RequestsLibrary from raising on non-2xx codes.
    ${response}=    GET On Session    simple_crud    ${API_PRODUCTS_ENDPOINT}/${product_id}
    ...    expected_status=any
    RETURN    ${response}

API Update Product
    [Arguments]    ${product_id}    &{fields}
    [Documentation]    PUT /api/products/{id} — updates any supplied fields and returns the response.
    ${response}=    PUT On Session    simple_crud    ${API_PRODUCTS_ENDPOINT}/${product_id}
    ...    json=${fields}
    RETURN    ${response}

API Delete Product
    [Arguments]    ${product_id}
    [Documentation]    DELETE /api/products/{id} — deletes a product and returns the response.
    ${response}=    DELETE On Session    simple_crud    ${API_PRODUCTS_ENDPOINT}/${product_id}
    RETURN    ${response}

#  Response Assertions
Response Status Should Be
    [Arguments]    ${response}    ${expected_status}
    [Documentation]    Asserts the HTTP status code matches the expected value.
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    ...    msg=Expected HTTP ${expected_status} but got ${response.status_code}

Response Body Should Be A List
    [Arguments]    ${response}
    [Documentation]    Asserts the response body is a JSON array.
    ${body}=    Set Variable    ${response.json()}
    Should Be True    isinstance($body, list)
    ...    msg=Expected a JSON array but got: ${body}

Response Body Should Contain Key
    [Arguments]    ${response}    ${key}
    [Documentation]    Asserts the response JSON object contains the given key.
    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    ${key}
    ...    msg=Response body missing expected key "${key}": ${body}

Response Field Should Equal
    [Arguments]    ${response}    ${field}    ${expected_value}
    [Documentation]    Asserts a top-level field in the response JSON matches the expected value.
    ${body}=    Set Variable    ${response.json()}
    Should Be Equal    ${body}[${field}]    ${expected_value}
    ...    msg=Expected "${field}" to be "${expected_value}" but got "${body}[${field}]"

Response Field Should Equal As Numbers
    [Arguments]    ${response}    ${field}    ${expected_value}
    [Documentation]    Asserts a numeric field in the response JSON matches the expected value.
    ${body}=    Set Variable    ${response.json()}
    Should Be Equal As Numbers    ${body}[${field}]    ${expected_value}
    ...    msg=Expected "${field}" to be ${expected_value} but got ${body}[${field}]
