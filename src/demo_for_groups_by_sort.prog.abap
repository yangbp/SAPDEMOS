REPORT demo_for_groups_by_sort.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES itab TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    DATA(itab) =
      VALUE itab( ( `d` ) ( `B` ) ( `D` ) ( `b` ) ( `a` )
                  ( `D` ) ( `a` ) ( `C` ) ( `A` ) ( `c` ) ).
    cl_demo_output=>write( itab ).

    DATA jtab TYPE itab.
    jtab = VALUE #( FOR GROUPS <grp1> OF <line> IN itab
                        GROUP BY to_upper( <line> ) ASCENDING
                    FOR GROUPS <grp2> OF <mbr1> IN GROUP <grp1>
                        GROUP BY <mbr1> DESCENDING
                    FOR <mbr2> IN GROUP <grp2> ( <mbr2> ) ).
    cl_demo_output=>display( jtab ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
