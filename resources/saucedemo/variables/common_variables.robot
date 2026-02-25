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

# Product Data

