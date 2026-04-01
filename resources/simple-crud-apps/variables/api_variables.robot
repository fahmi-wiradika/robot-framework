*** Variables ***
#  API Configuration
${API_BASE_URL}             https://simple-crud-apps.vercel.app
${API_PRODUCTS_ENDPOINT}    /api/products

#  Product Test Data – Create
${API_PROD_NAME}            Bakso Malang
${API_PROD_PRICE}           ${15000}
${API_PROD_QUANTITY}        ${2}

#  Product Test Data – Update
${API_UPDATED_NAME}         Bakso Spesial
${API_UPDATED_PRICE}        ${20000}
${API_UPDATED_QUANTITY}     ${3}

#  Expected Response Messages
${MSG_DELETED}              Product deleted successfully
${MSG_NOT_FOUND}            Product not found

#  Suite-level state (populated at runtime by TC_API_002)
${PRODUCT_ID}               ${EMPTY}
