REPORT demo_loop_group_by_levels_nest.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES: BEGIN OF group,
             fldate   TYPE sflight-fldate,
             seatsocc TYPE sflight-seatsocc,
           END OF group.

    DATA: sflight_tab TYPE SORTED TABLE OF sflight
                      WITH UNIQUE KEY carrid connid fldate,
          group       TYPE TABLE OF group WITH EMPTY KEY.


    DATA(display_members) = abap_false.
    cl_demo_input=>request( EXPORTING text  = `Display Group Members?`
                            CHANGING  field = display_members ).

    DATA(out) = cl_demo_output=>new( ).

    SELECT *
           FROM sflight
           INTO TABLE @sflight_tab.

    DATA(total_sum)  = 0.
    LOOP AT sflight_tab INTO DATA(carrid_group)
         GROUP BY carrid_group-carrid.
      DATA(carrid_sum) = 0.
      LOOP AT GROUP carrid_group INTO DATA(connid_group)
           GROUP BY connid_group-connid.
        out->next_section( |{ connid_group-carrid } | &&
                           |{ connid_group-connid }| ).
        CLEAR group.
        DATA(connid_sum) = 0.
        LOOP AT GROUP connid_group INTO DATA(connid_member).
          group = VALUE #( BASE group
                         ( CORRESPONDING #( connid_member ) ) ).
          connid_sum = connid_sum + connid_member-seatsocc.
        ENDLOOP.
        carrid_sum = carrid_sum + connid_sum.
        IF to_upper( display_members ) = abap_true.
          out->write( group ).
        ENDIF.
        out->write( |Sum: | &&
                    |{ connid_sum }| ).
      ENDLOOP.
      out->line(
        )->write( |Carrier Sum: | &&
                  |{ carrid_sum }|
        )->line( ).
      total_sum = total_sum + carrid_sum.
    ENDLOOP.
    out->write( |Overall Sum: | &&
                |{ total_sum }|
       )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
