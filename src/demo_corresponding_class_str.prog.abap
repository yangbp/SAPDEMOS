REPORT demo_corresponding_class_str.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      BEGIN OF struct1,
        a1 TYPE string VALUE 'a1',
        a2 TYPE string VALUE 'a2',
        a3 TYPE string VALUE 'a3',
        a4 TYPE string VALUE 'a4',
        a5 TYPE string VALUE 'a5',
        BEGIN OF asub1,
          s1_a1 TYPE string VALUE 's1_a1',
          s1_a2 TYPE string VALUE 's1_a2',
          s1_a3 TYPE string VALUE 's1_a3',
          BEGIN OF asub2,
            s2_a1 TYPE string VALUE 's2_a1',
            s2_a2 TYPE string VALUE 's2_a2',
            s2_a3 TYPE string VALUE 's2_a3',
          END OF asub2,
        END OF asub1,
      END OF struct1,
      BEGIN OF struct2,
        b1 TYPE string VALUE 'b1',
        b2 TYPE string VALUE 'b2',
        b3 TYPE string VALUE 'b3',
        a4 TYPE string VALUE 'b4',
        a5 TYPE string VALUE 'b5',
        BEGIN OF bsub1,
          s1_b1 TYPE string VALUE 's1_b1',
          s1_b2 TYPE string VALUE 's1_b2',
          s1_b3 TYPE string VALUE 's1_b3',
          BEGIN OF bsub2,
            s2_b1 TYPE string VALUE 's2_b1',
            s2_b2 TYPE string VALUE 's2_b2',
            s2_b3 TYPE string VALUE 's2_b3',
          END OF bsub2,
        END OF bsub1,
      END OF struct2.

    DATA(mapping_tab) = VALUE cl_abap_corresponding=>mapping_table(
    ( level = 0 kind = 1 srcname = 'a1' dstname = 'b3' )
    ( level = 0 kind = 1 srcname = 'a3' dstname = 'b1' )
    ( level = 0 kind = 2 srcname = 'a5' )
    ( level = 0 kind = 1 srcname = 'asub1' dstname = 'bsub1' )
    ( level = 1 kind = 1 srcname = 's1_a1' dstname = 's1_b3' )
    ( level = 1 kind = 1 srcname = 's1_a3' dstname = 's1_b1' )
    ( level = 1 kind = 1 srcname = 'asub2' dstname = 'bsub2' )
    ( level = 2 kind = 1 srcname = 's2_a1' dstname = 's2_b3' )
    ( level = 2 kind = 1 srcname = 's2_a3' dstname = 's2_b1' ) ).

    cl_abap_corresponding=>create(
      source            = struct1
      destination       = struct2
      mapping           = mapping_tab
      )->execute( EXPORTING source      = struct1
                  CHANGING  destination = struct2 ).

    cl_demo_output=>new(
      )->write( struct2-b1
      )->write( struct2-b2
      )->write( struct2-b3
      )->write( struct2-a4
      )->write( struct2-a5
      )->write( struct2-bsub1-s1_b1
      )->write( struct2-bsub1-s1_b2
      )->write( struct2-bsub1-s1_b3
      )->write( struct2-bsub1-bsub2-s2_b1
      )->write( struct2-bsub1-bsub2-s2_b2
      )->write( struct2-bsub1-bsub2-s2_b3
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
