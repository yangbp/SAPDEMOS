REPORT demo_db_reader.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    TYPES:
      pict_line TYPE x LENGTH 1022,
      pict_tab  TYPE STANDARD TABLE OF pict_line WITH EMPTY KEY.
    CLASS-DATA:
      name TYPE c LENGTH 255
           VALUE '/SAP/PUBLIC/BC/ABAP/mime_demo/ABAP_Docu_Logo.gif',
      pict TYPE pict_tab.
    CLASS-METHODS show_picture.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA reader TYPE REF TO cl_abap_db_x_reader.

    cl_demo_input=>request( CHANGING field = demo=>name ).

    SELECT SINGLE picture
           FROM demo_blob_table
           WHERE name = @name
           INTO @reader.

    IF sy-subrc <> 0.
      MESSAGE 'Nothing found, run DEMO_DB_WRITER first!'
              TYPE 'S' DISPLAY LIKE 'E'.
      RETURN.
    ENDIF.

    pict = VALUE #( FOR j = 1 WHILE reader->data_available( )
                    ( reader->read( 1022 ) ) ).

    reader->close( ).

    show_picture( ).

  ENDMETHOD.
  METHOD show_picture.
    DATA ext_data  TYPE cl_abap_browser=>load_tab.
    DATA(html_str) = `<html><body><img src="PICT.GIF" ></body></html>`.
    ext_data = VALUE #(
      ( name = 'PICT.GIF' type = 'image' dref = REF #( pict ) ) ).
    cl_abap_browser=>show_html(
      EXPORTING
        html_string = html_str
        format      = cl_abap_browser=>landscape
        size        = cl_abap_browser=>small
        data_table  = ext_data
        check_html  = ' ' ).
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  demo=>main( ).
