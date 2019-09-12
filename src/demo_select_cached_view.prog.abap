REPORT demo_select_cached_view.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).
    IF cl_db_sys=>is_in_memory_db = abap_false.
      out->display(
        `Example can be executed on SAP HANA Database only` ).
      RETURN.
    ENDIF.

    DATA reset TYPE abap_bool.
    cl_demo_input=>add_field( EXPORTING
                                text = 'Reset cache'
                                as_checkbox = abap_true
                              CHANGING
                                field = reset ).
    DATA minutes TYPE i VALUE 30.
    cl_demo_input=>request( EXPORTING
                              text = 'Maximal age in minutes'
                            CHANGING
                              field = minutes ).
    minutes = COND i( WHEN minutes < 1 OR minutes > 60 THEN 30
                      ELSE minutes ).

    IF reset = abap_true.
      TRY.
          NEW cl_sql_statement( )->execute_ddl(
            |alter view DEMOCDSCACH drop cache;| ).
        CATCH cx_sql_exception.
      ENDTRY.
      TRY.
          NEW cl_sql_statement( )->execute_ddl(
            |alter view DEMOCDSCACH add cache retention {
               minutes } of | &&
            |MANDT, CARRID, MAX(FLDATE), MIN(PRICE), SUM(SEATSOCC);| ).
        CATCH cx_sql_exception INTO DATA(exc).
          out->display( exc->get_text( ) ).
          RETURN.
      ENDTRY.
    ENDIF.

    DATA(extended_result) =
      NEW cl_osql_extended_result( iv_cached_view = abap_true ).
    SELECT carrid,
           MAX( fldate )   AS max_fldate ,
           MIN( price )    AS min_price,
           SUM( seatsocc ) AS sum_seatsocc
           FROM demo_cds_cached_view
           GROUP BY carrid
           %_HINTS HDB 'RESULT_CACHE'
           INTO TABLE @DATA(result)
           EXTENDED RESULT @extended_result.
    out->write( result
      )->write_html( `<b>Extended Result</b>` ).
    IF extended_result->cview_valid( ).
      out->display(
       | CVIEW_MAX_AGE: {
          extended_result->cview_max_age( ) } seconds\n| &&
       | CVIEW_LAST_REFRESH_TSTMPL: {
          extended_result->cview_last_refresh_tstmpl( )
            TIMESTAMP = ISO }\n| ).
    ELSE.
      out->display( `Invalid result` ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
