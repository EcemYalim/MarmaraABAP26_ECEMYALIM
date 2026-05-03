CLASS zcl_cust_cl1fr_if_ecemyalim DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_cust_intf_ecemyalim .
    METHODS: constructor IMPORTING iv_customer_no  TYPE kunnr
                                   iv_name         TYPE string
                                   iv_credit_limit TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mv_customer_no  TYPE kunnr,
          mv_name         TYPE string,
          mv_credit_limit TYPE i.

ENDCLASS.


CLASS zcl_cust_cl1fr_if_ecemyalim IMPLEMENTATION.

  METHOD constructor.
    mv_customer_no  = iv_customer_no.
    mv_name         = iv_name.
    mv_credit_limit = iv_credit_limit.
  ENDMETHOD.

  METHOD zif_cust_intf_ecemyalim~calculate_tax.
    " Domestic Türkiye: 18% KDV
    rv_tax = iv_amount * 18 / 100.
  ENDMETHOD.

  METHOD zif_cust_intf_ecemyalim~check_credit.
    " Domestic: simple check — order must be under limit
    IF iv_order_amount <= mv_credit_limit.
      rv_ok = abap_true.
    ELSE.
      rv_ok = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD zif_cust_intf_ecemyalim~get_credit_limit.
    rv_limit = mv_credit_limit.
  ENDMETHOD.

  METHOD zif_cust_intf_ecemyalim~get_customer_no.
    rv_cust = mv_customer_no.
  ENDMETHOD.

  METHOD zif_cust_intf_ecemyalim~get_name.
    rv_name = mv_name.
  ENDMETHOD.

ENDCLASS.
