REPORT demo_cds_system_fields.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM @( VALUE #( id = '1' ) ).
    SELECT *
           FROM demo_cds_system_fields( p_datum  = @sy-datum,
                                        p_uzeit  = @sy-uzeit,
                                        p_langu  = @sy-langu,
                                        p_uname  = @sy-uname )
           INTO TABLE @DATA(result).
    SELECT *
           FROM demo_cds_system_fields(  )
           APPENDING TABLE @result.
    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
