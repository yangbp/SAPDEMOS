REPORT demo_create_data_implicit.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES t_itab TYPE TABLE OF i WITH NON-UNIQUE KEY table_line.

    DATA: tab_ref TYPE REF TO t_itab,
          i_ref   TYPE REF TO i.

    IF tab_ref IS INITIAL.
      CREATE DATA tab_ref.
    ENDIF.

    tab_ref->* = VALUE #( FOR j = 1 UNTIL j > 10 ( j ) ).

    IF tab_ref IS NOT INITIAL.
      IF i_ref IS INITIAL.
        CREATE DATA i_ref.
      ENDIF.
      LOOP AT tab_ref->* INTO i_ref->*.
        cl_demo_output=>write( |{ i_ref->* }| ).
      ENDLOOP.
    ENDIF.
    cl_demo_output=>display( ).

    CLEAR: tab_ref, i_ref.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
