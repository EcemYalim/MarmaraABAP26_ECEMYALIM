CLASS zcl_1234554321_select_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS: get_result_from_table IMPORTING carrier_id      TYPE /dmo/carrier_id
                                             connection_id   TYPE /dmo/connection_id
                                   EXPORTING airport_from_id TYPE /dmo/airport_from_id
                                             airport_to_id   TYPE /dmo/airport_to_id
                                   RAISING   cx_abap_invalid_value.
ENDCLASS.

CLASS zcl_1234554321_select_table IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA airport_from_id TYPE /DMO/airport_from_id.
    DATA airport_to_id   TYPE /DMO/airport_to_id.

    DATA airports TYPE TABLE OF /DMO/airport_from_id.

* Example 1: Single field from Single Record
**********************************************************************
    SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id
      WHERE carrier_id    = 'LH'
        AND connection_id = '0400'
        INTO @airport_from_id.

    out->write( '----------'  ).
    out->write( 'Example 1:'  ).

    out->write( |Flight LH 400 departs from {  airport_from_id }.| ).

* Example 2: Multiple Fields from Single Record
**********************************************************************
    SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id, airport_to_id
      WHERE carrier_id    = 'LH'
        AND connection_id = '0400'
        INTO (  @airport_from_id, @airport_to_id ).

    out->write( '----------'  ).
    out->write( 'Example 2:'  ).

    out->write( |Flight LH 400 flies from {  airport_from_id } to { airport_to_id  }| ).

* Example 3: Empty Result and sy-subrc
**********************************************************************
    SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id
      WHERE carrier_id    = 'XX'
        AND connection_id = '1234'
        INTO @airport_from_id.

    IF sy-subrc = 0.

      out->write( '----------'  ).
      out->write( 'Example 3:'  ).
      out->write( |Flight XX 1234 departs from {  airport_from_id }.| ).

    ELSE.

      out->write( '----------'  ).
      out->write( 'Example 3:'  ).
      out->write( |There is no flight XX 1234, but still airport_from_id = {  airport_from_id }!| ).

    ENDIF.

*    DATA carrier_id    TYPE /dmo/carrier_id.
*    DATA connection_id TYPE /dmo/connection_id.
*
*    DATA airport_from_id TYPE /dmo/airport_from_id.
*    DATA airport_to_id   TYPE /dmo/airport_to_id.
**    DATA carrier_name    TYPE /dmo/carrier_name.
*
*    carrier_id    = 'XX'.
**    carrier_id    = 'UA'.
*    connection_id = '059'.
*
*    TRY.
*
*        get_result_from_table( EXPORTING carrier_id = carrier_id
*                                         connection_id = connection_id
*                               IMPORTING airport_from_id = airport_from_id
*                                         airport_to_id   = airport_to_id ).
*
*        out->write( |Airport From ID is: { airport_from_id } & Airport To ID is: { airport_to_id }| ).
*
*        out->write( |Airport From ID is: { airport_from_id } & Airport To ID is: { airport_to_id } & Carrier Name is: { carrier_name }| ).
*
*      CATCH cx_abap_invalid_value.
*
*        out->write( 'Selection Returned no results!' ).
*
*    ENDTRY.

  ENDMETHOD.

  METHOD get_result_from_table.

    SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id, airport_to_id
      WHERE carrier_id = @carrier_id
        AND connection_id = @connection_id
      INTO ( @airport_from_id, @airport_to_id ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
