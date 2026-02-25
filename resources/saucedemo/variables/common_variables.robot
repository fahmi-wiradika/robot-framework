*** Variables ***
#  Browser & Timeouts
${BROWSER}              chrome
${BASE_URL}             https://www.saucedemo.com
${IMPLICIT_WAIT}        0 seconds
${PAGE_LOAD_TIMEOUT}    30 seconds
${ELEMENT_TIMEOUT}      15 seconds
${RETRY_INTERVAL}       0.5 seconds

#  Credentials
${STANDARD_USER}        standard_user
${LOCKED_USER}          locked_out_user
${PROBLEM_USER}         problem_user
${PERF_GLITCH_USER}     performance_glitch_user
${INVALID_USER}         invalid_user
${VALID_PASSWORD}       secret_sauce

#  URLs (relative)
${LOGIN_URL}            ${BASE_URL}/
${INVENTORY_URL}        ${BASE_URL}/inventory.html
${CART_URL}             ${BASE_URL}/cart.html
${CHECKOUT_STEP1_URL}   ${BASE_URL}/checkout-step-one.html
${CHECKOUT_STEP2_URL}   ${BASE_URL}/checkout-step-two.html
${CHECKOUT_COMPLETE_URL}    ${BASE_URL}/checkout-complete.html

#  Checkout Data
${FIRST_NAME}           Fahmi
${LAST_NAME}            Wiradika
${POSTAL_CODE}          11480

# Product Data – Names
${PROD_NAME_BACKPACK}           Sauce Labs Backpack
${PROD_NAME_BIKE_LIGHT}         Sauce Labs Bike Light
${PROD_NAME_BOLT_TSHIRT}        Sauce Labs Bolt T-Shirt
${PROD_NAME_FLEECE_JACKET}      Sauce Labs Fleece Jacket
${PROD_NAME_ONESIE}             Sauce Labs Onesie
${PROD_NAME_RED_TSHIRT}         Test.allTheThings() T-Shirt (Red)

# Product Data – Prices
${PROD_PRICE_BACKPACK}          $29.99
${PROD_PRICE_BIKE_LIGHT}        $9.99
${PROD_PRICE_BOLT_TSHIRT}       $15.99
${PROD_PRICE_FLEECE_JACKET}     $49.99
${PROD_PRICE_ONESIE}            $7.99
${PROD_PRICE_RED_TSHIRT}        $15.99

# Product Data – Expected Total Count
${PROD_TOTAL_COUNT}             6
