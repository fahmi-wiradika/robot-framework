*** Variables ***
# Create Product
${LOC_PRODUCT_NAME_FIELD}         css:#productName
${LOC_PRODUCT_PRICE_FIELD}        css:#productPrice
${LOC_PRODUCT_QUANTITY_FIELD}     css:#productQuantity
${LOC_ADD_PRODUCT_BUTTON}         css:button.btn-primary

# Notifications
${LOC_NOTIFICATION_MESSAGE}       css:.notification

# Product List
${LOC_PRODUCT_LIST_CONTAINER}     css:#productList
${LOC_PRODUCT_LIST}               css:#productList > div
${LOC_UPDATE_PRODUCT_BUTTON}      css:.btn-update
${LOC_DELETE_PRODUCT_BUTTON}      css:.btn-delete

# Update Modal
${LOC_UPDATE_MODAL}               css:#updateModal
${LOC_UPDATE_NAME_FIELD}          css:#updateName
${LOC_UPDATE_PRICE_FIELD}         css:#updatePrice
${LOC_UPDATE_QUANTITY_FIELD}      css:#updateQuantity
${LOC_CONFIRM_UPDATE_BUTTON}      css:#updateModal button.btn-update
${LOC_CANCEL_UPDATE_BUTTON}       css:#updateModal button.btn-cancel

# Delete Modal
${LOC_DELETE_MODAL}               css:#deleteModal
${LOC_CONFIRM_DELETE_BUTTON}      css:#deleteModal button.btn-delete

# Product Detail Fields
${LOC_PRODUCT_ID_TEXT}            css:.product-id
${LOC_PRODUCT_NAME_TEXT}          css:.product-name
${LOC_PRODUCT_PRICE_TEXT}         css:.product-price
${LOC_PRODUCT_QUANTITY_TEXT}      css:.product-quantity

