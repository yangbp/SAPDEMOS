REPORT demo_extract_at_new.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

DATA: t1 TYPE c LENGTH 4,
      t2 TYPE i.

FIELD-GROUPS header.

CLASS demo IMPLEMENTATION.
  METHOD main.

    INSERT t2 t1 INTO header.

    t1 ='AABB'. t2 = 1. EXTRACT header.
    t1 ='BBCC'. t2 = 2. EXTRACT header.
    t1 ='AAAA'. t2 = 2. EXTRACT header.
    t1 ='AABB'. t2 = 1. EXTRACT header.
    t1 ='BBBB'. t2 = 2. EXTRACT header.
    t1 ='BBCC'. t2 = 2. EXTRACT header.
    t1 ='AAAA'. t2 = 1. EXTRACT header.
    t1 ='BBBB'. t2 = 1. EXTRACT header.
    t1 ='AAAA'. t2 = 3. EXTRACT header.
    t1 ='AABB'. t2 = 1. EXTRACT header.

    SORT BY t1 t2.

    DATA(out) = cl_demo_output=>new( ).

    LOOP.

      AT FIRST.
        out->write( 'Start of LOOP' ).
        out->line( ).
      ENDAT.

      AT NEW t1.
        out->write( 'New T1' ).
      ENDAT.

      AT NEW t2.
        out->write( 'New T2' ).
      ENDAT.

      out->write( |{ t1 } { t2 }| ).

      AT END OF t2.
        out->write( 'End of T2' ).
      ENDAT.

      AT END OF t1.
        out->write( 'End of T1' ).
      ENDAT.

      AT LAST.
        out->line( ).
      ENDAT.

    ENDLOOP.

    out->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
