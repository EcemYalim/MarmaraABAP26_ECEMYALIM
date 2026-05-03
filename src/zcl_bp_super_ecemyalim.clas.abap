CLASS zcl_bp_super_ecemyalim DEFINITION
  PUBLIC.
*  FINAL
*  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    METHODS:
      constructor IMPORTING iv_bp_number TYPE numc5
                            iv_name      TYPE string
                            iv_city      TYPE string
                            iv_country   TYPE land1,

      get_bp_number RETURNING VALUE(rv_bp) TYPE numc5,
      get_name RETURNING VALUE(rv_name) TYPE string,
      get_city RETURNING VALUE(rv_city) TYPE string,
      get_country RETURNING VALUE(rv_country) TYPE land1,
      get_bp_role RETURNING VALUE(rv_role) TYPE string.

  PROTECTED SECTION.
    DATA: mv_bp_number TYPE numc5,
          mv_name      TYPE string,
          mv_city      TYPE string,
          mv_country   TYPE land1.

  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_bp_super_ecemyalim IMPLEMENTATION.
  METHOD constructor.
    mv_bp_number = iv_bp_number.
    mv_name      = iv_name.
    mv_city      = iv_city.
    mv_country   = iv_country.
  ENDMETHOD.

  METHOD get_bp_number.
    rv_bp = mv_bp_number.
  ENDMETHOD.

  METHOD get_name.
    rv_name = mv_name.
  ENDMETHOD.

  METHOD get_city.
    rv_city = mv_city.
  ENDMETHOD.

  METHOD get_country.
    rv_country = mv_country.
  ENDMETHOD.

  METHOD get_bp_role.
    rv_role = 'General BP'.
  ENDMETHOD.

ENDCLASS.
