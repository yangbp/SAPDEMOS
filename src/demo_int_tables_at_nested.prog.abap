REPORT demo_int_tables_at_nested.

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

    LOOP AT sflight_tab INTO DATA(sflight_wa).
      AT NEW connid.
        out->next_section( |{ sflight_wa-carrid } | &&
                           |{ sflight_wa-connid }| ).
      ENDAT.
      group = VALUE #( BASE group
                     ( CORRESPONDING #( sflight_wa  ) ) ).

      AT END OF connid.
        IF to_upper( display_members ) = abap_true.
          out->write( group ).
        ENDIF.
        CLEAR group.
        SUM.
        out->write( |Sum: | &&
                    |{ sflight_wa-seatsocc }| ).
      ENDAT.
      AT END OF carrid.
        SUM.
        out->line(
          )->write( |Carrier Sum: | &&
                    |{ sflight_wa-seatsocc }|
          )->line( ).
      ENDAT.
      AT LAST.
        SUM.
        out->write( |Overall Sum: | &&
                    |{ sflight_wa-seatsocc }| ).
      ENDAT.
    ENDLOOP.
    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
