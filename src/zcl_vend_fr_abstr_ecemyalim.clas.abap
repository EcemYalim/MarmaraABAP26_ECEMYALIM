CLASS zcl_vend_fr_abstr_ecemyalim DEFINITION
  PUBLIC
  INHERITING FROM zcl_bp_abstr_ecemyalim
  FINAL
  CREATE PUBLIC .
  "MUST implement get_role( ) and display_specific_data( )

  PUBLIC SECTION.
    METHODS: constructor IMPORTING iv_bp_number    TYPE numc5
                                   iv_name         TYPE string
                                   iv_city         TYPE string
                                   iv_vendor_no    TYPE lifnr
                                   iv_bank_account TYPE string,

      get_vendor_no RETURNING VALUE(rv_vendor) TYPE lifnr,
      get_bank_account RETURNING VALUE(rv_account) TYPE string,

      " MUST implement these — otherwise syntax error!
      get_role REDEFINITION,
      display_specific_data REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mv_vendor_no    TYPE lifnr,
          mv_bank_account TYPE string.

ENDCLASS.


CLASS zcl_vend_fr_abstr_ecemyalim IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_bp_number = iv_bp_number
                        iv_name      = iv_name
                        iv_city      = iv_city ).
    mv_vendor_no    = iv_vendor_no.
    mv_bank_account = iv_bank_account.
  ENDMETHOD.

  METHOD get_vendor_no.
    rv_vendor = mv_vendor_no.
  ENDMETHOD.

  METHOD get_bank_account.
    rv_account = mv_bank_account.
  ENDMETHOD.

  METHOD get_role.
    rv_role = 'Vendor'.
  ENDMETHOD.

  METHOD display_specific_data.

  ENDMETHOD.

ENDCLASS.
