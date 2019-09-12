REPORT demo_cds_unit_conversion.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA values TYPE SORTED TABLE OF demo_expressions
                WITH UNIQUE KEY id.
    CLASS-METHODS setup.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    DATA to_unit TYPE c LENGTH 3 VALUE 'KM'.
    cl_demo_input=>request( CHANGING field = to_unit ).
    to_unit = to_upper( to_unit ).
    setup( ).

    TRY.
        SELECT *
               FROM demo_cds_unit_conversion( to_unit = @to_unit )
               ORDER BY id
               INTO TABLE @DATA(cds_result).
        out->write( cds_result ).
      CATCH cx_sy_open_sql_db INTO DATA(exc).
        out->write( exc->get_text( ) ).
    ENDTRY.

    DATA abap_result LIKE cds_result.
    abap_result =
      CORRESPONDING #( values MAPPING original_value = dec3 ).
    LOOP AT abap_result ASSIGNING FIELD-SYMBOL(<result>).
      <result>-original_unit  = 'MI'.
      <result>-converted_unit = to_unit.
      CALL FUNCTION 'UNIT_CONVERSION_SIMPLE'
        EXPORTING
          input    = <result>-original_value
          unit_in  = 'MI'
          unit_out = to_unit
        IMPORTING
          output   = <result>-converted_value
        EXCEPTIONS
          OTHERS   = 4.
      IF sy-subrc <> 0.
        out->write( 'Error in function module' ).
      ENDIF.
    ENDLOOP.
    out->write( abap_result ).

    out->display( ).
  ENDMETHOD.
  METHOD setup.
    values = VALUE #(
      ( id = 1 dec3 = '1.000'  )
      ( id = 2 dec3 = '20.000'  )
      ( id = 3 dec3 = '300.000'  )
      ( id = 4 dec3 = '4000.000'  ) ).
    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM TABLE values.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
