*** Variables ***
#  Product Page Locators
${LOC_PRODUCT_CONTAINER}          id:inventory_container
${LOC_PRODUCT_ITEMS}              css:.inventory_item
${LOC_PRODUCT_SORT_DROPDOWN}        css:[data-test="product-sort-container"]
${LOC_INVENTORY_ITEM_NAME}          css:.inventory_item_name
${LOC_INVENTORY_ITEM_PRICE}         css:.inventory_item_price
${LOC_ADD_TO_CART_BUTTON}           css:[data-test^="add-to-cart"]
${LOC_REMOVE_BUTTON}                css:[data-test^="remove"]
${LOC_CART_BADGE}                   css:.shopping_cart_badge
${LOC_CART_ICON}                    css:.shopping_cart_link
${LOC_BURGER_MENU}                  css:#react-burger-menu-btn
${LOC_LOGOUT_LINK}                  id:logout_sidebar_link
${LOC_SIDEBAR_CLOSE}                id:react-burger-cross-btn

# Item-specific add-to-cart buttons (by product name slug)
${LOC_ADD_SAUCE_LABS_BACKPACK}          css:[data-test="add-to-cart-sauce-labs-backpack"]
${LOC_ADD_SAUCE_LABS_BIKE_LIGHT}        css:[data-test="add-to-cart-sauce-labs-bike-light"]
${LOC_ADD_SAUCE_LABS_BOLT_TSHIRT}       css:[data-test="add-to-cart-sauce-labs-bolt-t-shirt"]
${LOC_ADD_SAUCE_LABS_FLEECE_JACKET}     css:[data-test="add-to-cart-sauce-labs-fleece-jacket"]
${LOC_ADD_SAUCE_LABS_ONESIE}            css:[data-test="add-to-cart-sauce-labs-onesie"]
${LOC_ADD_TEST_ALLTHETHINGS_TSHIRT}     css:[data-test="add-to-cart-test.allthethings()-t-shirt-(red)"]
