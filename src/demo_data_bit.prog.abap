REPORT demo_data_bit.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    TYPES: BEGIN OF t_spfli,
             carrid    TYPE spfli-carrid,
             cityfrom  TYPE spfli-cityfrom,
          END OF t_spfli.

    DATA: frankfurt TYPE x LENGTH 4,
          frisco    TYPE x LENGTH 4,
          intersect TYPE x LENGTH 4,
          union     TYPE x LENGTH 4,
          bit       TYPE i,
          spflitab  TYPE TABLE OF t_spfli,
          wa        TYPE t_spfli,
          carrid    TYPE t_spfli-carrid,
          carrier   LIKE SORTED TABLE OF carrid
                                WITH UNIQUE KEY table_line.


    SELECT carrid FROM scarr INTO TABLE @carrier.

    SELECT carrid, cityfrom
           FROM spfli
           INTO CORRESPONDING FIELDS OF TABLE @spflitab.

    DATA(out) = cl_demo_output=>new(
      )->begin_section(
      'Airlines with departure cities'
      )->write_data( spflitab
      )->end_section( ).

    LOOP AT spflitab INTO wa.

      READ TABLE carrier FROM wa-carrid TRANSPORTING NO FIELDS.

      CASE wa-cityfrom.
        WHEN 'FRANKFURT'.
          SET BIT sy-tabix OF frankfurt.
        WHEN 'SAN FRANCISCO'.
          SET BIT sy-tabix OF frisco.
      ENDCASE.

    ENDLOOP.

    intersect = frankfurt BIT-AND frisco.
    union     = frankfurt BIT-OR  frisco.

    out->begin_section(
      'Airlines flying from Frankfurt and San Francisco' ).
    DO 32 TIMES.
      GET BIT sy-index OF intersect INTO bit.
      IF bit = 1.
        carrid = carrier[ sy-index ].
        out->write( |{ carrid }| ).
      ENDIF.
    ENDDO.

    out->next_section(
      'Airlines flying from Frankfurt or San Francisco' ).
    DO 32 TIMES.
      GET BIT sy-index OF union INTO bit.
      IF bit = 1.
        carrid = carrier[ sy-index ].
        out->write( |{ carrid }| ).
      ENDIF.
    ENDDO.

    out->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
