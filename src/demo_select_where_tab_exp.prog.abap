REPORT demo_select_where_tab_exp.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA carriers TYPE HASHED TABLE OF scarr
                  WITH UNIQUE KEY carrid
                  WITH NON-UNIQUE SORTED KEY name COMPONENTS carrname.
    CLASS-METHODS:
      class_constructor,
      main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA name TYPE scarr-carrname VALUE 'United Airlines'.
    cl_demo_input=>request( CHANGING field = name ).

    SELECT carrid, connid, cityfrom, cityto
           FROM spfli
           WHERE carrid =
             @( VALUE spfli-carrid( carriers[ KEY name
                                              carrname = name ]-carrid
                                              OPTIONAL ) )
           INTO TABLE @DATA(result).

    cl_demo_output=>display( result ).
  ENDMETHOD.
  METHOD class_constructor.
    SELECT *
           FROM scarr
           INTO TABLE carriers.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
