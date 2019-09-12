REPORT demo_loop_group_by_packages.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    CLASS-DATA
      itab TYPE TABLE OF decfloat34 WITH EMPTY KEY.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA(n) = 10.
    cl_demo_input=>request( EXPORTING text  = `Package size`
                            CHANGING  field = n ).
    IF n <= 0.
      RETURN.
    ENDIF.

    cl_demo_output=>begin_section( |Packages of { n }| ).
    DATA group LIKE itab.
    LOOP AT itab INTO DATA(wa)
         GROUP BY ( sy-tabix - 1 ) DIV n + 1.
      CLEAR group.
      LOOP AT GROUP wa ASSIGNING FIELD-SYMBOL(<wa>).
        group = VALUE #( BASE group ( <wa> ) ).
      ENDLOOP.
      cl_demo_output=>write( group ).
    ENDLOOP.

    cl_demo_output=>display( ).
  ENDMETHOD.
  METHOD class_constructor.
    itab = VALUE #( FOR j = 1 UNTIL j > 100 ( 1 / j ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
