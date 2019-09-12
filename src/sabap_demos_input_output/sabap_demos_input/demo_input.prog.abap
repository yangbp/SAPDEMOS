REPORT demo_input.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA carrid TYPE spfli-carrid VALUE 'LH'.

    cl_demo_input=>request( CHANGING field = carrid ).

    DATA itab TYPE TABLE OF spfli.
    SELECT *
           FROM spfli
           INTO TABLE itab
           WHERE carrid = carrid.

    cl_demo_output=>display( itab ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
