REPORT demo_for_groups_by_levels_nest.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES: BEGIN OF group,
             fldate   TYPE sflight-fldate,
             seatsocc TYPE sflight-seatsocc,
           END OF group,
           group_tab type STANDARD TABLE OF group WITH EMPTY KEY.

    DATA: sflight_tab TYPE SORTED TABLE OF sflight
                      WITH UNIQUE KEY carrid connid fldate.

    DATA(display_members) = abap_false.
    cl_demo_input=>request( EXPORTING text  = `Display Group Members?`
                            CHANGING  field = display_members ).

    DATA(out) = cl_demo_output=>new( ).

    SELECT *
           FROM sflight
           INTO TABLE @sflight_tab.

    DATA(total_sum) =
      REDUCE i(
        LET wg = xsdbool( to_upper( display_members ) = abap_true ) IN
        INIT t = 0
             o = out
        FOR GROUPS OF carrid_group IN sflight_tab
              GROUP BY carrid_group-carrid
        LET carrid_sum =
          REDUCE i(
            INIT s1 = 0
                 o1 = out
            FOR GROUPS OF connid_group IN GROUP carrid_group
                  GROUP BY connid_group-connid
            LET connid_sum =
              REDUCE i(
                INIT s2 = 0
                FOR m IN GROUP connid_group
                NEXT s2 = s2 + m-seatsocc )
                o2 = out->next_section(
                    |{ connid_group-carrid } { connid_group-connid }| )
                o3 = COND #( WHEN wg = abap_true
                               THEN LET group = VALUE group_tab(
                                 FOR m IN GROUP connid_group
                                   ( CORRESPONDING #( m ) ) ) IN
                                     out->write( group ) ) IN
            NEXT s1 = s1 + connid_sum
                 o1 = o1->write( |Sum: { connid_sum }| ) ) IN
        NEXT t = t + carrid_sum
             o = o->line(
                  )->write( |Carrier Sum: { carrid_sum }|
                  )->line( ) ).

    out->write( |Overall Sum: | &&
                |{ total_sum }| )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
