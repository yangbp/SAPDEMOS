REPORT demo_for_groups_by_packages.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES
      i_tab TYPE STANDARD TABLE OF decfloat34 WITH EMPTY KEY.
    CLASS-DATA:
      itab TYPE i_tab,
      n    TYPE i VALUE 10,
      idx  TYPE i.
    CLASS-METHODS
      group RETURNING VALUE(group_key) TYPE i.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA out TYPE REF TO if_demo_output.

    cl_demo_input=>request( EXPORTING text  = `Package size`
                            CHANGING  field = n ).
    IF n <= 0.
      RETURN.
    ENDIF.

    out = REDUCE #(
      INIT o = cl_demo_output=>new(
                 )->begin_section( |Packages of { n }| )
      FOR GROUPS OF wa IN itab GROUP BY group( )
      LET group = VALUE i_tab( FOR <wa> IN GROUP wa ( <wa> ) ) IN
      NEXT o = o->write( group ) ).

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    itab = VALUE #( FOR j = 1 UNTIL j > 100 ( 1 / j ) ).
  ENDMETHOD.
  METHOD group.
    idx = idx + 1.
    group_key = ( idx - 1 ) DIV n + 1.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
