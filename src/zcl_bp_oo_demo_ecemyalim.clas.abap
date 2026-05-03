CLASS zcl_bp_oo_demo_ecemyalim DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_bp_oo_demo_ecemyalim IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "----------------------------------------------------------------------*
    " PART 1: INHERITANCE (Superclass → Customer & Vendor)
    "----------------------------------------------------------------------*
    out->write( |******************************************************| ).
    out->write( | PART 1: INHERITANCE | ).
    out->write( | Superclass: ZCL_BP_SUPER | ).
    out->write( | Children  : ZCL_CUST_CHILD / ZCL_VEND_CHILD | ).
    out->write( |******************************************************| ).
    out->write( | | ).

    " --- Create Parent (Business Partner) ---
    DATA(lo_bp) = NEW zcl_bp_super_ecemyalim(
      iv_bp_number = '00001'
      iv_name      = 'General Partner A.S.'
      iv_city      = 'Izmir'
      iv_country   = 'TR' ).

    out->write( |Instance of ZCL_BP_SUPER is created as LO_BP.| ).
    out->write( |Role of LO_BP is: { lo_bp->get_bp_role( ) }| ).
    out->write( | | ).

    " --- Create Customer (Child 1) ---
    DATA(lo_cust_child) = NEW zcl_cust_child_ecemyalim(
      iv_bp_number    = '00002'
      iv_name         = 'ABC Elektronik A.S.'
      iv_city         = 'Istanbul'
      iv_country      = 'TR'
      iv_customer_no  = '0000001000'
      iv_credit_limit = 50000
      iv_payment_term = '0001' ).

    out->write( |Instance of ZCL_CUST_CHILD is created as LO_CUST_CHILD.| ).
    out->write( |Role of LO_CUST_CHILD is: { lo_cust_child->get_bp_role( ) }| ).
    out->write( | | ).

    " --- Create Vendor (Child 2) ---
    DATA(lo_vend_child) = NEW zcl_vend_child_ecemyalim(
      iv_bp_number    = '00003'
      iv_name         = 'XYZ Malzeme Ltd.'
      iv_city         = 'Ankara'
      iv_country      = 'TR'
      iv_vendor_no    = '0000002000'
      iv_bank_key     = 'AKBANK001'
      iv_bank_account = 'TR12 0001 2345 6789' ).

    out->write( |Instance of ZCL_VEND_CHILD is created as LO_VEND_CHILD.| ).
    out->write( |Role of LO_VEND_CHILD is: { lo_vend_child->get_bp_role( ) }| ).
    out->write( | | ).

    " --- Polymorphism: Parent variable holds child objects ---
    DATA: lo_bp_poly TYPE REF TO zcl_bp_super_ecemyalim.

    out->write( |LO_BP_POLY has type ZCL_BP_SUPER.| ).
    out->write( | | ).

    lo_bp_poly = lo_cust_child.   " Parent variable ← Customer object
    out->write( |LO_BP_POLY is instantiated from child class ZCL_CUST_CHILD, child of ZCL_BP_SUPER.| ).
    out->write( | Polymorphism - Role: { lo_bp_poly->get_bp_role( ) }| ).  " Shows 'Customer'
    out->write( | | ).

    lo_bp_poly = lo_vend_child.   " Parent variable ← Vendor object
    out->write( |LO_BP_POLY is instantiated from child class ZCL_VEND_CHILD, child of ZCL_BP_SUPER.| ).
    out->write( | Polymorphism - Role: { lo_bp_poly->get_bp_role( ) }| ).  " Shows 'Vendor'
    out->write( | | ).

    "----------------------------------------------------------------------*
    " PART 2: INTERFACE (Domestic & International Customer)
    "----------------------------------------------------------------------*
    out->write( |******************************************************| ).
    out->write( | PART 2: INTERFACE                                   | ).
    out->write( | Interface: ZIF_CUST_INTF| ).
    out->write( | Class 1  : ZCL_CUST_CL1FR_IF (Domestic) | ).
    out->write( | Class 2  : ZCL_CUST_CL2FR_IF (International) | ).
    out->write( |******************************************************| ).
    out->write( | | ).

    " --- Create Domestic Customer ---
    DATA(lo_domestic) = NEW zcl_cust_cl1fr_if_ecemyalim(
      iv_customer_no  = '0000003000'
      iv_name         = 'Turk Ticaret A.S.'
      iv_credit_limit = 75000 ).

    out->write( | LO_DOMESTIC is instantiated from ZCL_CUST_CL1FR_IF as Domestic Customer.| ).
*    out->write( | Tax Amount for Base 1,000 is: { lo_domestic->zif_cust_intf_ecemyalim~calculate_tax( iv_amount = 1000 ) }.| ).
    out->write( | | ).

*  lo_domestic->zif_cust_intf_ecemyalim~display( ).

    " --- Create International Customer ---
    DATA(lo_international) = NEW zcl_cust_cl2fr_if_ecemyalim(
      iv_customer_no  = '0000004000'
      iv_name         = 'Berlin GmbH'
      iv_credit_limit = 120000
      iv_country      = 'DE' ).

    out->write( | LO_INTERNATIONAL is instantiated from ZCL_CUST_CL2FR_IF as International Customer.| ).
*    out->write( | Tax Amount for Base 1,000 is: { lo_international->zif_cust_intf_ecemyalim~calculate_tax( iv_amount = 1000 ) }.| ).
    out->write( | | ).

