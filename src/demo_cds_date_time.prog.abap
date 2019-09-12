REPORT demo_cds_date_time.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM @( VALUE #( id = 'X'
                                             dats1 = sy-datum
                                             tims1 = sy-uzeit ) ).

    SELECT SINGLE *
           FROM demo_cds_date_time
           INTO @DATA(result).

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
