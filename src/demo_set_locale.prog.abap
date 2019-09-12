REPORT demo_set_locale.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA text_tab TYPE HASHED TABLE OF string
                       WITH UNIQUE KEY table_line.

    text_tab = VALUE #(
      ( `Cudar Vilmos`  )
      ( `Csernus Gábor` ) ).

    SET LOCALE LANGUAGE 'E'.
    SORT text_tab AS TEXT.
    cl_demo_output=>write( text_tab ).

    SET LOCALE LANGUAGE 'H'.
    SORT text_tab AS TEXT.
    cl_demo_output=>write( text_tab ).

    SET LOCALE LANGUAGE ' '.
    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
