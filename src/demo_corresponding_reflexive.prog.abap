REPORT demo_corresponding_reflexive.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES: BEGIN OF t_str1,
             a1 TYPE i,
             a2 TYPE i,
             a3 TYPE i,
             a4 TYPE i,
           END OF t_str1.

    TYPES: BEGIN OF t_str2,
             b1 TYPE i,
             b2 TYPE i,
             a1 TYPE i,
             a2 TYPE i,
           END OF t_str2.

    TYPES: BEGIN OF t_str3,
             a4 TYPE i,
             a3 TYPE i,
             a1 TYPE i,
             a2 TYPE i,
           END OF t_str3.

    DATA(out) = cl_demo_output=>new( ).

    out->begin_section( 'Reflexive Component Assignments' ).

    DATA(str1) = VALUE t_str1( a1 = 1 a2 = 2 a3 = 3 a4 = 4 ).
    DATA(back) = str1.
    out->write( str1 ).

    out->begin_section( 'MOVE-CORRESPONDING' ).

    FIELD-SYMBOLS <fs2> TYPE t_str2.
    ASSIGN str1 TO <fs2> CASTING.
    MOVE-CORRESPONDING str1 TO <fs2>.
    out->write( str1 ).

    str1 = back.
    ASSIGN str1 TO <fs2> CASTING.
    MOVE-CORRESPONDING <fs2> TO str1.
    out->write( str1 ).

    str1 = back.
    FIELD-SYMBOLS <fs3> TYPE t_str3.
    ASSIGN str1 TO <fs3> CASTING.
    MOVE-CORRESPONDING str1 TO <fs3>.
    out->write( str1 ).

    str1 = back.
    ASSIGN str1 TO <fs3> CASTING.
    MOVE-CORRESPONDING <fs3> TO str1.
    out->write( str1 ).

    out->next_section( 'CORRESPONDING' ).

    str1 = back.
    str1 = CORRESPONDING #(
             str1 MAPPING a1 = a4 a2 = a3 a3 = a1 a4 = a2 ) ##operator.
    out->write( str1 ).

    str1 = back.
    str1 = CORRESPONDING #(
             str1 MAPPING a1 = a3 a2 = a4 a3 = a2 a4 = a1 ) ##operator.
    out->write( str1 ).

    out->next_section( 'CL_ABAP_CORRESPONDING' ).

    str1 = back.
    cl_abap_corresponding=>create(
        source      = str1
        destination = str1
        mapping     = VALUE cl_abap_corresponding=>mapping_table(
          ( level = 0 kind = 1 srcname = 'a4' dstname = 'a1' )
          ( level = 0 kind = 1 srcname = 'a3' dstname = 'a2' )
          ( level = 0 kind = 1 srcname = 'a1' dstname = 'a3' )
          ( level = 0 kind = 1 srcname = 'a2' dstname = 'a4' ) )
        )->execute( EXPORTING source      = str1
                    CHANGING  destination = str1 ).
    out->write( str1 ).

    str1 = back.
    cl_abap_corresponding=>create(
        source      = str1
        destination = str1
        mapping     = VALUE cl_abap_corresponding=>mapping_table(
          ( level = 0 kind = 1 srcname = 'a3' dstname = 'a1' )
          ( level = 0 kind = 1 srcname = 'a4' dstname = 'a2' )
          ( level = 0 kind = 1 srcname = 'a2' dstname = 'a3' )
          ( level = 0 kind = 1 srcname = 'a1' dstname = 'a4' ) )
        )->execute( EXPORTING source      = str1
                    CHANGING  destination = str1 ).
    out->write( str1 ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
