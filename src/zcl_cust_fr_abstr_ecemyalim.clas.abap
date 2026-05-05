CLASS zcl_cust_fr_abstr_ecemyalim DEFINITION
  PUBLIC
  INHERITING FROM zcl_bp_abstr_ecemyalim
  FINAL
  CREATE PUBLIC .
  "MUST implement get_role( ) and display_specific_data( )

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_bp_number    TYPE numc5
                            iv_name         TYPE string
                            iv_city         TYPE string
                            iv_customer_no  TYPE kunnr
                            iv_credit_limit TYPE p,

      get_customer_no RETURNING VALUE(rv_cust) TYPE kunnr,
      get_credit_limit RETURNING VALUE(rv_limit) TYPE i,

      " MUST implement these — otherwise syntax error!
      get_role REDEFINITION,
      display_specific_data REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mv_customer_no  TYPE kunnr,
          mv_credit_limit TYPE i.

ENDCLASS.

CLASS zcl_cust_fr_abstr_ecemyalim IMPLEMENTATION.
  METHOD constructor.
    super->constructor( iv_bp_number = iv_bp_number
                        iv_name      = iv_name
                        iv_city      = iv_city ).
    mv_customer_no  = iv_customer_no.
    mv_credit_limit = iv_credit_limit.
  ENDMETHOD.

  METHOD get_customer_no.
    rv_cust = mv_customer_no.
  ENDMETHOD.

  METHOD get_credit_limit.
    rv_limit = mv_credit_limit.
  ENDMETHOD.

  METHOD get_role.
    rv_role = 'Customer'.
  ENDMETHOD.

  METHOD display_specific_data.

  ENDMETHOD.

ENDCLASS.
