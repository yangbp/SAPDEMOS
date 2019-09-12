REPORT demo_show_ddl_source.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA name TYPE string.
    cl_demo_input=>request( EXPORTING text = `DDL Source`
                            CHANGING field = name ).
    TRY.
        cl_dd_ddl_handler_factory=>create( )->read(
              EXPORTING
                name         = CONV ddlname( to_upper( name ) )
              IMPORTING
                ddddlsrcv_wa = DATA(ddlsrcv_wa) ).
      CATCH cx_dd_ddl_read INTO DATA(exc).
        cl_demo_output=>display( exc->get_text( ) ).
    ENDTRY.
    IF ddlsrcv_wa-source IS INITIAL.
      cl_demo_output=>display( |Nothing found| ).
      RETURN.
    ENDIF.

    cl_demo_output=>display( replace( val = ddlsrcv_wa-source
                                      sub = |\r\n|
                                      with = |\n|
                                      occ = 0 ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
