REPORT demo_cds_session_variables.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA using_client TYPE abap_bool.
    cl_demo_input=>request( EXPORTING as_checkbox = 'X'
                            CHANGING  field = using_client ).

    IF using_client IS INITIAL.
      DELETE FROM demo_expressions.
      INSERT demo_expressions FROM @( VALUE #( id = 'X' ) ).
      SELECT *
             FROM demo_cds_session_variables
             WHERE id = 'X'
             INTO TABLE @DATA(result).
    ELSE.
      SELECT mandt
             FROM t000
             WHERE mandt <> @sy-mandt
             ORDER BY mandt
             INTO (@DATA(clnt))
             UP TO 1 ROWS.
      ENDSELECT.
      IF sy-subrc <> 0.
        cl_demo_output=>display( 'No other client available' ).
        RETURN.
      ENDIF.
      DELETE FROM demo_expressions USING CLIENT @clnt.
      INSERT demo_expressions USING CLIENT @clnt FROM @( VALUE #( id = 'X' ) ).
      SELECT *
             FROM demo_cds_session_variables USING CLIENT @clnt
             WHERE id = 'X'
             INTO TABLE @result.
    ENDIF.

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
