REPORT demo_adbc_prepared_statement.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA: BEGIN OF result_line,
                  carrid TYPE sflight-carrid,
                  connid TYPE sflight-connid,
                END OF result_line,
                result_tab LIKE TABLE OF result_line.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:  sql        TYPE REF TO cl_sql_prepared_statement,
           cols       TYPE adbc_column_tab,
           carrid     TYPE sflight-carrid,
           carrid_tab TYPE TABLE OF sflight-carrid.
    cols = VALUE #( ( CONV adbc_name( 'CARRID' ) )
                    ( CONV adbc_name( 'CONNID' ) ) ).
    carrid_tab = VALUE #( ( CONV s_carrid( 'AA' ) )
                          ( CONV s_carrid( 'LH' ) )
                          ( CONV s_carrid( 'UA' ) ) ).
    TRY.
        sql = NEW #( `SELECT carrid, connid `      &&
                     `FROM spfli `                 &&
                     `WHERE mandt = '` && sy-mandt &&
                     `' AND carrid = ?` ).
        sql->set_param( REF #( carrid ) ).
        LOOP AT carrid_tab INTO carrid.
          DATA(result) = sql->execute_query( ).
          result->set_param_struct( struct_ref = REF #( result_line )
                                    corresponding_fields = cols ).
          result_tab = VALUE #( BASE result_tab
                                FOR j = 1 WHILE result->next( ) > 0
                                ( result_line ) ).
        ENDLOOP.
        sql->close( ).
        cl_demo_output=>display( result_tab ).
      CATCH cx_sql_exception INTO DATA(err).
        cl_demo_output=>display( err->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
