REPORT demo_extract_cnt_sum.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

DATA: t1 TYPE c LENGTH 4,
      t2 TYPE i.

FIELD-GROUPS: header, test.

CLASS demo IMPLEMENTATION.
  METHOD main.

    INSERT t2 t1 INTO header.

    t1 ='AABB'. t2 = 1. EXTRACT test.
    t1 ='BBCC'. t2 = 2. EXTRACT test.
    t1 ='AAAA'. t2 = 2. EXTRACT test.
    t1 ='AABB'. t2 = 1. EXTRACT test.
    t1 ='BBBB'. t2 = 2. EXTRACT test.
    t1 ='BBCC'. t2 = 2. EXTRACT test.
    t1 ='AAAA'. t2 = 1. EXTRACT test.
    t1 ='BBBB'. t2 = 1. EXTRACT test.
    t1 ='AAAA'. t2 = 3. EXTRACT test.
    t1 ='AABB'. t2 = 1. EXTRACT test.

    SORT BY t1 t2.

    DATA(out) = cl_demo_output=>new( ).

    LOOP.

      out->write( |{ t1 } { t2 }| ).

      AT END OF t2.
        out->line( ).
        out->write( |Sum: { sum(t2) }| ).
        out->line( ).
      ENDAT.

      AT END OF t1.
        out->write( |Different values: { cnt(t1) }| ).
        out->line( ).
      ENDAT.

      AT LAST.
        out->line( ).
        out->write( |Sum: { sum(t2) }| ).
        out->write( |Different values: { cnt(t1) }| ).
      ENDAT.

    ENDLOOP.

    out->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
