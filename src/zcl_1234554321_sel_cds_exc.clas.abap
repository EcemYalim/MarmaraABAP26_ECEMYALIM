CLASS zcl_1234554321_sel_cds_exc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_1234554321_sel_cds_exc IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: name TYPE /dmo/carrier_name.

    SELECT SINGLE FROM /dmo/i_carrier
      FIELDS name
      WHERE airlineid = 'SQ'
      INTO @name.

    out->write( |Carrier Name is: { name }| ).

  ENDMETHOD.

ENDCLASS.
