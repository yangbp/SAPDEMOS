REPORT demo_for_groups_by_levels.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    TYPES: BEGIN OF line,
             col1 TYPE c LENGTH 1,
             col2 TYPE i,
             col3 TYPE i,
           END OF line,
           i_tab TYPE HASHED TABLE OF line
                 WITH UNIQUE KEY col1 col2.
    CLASS-METHODS sum IMPORTING line       TYPE line
                                base       TYPE line
                      RETURNING VALUE(sum) TYPE line.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA itab TYPE i_tab.

    itab = VALUE #(
      FOR j = 1 UNTIL j > 3
       ( col1 = 'A'
         col2 = j
         col3 = j ** 2 )
       ( col1 = 'B'
         col2 = 2 * j
         col3 = ( 2 * j ) ** 2 ) ).

    DATA(out) = cl_demo_output=>new( )->write( itab )->line( ).

    DATA(total) = REDUCE line(
      INIT t = VALUE line( )
      FOR GROUPS OF <line> IN itab GROUP BY <line>-col1 ASCENDING
      LET sum = REDUCE line( INIT s = VALUE line( )
                             FOR line IN GROUP <line>
                             NEXT s = sum( EXPORTING line = line
                                                     base = s ) )
          group = VALUE i_tab( FOR <wa> IN GROUP <line> ( <wa> ) )
          o = out->write( group )->line( )->write( sum )->line( ) IN
      NEXT t = sum( EXPORTING
                          line = VALUE line( BASE sum col1 = '*' )
                          base = t ) ).

    out->line( )->display( total ).
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
