REPORT demo_adbc_query.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA: BEGIN OF result_line,
                  carrid TYPE sflight-carrid,
                  connid TYPE sflight-connid,
                  fldate TYPE sflight-fldate,
                END OF result_line,
                result_tab LIKE TABLE OF result_line.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA carrid TYPE sflight-carrid.
    DATA cols TYPE adbc_column_tab.
    cols = VALUE #( ( CONV adbc_name( 'CARRID' ) )
                    ( CONV adbc_name( 'CONNID' ) )
                    ( CONV adbc_name( 'FLDATE' ) ) ).
    cl_demo_input=>request( CHANGING field = carrid ).
    TRY.
        DATA(result) = NEW cl_sql_statement( )->execute_query(
         `SELECT carrid, connid, fldate ` &&
         `FROM sflight ` &&
         `WHERE mandt  = ` && `'` && sy-mandt && `' AND` &&
         `      carrid = ` &&  cl_abap_dyn_prg=>quote(
                                 to_upper( carrid ) ) ).
        result->set_param_table( itab_ref = REF #( result_tab )
                                 corresponding_fields = cols ).
        IF result->next_package( ) > 0.
          SORT result_tab BY carrid connid fldate.
          cl_demo_output=>display( result_tab ).
        ENDIF.
      CATCH cx_sql_exception INTO DATA(err).
        cl_demo_output=>display(  err->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
