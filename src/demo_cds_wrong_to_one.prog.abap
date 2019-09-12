REPORT demo_cds_wrong_to_one.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    out->next_section( `Fields of left and right table` ).
    SELECT FROM demo_cds_wrong_to_one_1
           FIELDS *
           ORDER BY carrid
           INTO TABLE @DATA(itab).
    out->write( itab ).
    out->write( sy-dbcnt ).

    out->next_section( `Fields of left table only` ).
    SELECT FROM demo_cds_wrong_to_one_2
           FIELDS *
           ORDER BY carrid
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    out->write( itab ).
    out->write( sy-dbcnt ).

    out->next_section( `COUNT(*)` ).
    SELECT SINGLE
           FROM demo_cds_wrong_to_one_3
           FIELDS *
           INTO @DATA(count).
    out->write( count ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
