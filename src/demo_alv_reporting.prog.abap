REPORT demo_alv_reporting.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA     scarr_tab TYPE TABLE OF scarr.
    CLASS-METHODS: handle_double_click
                     FOR EVENT double_click
                     OF cl_salv_events_table
                     IMPORTING row column,
                   detail
                     IMPORTING carrid TYPE scarr-carrid,
                   browser
                     IMPORTING url    TYPE csequence.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    SELECT *
           FROM scarr
           INTO TABLE @scarr_tab.
    TRY.
        cl_salv_table=>factory(
          IMPORTING r_salv_table = DATA(alv)
          CHANGING  t_table = scarr_tab ).
        DATA(events) = alv->get_event( ).
        SET HANDLER handle_double_click FOR events.
        DATA(columns) = alv->get_columns( ).
        DATA(col_tab) = columns->get( ).
        LOOP AT col_tab ASSIGNING FIELD-SYMBOL(<column>).
          <column>-r_column->set_output_length( 40 ).
          IF <column>-columnname = 'CARRNAME' OR
             <column>-columnname = 'URL'.
            <column>-r_column->set_visible( 'X' ).
          ELSE.
            <column>-r_column->set_visible( ' ' ).
          ENDIF.
        ENDLOOP.
        alv->display( ).
      CATCH cx_salv_msg.
        MESSAGE 'ALV display not possible' TYPE 'I'
                DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.
  METHOD handle_double_click.
    READ TABLE scarr_tab INDEX row ASSIGNING FIELD-SYMBOL(<scarr>).
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    IF column = 'CARRNAME'.
      demo=>detail( <scarr>-carrid ).
    ELSEIF column = 'URL'.
      demo=>browser( <scarr>-url ).
    ENDIF.
  ENDMETHOD.
  METHOD detail.
    TYPES: BEGIN OF alv_line,
             carrid   TYPE spfli-carrid,
             connid   TYPE spfli-connid,
             cityfrom TYPE spfli-cityfrom,
             cityto   TYPE spfli-cityto,
           END OF alv_line.
    DATA   alv_tab    TYPE TABLE OF alv_line.
    SELECT carrid, connid, cityfrom, cityto
           FROM spfli
           WHERE carrid = @carrid
           INTO CORRESPONDING FIELDS OF TABLE @alv_tab.
    IF sy-subrc <> 0.
      MESSAGE e007(sabapdemos).
    ENDIF.
    TRY.
        cl_salv_table=>factory(
          IMPORTING r_salv_table = DATA(alv)
          CHANGING  t_table = alv_tab ).
        alv->set_screen_popup( start_column = 1
                               end_column   = 60
                               start_line   = 1
                               end_line     = 12 ).
        alv->display( ).
      CATCH cx_salv_msg.
        MESSAGE 'ALV display not possible' TYPE 'I'
                DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.
  METHOD browser.
    cl_abap_browser=>show_url(
      EXPORTING url = url ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
