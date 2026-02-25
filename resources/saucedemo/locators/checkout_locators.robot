*** Variables ***
# Customer Info
${LOC_FIRST_NAME_INPUT}     id:first-name
${LOC_LAST_NAME_INPUT}      id:last-name
${LOC_POSTAL_CODE_INPUT}    id:postal-code
${LOC_CONTINUE_BUTTON}      id:continue
${LOC_CHECKOUT_ERROR}       css:[data-test="error"]

# Overview
${LOC_CHECKOUT_SUMMARY}         css:.checkout_summary_container
${LOC_SUMMARY_ITEM_TOTAL}       css:.summary_subtotal_label
${LOC_SUMMARY_TAX}              css:.summary_tax_label
${LOC_SUMMARY_TOTAL}            css:.summary_total_label
${LOC_FINISH_BUTTON}            id:finish

# Complete
${LOC_ORDER_COMPLETE_HEADER}    css:.complete-header
${LOC_ORDER_COMPLETE_TEXT}      css:.complete-text
${LOC_BACK_HOME_BUTTON}         id:back-to-products
