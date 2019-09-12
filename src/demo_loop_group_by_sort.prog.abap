REPORT demo_loop_group_by_sort.

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
    LOOP AT itab ASSIGNING FIELD-SYMBOL(<line>)
                 GROUP BY to_upper( <line> ) ASCENDING
                 ASSIGNING FIELD-SYMBOL(<grp1>).
      LOOP AT GROUP <grp1> ASSIGNING FIELD-SYMBOL(<mbr1>)
              GROUP BY <mbr1> DESCENDING
              ASSIGNING FIELD-SYMBOL(<grp2>).
           jtab = VALUE #( BASE jtab
                           FOR <mbr2> IN GROUP <grp2> ( <mbr2> ) ).
      ENDLOOP.
    ENDLOOP.
    cl_demo_output=>display( jtab ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
