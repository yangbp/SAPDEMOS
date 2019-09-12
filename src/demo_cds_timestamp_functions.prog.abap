REPORT demo_cds_timestamp_functions.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(seconds) = 3600.
    cl_demo_input=>add_field( CHANGING field = seconds ).
    DATA(wait) = 1.
    cl_demo_input=>request( CHANGING field = wait ).

    GET TIME STAMP FIELD DATA(timestamp1).

    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM @( VALUE #(
      id      = 'X'
     	num1    = seconds
      timestamp1 = timestamp1 ) ).
    WAIT UP TO COND #( WHEN wait > 10 THEN 10
                       WHEN wait <  0 THEN 0
                       ELSE wait ) SECONDS.
    TRY.
        SELECT SINGLE *
               FROM demo_cds_timestamp_functions
               INTO @DATA(result).
      CATCH cx_sy_open_sql_db INTO DATA(exc).
        cl_demo_output=>display( exc->get_text( ) ).
        RETURN.
    ENDTRY.

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
