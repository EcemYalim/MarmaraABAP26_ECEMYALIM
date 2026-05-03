CLASS zcl_cust_child_ecemyalim DEFINITION
  PUBLIC
  INHERITING FROM zcl_bp_super_ecemyalim
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_bp_number    TYPE numc5
                            iv_name         TYPE string
                            iv_city         TYPE string
                            iv_country      TYPE land1
                            iv_customer_no  TYPE kunnr
                            iv_credit_limit TYPE i
                            iv_payment_term TYPE dzterm,

      get_customer_no RETURNING VALUE(rv_cust) TYPE kunnr,
      get_credit_limit RETURNING VALUE(rv_limit) TYPE i,
      get_payment_term RETURNING VALUE(rv_term) TYPE dzterm,

      get_bp_role REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mv_customer_no  TYPE kunnr,
          mv_credit_limit TYPE p DECIMALS 2,
          mv_payment_term TYPE dzterm.

ENDCLASS.



CLASS zcl_cust_child_ecemyalim IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_bp_number = iv_bp_number
                        iv_name      = iv_name
                        iv_city      = iv_city
                        iv_country   = iv_country ).
    mv_customer_no  = iv_customer_no.
    mv_credit_limit = iv_credit_limit.
    mv_payment_term = iv_payment_term.
  ENDMETHOD.

  METHOD get_customer_no.
    rv_cust = mv_customer_no.
  ENDMETHOD.

  METHOD get_credit_limit.
    rv_limit = mv_credit_limit.
  ENDMETHOD.

  METHOD get_payment_term.
    rv_term = mv_payment_term.
  ENDMETHOD.

  METHOD get_bp_role.
    rv_role = 'Customer'.
  ENDMETHOD.

ENDCLASS.
