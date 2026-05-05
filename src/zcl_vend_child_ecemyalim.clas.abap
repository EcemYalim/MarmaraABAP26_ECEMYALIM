CLASS zcl_vend_child_ecemyalim DEFINITION
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
                            iv_vendor_no    TYPE lifnr
                            iv_bank_key     TYPE string
                            iv_bank_account TYPE string,

      get_vendor_no RETURNING VALUE(rv_vendor) TYPE lifnr,
      get_bank_key RETURNING VALUE(rv_bank) TYPE string,
      get_bank_account RETURNING VALUE(rv_account) TYPE string,

      get_bp_role REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mv_vendor_no    TYPE lifnr,
          mv_bank_key     TYPE string,
          mv_bank_account TYPE string.
ENDCLASS.

CLASS zcl_vend_child_ecemyalim IMPLEMENTATION.
  METHOD constructor.
    super->constructor( iv_bp_number = iv_bp_number
                        iv_name      = iv_name
                        iv_city      = iv_city
                        iv_country   = iv_country ).
    mv_vendor_no    = iv_vendor_no.
    mv_bank_key     = iv_bank_key.
    mv_bank_account = iv_bank_account.
  ENDMETHOD.

  METHOD get_vendor_no.
    rv_vendor = mv_vendor_no.
  ENDMETHOD.

  METHOD get_bank_key.
    rv_bank = mv_bank_key.
  ENDMETHOD.

  METHOD get_bank_account.
    rv_account = mv_bank_account.
  ENDMETHOD.

  METHOD get_bp_role.
    rv_role = 'Vendor'.
  ENDMETHOD.

ENDCLASS.
