REPORT demo_cds_explicit_cardinality.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    SELECT *
           FROM demo_cds_explicit_cardinality
           INTO TABLE @DATA(itab).
    out->write( itab ).
    out->write( sy-dbcnt ).

    SELECT COUNT(*)
           FROM  demo_cds_explicit_cardinality
           INTO  @DATA(count).
    out->write( count ).
    out->write( sy-dbcnt ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
