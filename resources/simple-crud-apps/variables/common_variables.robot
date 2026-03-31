*** Variables ***
#  Browser & Timeouts
${BROWSER}              chrome
${BASE_URL}             https://simple-crud-apps.vercel.app
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
${SIMPLE_CRUD_APP_URL}            ${BASE_URL}/


#  Checkout Data
${FIRST_NAME}           Fahmi
${LAST_NAME}            Wiradika
${POSTAL_CODE}          11480

# Product Data
${PROD_NAME}           Ketroprak
${PROD_PRICE}          18000
${PROD_QUANTITY}       1
${UPDATED_PROD_NAME}   Pecel Lele
${UPDATED_PROD_PRICE}  20000
${UPDATED_PROD_QUANTITY}    2