*  lo_international->zif_cust_intf_ecemyalim~display( ).

    " --- Polymorphism via Interface ---
    " Same interface variable → different behavior
    DATA: lo_if_cust TYPE REF TO zif_cust_intf_ecemyalim.

    " Test Credit Check with 60000 amount
    DATA: lv_amount TYPE i VALUE 60000.

    out->write( |--- Credit Check for amount: { lv_amount } ---| ).

    " Domestic Customer credit check
    lo_if_cust = lo_domestic.
    DATA(lv_ok_dom) = lo_if_cust->check_credit( lv_amount ).
    DATA(lv_tax_dom) = lo_if_cust->calculate_tax( lv_amount ).
    out->write( | LO_DOMESTIC Customer Name is: { lo_if_cust->get_name( ) }| ).
    out->write( |   Credit OK? : { COND string( WHEN lv_ok_dom = abap_true
                                               THEN 'YES'
                                               ELSE 'NO' ) }| ).
    out->write( |   Tax Amount : { lv_tax_dom }| ).
    out->write( | | ).

    " International Customer credit check
    lo_if_cust = lo_international.
    DATA(lv_ok_int) = lo_if_cust->check_credit( lv_amount ).
    DATA(lv_tax_int) = lo_if_cust->calculate_tax( lv_amount ).
    out->write( | LO_INTERNATIONAL Customer Name is: { lo_if_cust->get_name( ) }| ).
    out->write( |   Credit OK? : { COND string( WHEN lv_ok_int = abap_true
                                               THEN 'YES'
                                               ELSE 'NO' ) }| ).
    out->write( |   Tax Amount : { lv_tax_int }| ).
    out->write( | | ).

    "----------------------------------------------------------------------*
    " PART 3: ABSTRACT CLASS (BP Abstract → Customer & Vendor)
    "----------------------------------------------------------------------*
    out->write( |******************************************************| ).
    out->write( | PART 3: ABSTRACT CLASS                              | ).
    out->write( | Abstract : ZCL_BP_ABSTR | ).
    out->write( | Child 1  : ZCL_CUST_FR_ABSTR (Customer) | ).
    out->write( | Child 2  : ZCL_VEND_FR_ABSTR (Vendor) | ).
    out->write( |******************************************************| ).
    out->write( | | ).

    "CANNOT DO this — Abstract class!
    "DATA(lo_abstr) = NEW zcl_bp_abstr_ecemyalim( ... ). " SYNTAX ERROR!

    " --- Create Customer from Abstract ---
    DATA(lo_cust_abstr) = NEW zcl_cust_fr_abstr_ecemyalim(
      iv_bp_number    = '00005'
      iv_name         = 'DEF Bilisim A.S.'
      iv_city         = 'Bursa'
      iv_customer_no  = '0000005000'
      iv_credit_limit = 80000 ).

    out->write( | LO_CUST_ABSTR is instantiated from ZCL_CUST_FR_ABSTR as DEF Bilisim A.S..| ).
    out->write( | | ).

    " --- Create Vendor from Abstract ---
    DATA(lo_vend_abstr) = NEW zcl_vend_fr_abstr_ecemyalim(
      iv_bp_number    = '00006'
      iv_name         = 'GHI Tedarik Ltd.'
      iv_city         = 'Antalya'
      iv_vendor_no    = '0000006000'
      iv_bank_account = 'TR98 0006 7890 1234' ).

    out->write( | LO_VEND_ABSTR is instantiated from ZCL_VEND_FR_ABSTR as GHI Tedarik Ltd..| ).
    out->write( | | ).

    " --- Polymorphism via Abstract Parent ---
    " Abstract variable can hold any child object
    DATA: lo_abstr_poly TYPE REF TO zcl_bp_abstr_ecemyalim.

    out->write( | LO_ABSTR_POLY is a reference to Abstract Class ZCL_BP_ABSTR.| ).
    out->write( | | ).

    " Point to Customer
    lo_abstr_poly = lo_cust_abstr.
    out->write( |--- Abstract Polymorphism ---| ).
    out->write( | | ).
    out->write( | LO_ABSTR_POLY can take on LO_CUST_ABSTR.| ).
    out->write( | Name of LO_ABSTR_POLY: { lo_abstr_poly->get_name( ) }| ).
    out->write( | Role of LO_ABSTR_POLY: { lo_abstr_poly->get_role( ) }| ).   " Shows 'Customer'
    out->write( | | ).

    " Point to Vendor
    lo_abstr_poly = lo_vend_abstr.
    out->write( | LO_ABSTR_POLY can take on LO_CUST_ABSTR.| ).
    out->write( | Name of LO_ABSTR_POLY: { lo_abstr_poly->get_name( ) }| ).
    out->write( | Role of LO_ABSTR_POLY: { lo_abstr_poly->get_role( ) }| ).   " Shows 'Vendor'
    out->write( | | ).

    " --- Loop through table of abstract references ---
    DATA: lt_partners TYPE TABLE OF REF TO zcl_bp_abstr_ecemyalim.

    APPEND lo_cust_abstr TO lt_partners.
    APPEND lo_vend_abstr TO lt_partners.

    out->write( |--- Loop All Partners ---| ).
    out->write( | | ).

    LOOP AT lt_partners INTO DATA(lo_partner).
      out->write( | Partner{ sy-tabix }: { lo_partner->get_name( ) } - Role: { lo_partner->get_role( ) }| ).
      out->write( | | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
