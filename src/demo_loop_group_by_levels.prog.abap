REPORT demo_loop_group_by_levels.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    TYPES: BEGIN OF line,
             col1 TYPE c LENGTH 1,
             col2 TYPE i,
             col3 TYPE i,
           END OF line.
    CLASS-METHODS sum IMPORTING line       TYPE line
                                base       TYPE line
                      RETURNING VALUE(sum) TYPE line.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA itab TYPE HASHED TABLE OF line
              WITH UNIQUE KEY col1 col2.

    DATA(out) = cl_demo_output=>new( ).

    itab = VALUE #(
      FOR j = 1 UNTIL j > 3
       ( col1 = 'A'
         col2 = j
         col3 = j ** 2 )
       ( col1 = 'B'
         col2 = 2 * j
         col3 = ( 2 * j ) ** 2 ) ).

    out->write( itab )->line( ).

    DATA sum   TYPE line.
    DATA total TYPE line.
    DATA group LIKE itab.
    LOOP AT itab ASSIGNING FIELD-SYMBOL(<line>)
                 GROUP BY <line>-col1 ASCENDING.
      CLEAR sum.
      CLEAR group.
      LOOP AT GROUP <line> INTO DATA(line).
        group = VALUE #( BASE group ( line ) ).
        sum = sum( EXPORTING line = line
                             base = sum ).
      ENDLOOP.
      out->write( group )->line( )->write( sum )->line( ).
      total = sum( EXPORTING line = sum
                             base = total ).
    ENDLOOP.
    total-col1 = '*'.
    out->line( )->write( total )->display( ).
  ENDMETHOD.
  METHOD sum.
    sum = VALUE #( BASE base
                   col1 = line-col1
                   col2 = sum-col2 + line-col2
                   col3 = sum-col3 + line-col3 ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
