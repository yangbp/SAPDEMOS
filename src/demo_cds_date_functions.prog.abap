REPORT demo_cds_date_functions.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(in) = cl_demo_input=>new( ).
    DATA(date1) = CONV d( sy-datlo + 0 ).
    in->add_field( CHANGING field = date1 ).
    DATA(date2) = CONV d( sy-datlo + 10 ).
    in->add_field( CHANGING field = date2 ).
    DATA days TYPE i.
    in->add_field( CHANGING field = days ).
    DATA months TYPE i.
    in->add_field( CHANGING field = months )->request( ).

    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM @( VALUE #( id    = 'X'
                                             dats1 = date1
                                             dats2 = date2 ) ).

    TRY.
        SELECT SINGLE *
               FROM demo_cds_date_functions( p_days   = @days,
                                             p_months = @months )
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
