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

# Item-specific remove buttons (by product name slug)
${LOC_REMOVE_SAUCE_LABS_BACKPACK}       css:[data-test="remove-sauce-labs-backpack"]
${LOC_REMOVE_SAUCE_LABS_BIKE_LIGHT}     css:[data-test="remove-sauce-labs-bike-light"]
${LOC_REMOVE_SAUCE_LABS_BOLT_TSHIRT}    css:[data-test="remove-sauce-labs-bolt-t-shirt"]
${LOC_REMOVE_SAUCE_LABS_FLEECE_JACKET}  css:[data-test="remove-sauce-labs-fleece-jacket"]
${LOC_REMOVE_SAUCE_LABS_ONESIE}         css:[data-test="remove-sauce-labs-onesie"]
${LOC_REMOVE_TEST_ALLTHETHINGS_TSHIRT}  css:[data-test="remove-test.allthethings()-t-shirt-(red)"]

# Item card – scoped name and price by product title (XPath)
${LOC_ITEM_NAME_BACKPACK}           css:[data-test="item-4-title-link"]
${LOC_ITEM_NAME_BIKE_LIGHT}         css:[data-test="item-0-title-link"]
${LOC_ITEM_NAME_BOLT_TSHIRT}        css:[data-test="item-1-title-link"]
${LOC_ITEM_NAME_FLEECE_JACKET}      css:[data-test="item-5-title-link"]
${LOC_ITEM_NAME_ONESIE}             css:[data-test="item-2-title-link"]
${LOC_ITEM_NAME_RED_TSHIRT}         css:[data-test="item-3-title-link"]

# Item card – price sibling resolved via ancestor (XPath)
${LOC_ITEM_PRICE_BACKPACK}          css:body > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1)
${LOC_ITEM_PRICE_BIKE_LIGHT}        css:body > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1)
${LOC_ITEM_PRICE_BOLT_TSHIRT}       css:body > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(3) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1)
${LOC_ITEM_PRICE_FLEECE_JACKET}     css:body > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(4) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1)
${LOC_ITEM_PRICE_ONESIE}            css:body > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(5) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1)
${LOC_ITEM_PRICE_RED_TSHIRT}        css:body > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(6) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1)
