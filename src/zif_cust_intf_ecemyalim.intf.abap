INTERFACE zif_cust_intf_ecemyalim
  PUBLIC .
  "Defines WHAT every customer class must be able to do
  METHODS:
    get_customer_no RETURNING VALUE(rv_cust) TYPE kunnr,

    get_name RETURNING VALUE(rv_name) TYPE string,

    get_credit_limit RETURNING VALUE(rv_limit) TYPE i,

    check_credit IMPORTING iv_order_amount TYPE i
                 RETURNING VALUE(rv_ok)    TYPE abap_bool,

    calculate_tax IMPORTING iv_amount     TYPE i
                  RETURNING VALUE(rv_tax) TYPE i.

ENDINTERFACE.
