REPORT demo_cds_semantics_annotation.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA incomplete_addresses TYPE STANDARD TABLE
                              OF demo_cds_semantics_annotation
                              WITH EMPTY KEY.

    cl_dd_ddl_annotation_service=>get_drct_annos_4_entity_elmnts(
      EXPORTING
        entityname =     'DEMO_CDS_SEMANTICS_ANNOTATION'
      IMPORTING
        annos      =     DATA(elementannos) ).

    TYPES element_anno LIKE LINE OF elementannos.
    DATA address_annos TYPE STANDARD TABLE OF element_anno-annoname
                            WITH EMPTY KEY.
    address_annos = VALUE #(
      ( 'SEMANTICS.NAME.FULLNAME' )
      ( 'SEMANTICS.ADDRESS.STREET' )
      ( 'SEMANTICS.ADDRESS.CITY' )
      ( 'SEMANTICS.ADDRESS.ZIPCODE' )
      ( 'SEMANTICS.ADDRESS.COUNTRY' ) ).

    DATA address_components TYPE TABLE OF element_anno-elementname
                                 WITH EMPTY KEY.
    address_components = VALUE #(
      FOR address_anno IN address_annos
      ( VALUE #( elementannos[ annoname = address_anno ]-elementname
                 DEFAULT '---' ) ) ).

    SELECT *
           FROM demo_cds_semantics_annotation
           INTO @DATA(address).
      LOOP AT address_components INTO DATA(component).
        ASSIGN COMPONENT component OF STRUCTURE address
                                   TO FIELD-SYMBOL(<value>).
        IF sy-subrc <> 0 OR <value> IS INITIAL.
          incomplete_addresses = VALUE #( BASE incomplete_addresses
                                          ( address ) ).
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDSELECT.

    cl_demo_output=>display( incomplete_addresses ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
