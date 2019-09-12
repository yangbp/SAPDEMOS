REPORT demo_escape NO STANDARD PAGE HEADING.

PARAMETERS x_diff AS CHECKBOX DEFAULT ' '.
DEFINE par.
  SELECTION-SCREEN begin of line.
  SELECTION-SCREEN COMMENT 3(20) OT_&1. SELECTION-SCREEN POSITION 1.
  PARAMETERS OX_&1 AS CHECKBOX DEFAULT ' ' modif id OPT ##SEL_WRONG.
  SELECTION-SCREEN end OF LINE.
END-OF-DEFINITION.
SELECTION-SCREEN SKIP 1.
SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN PUSHBUTTON 1(6) s_all USER-COMMAND sla VISIBLE LENGTH 2.
  SELECTION-SCREEN PUSHBUTTON 5(6) d_all USER-COMMAND dla VISIBLE LENGTH 2.
SELECTION-SCREEN END OF LINE.
" checkboxes for format selection (texts filled dynamically)
par: 01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,
     25,26,27,28,29,30,31,32.


CLASS cl_abap_format DEFINITION LOAD.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
    CLASS-METHODS header.
    CLASS-METHODS get_formats.
    CLASS-METHODS show_options.
    CLASS-METHODS set_options IMPORTING value(val) TYPE csequence.
  PRIVATE SECTION.
    " some high character codes to test:
    CONSTANTS test_high_codes TYPE string VALUE
      `0100 ` &
      `2000 ` & " 'En' Quad
      `2028 ` & " Line Separator
      `2029 ` & " Paragraph Separator
      `20AC ` & " Euro Sign
      `2460 ` & " Circled Digit One
      `FEFF`.   " Zero-Width Space
    CONSTANTS     colwidth TYPE i VALUE 14.
    CLASS-DATA:   BEGIN OF format,
                    value  LIKE cl_abap_format=>e_xml_text,
                    name   TYPE abap_attrdescr-name,
                    option TYPE string,
                  END OF format,
                  formats LIKE SORTED TABLE OF format
                          WITH UNIQUE KEY name.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD header.
    DATA: off TYPE i, frm LIKE format.
    SET LEFT SCROLL-BOUNDARY.
    LOOP AT demo=>formats INTO frm.
      SKIP TO LINE 1.
      off = sy-tabix * colwidth - 4.
      FORMAT COLOR COL_HEADING.
      ##NO_TEXT WRITE: AT /(4) 'Code', AT 6(4) 'Char'.
      SET LEFT SCROLL-BOUNDARY.
      WRITE AT off(colwidth) frm-name+2 CENTERED.
    ENDLOOP.
  ENDMETHOD.
  METHOD main.
    DATA: char     TYPE string,
          result   TYPE string,
          code     TYPE x LENGTH 2,
          icode    TYPE i,
          off      TYPE i,
          exc      TYPE REF TO cx_sy_strg_par_val,
          colr     TYPE i,
          results  TYPE STANDARD TABLE OF string.
    FIELD-SYMBOLS <o> TYPE c.
    " remove deselected formats from table
    LOOP AT demo=>formats INTO demo=>format.
      ASSIGN (demo=>format-option) TO <o>.
      IF <o> IS INITIAL.
        DELETE demo=>formats.
      ENDIF.
    ENDLOOP.
    " set line size according to # of selected formats
    off = 9 + lines( formats ) * colwidth.
    NEW-PAGE LINE-SIZE off.
    " output list of selected formats
    LOOP AT demo=>formats INTO demo=>format.
      SKIP TO LINE 2.
      off = sy-tabix * colwidth - 4.
      DO.
        CLEAR exc.  icode = -1.
        IF sy-index <= 256.
          code = sy-index - 1.
        ELSE.
          TRY.
            result = segment( val = test_high_codes index = sy-index - 256 ).
          CATCH cx_sy_strg_par_val.
            EXIT.
          ENDTRY.
          code = result.
        ENDIF.
        char = |{ cl_abap_conv_in_ce=>uccp( code ) WIDTH = 1 }|.
        TRY.
          result = escape( val = char format = demo=>format-value  ).
          IF strlen( result ) = 1.
            icode = cl_abap_conv_out_ce=>uccpi( result ).
          ENDIF.
        CATCH cx_sy_strg_par_val INTO exc.
          result = exc->get_text( ).
        ENDTRY.
        colr = col_key.
        IF x_diff IS NOT INITIAL.
          IF lines( results ) < sy-index.
            APPEND result TO results.
          ELSE.
            FIELD-SYMBOLS <r> TYPE STRING.
            READ TABLE results INDEX sy-index ASSIGNING <r>.
            IF result <> <r>.
              colr = col_negative.
              <r> = `@?`.
            ENDIF.
          ENDIF.
        ENDIF.
        FORMAT COLOR COL_NORMAL.
        WRITE: AT /(4) code COLOR = colr INTENSIFIED OFF,
               AT 6(1) ` `  COLOR COL_KEY,
               AT 7(3) char COLOR COL_KEY.
        IF exc IS NOT INITIAL.
          WRITE AT off(colwidth) icon_failure AS ICON CENTERED.
        ELSEIF icode >= 0 AND icode < 32.
          result = |({ icode })|.
          WRITE AT off(colwidth) result COLOR COL_KEY INTENSIFIED OFF
                                        CENTERED.
        ELSE.
          WRITE AT off(colwidth) result CENTERED.
        ENDIF.
      ENDDO.
    ENDLOOP.
  ENDMETHOD.
  METHOD get_formats.
    DATA: cldescr  TYPE REF TO cl_abap_classdescr,
          formats  TYPE abap_attrdescr_tab,
          format   LIKE LINE OF formats.
    FIELD-SYMBOLS <format> LIKE cl_abap_format=>e_xml_text.
    cldescr ?= cl_abap_classdescr=>describe_by_name( 'CL_ABAP_FORMAT' ).
    formats = cldescr->attributes.
    DELETE formats WHERE name NP 'E_*' OR is_constant <> 'X'.
    LOOP AT formats INTO format.
      ASSIGN cl_abap_format=>(format-name) TO <format>.
      TRY. " exclude formats which are not (yet) implemented
        CHECK escape( val = 'A<&%' format = <format>  ) <> ``.
      CATCH cx_sy_strg_par_val.
        CONTINUE.
      ENDTRY.
      demo=>format-value = <format>.
      demo=>format-name = format-name.
      INSERT demo=>format INTO TABLE demo=>formats.
    ENDLOOP.
  ENDMETHOD.
  METHOD show_options.
    DATA: i TYPE i, n TYPE i, on TYPE string, scr TYPE screen.
    FIELD-SYMBOLS: <ot> TYPE csequence, <format> LIKE LINE OF formats.
    DO. " assign format names to generic checkbox comments
      ADD 1 TO n. on = |OT_{ n WIDTH = 2 ALIGN = RIGHT PAD = '0' }|.
      ASSIGN (on) TO <ot>.
      IF sy-subrc <> 0.  EXIT.  ENDIF.
      READ TABLE formats INDEX n ASSIGNING <format>.
      IF sy-subrc <> 0.  EXIT.  ENDIF.
      <ot> = <format>-name+2.
      <format>-option = |OX_{ n WIDTH = 2 ALIGN = RIGHT PAD = '0' }|.
    ENDDO.
    LOOP AT screen INTO scr. " hide superfluous checkboxes
      CHECK scr-group1 = 'OPT'.
      i = substring_after( val = scr-name sub = '_' ).
      IF i >= n.
        scr-invisible = '1'. MODIFY screen FROM scr.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD set_options.
    DATA: n TYPE i, on TYPE string.
    FIELD-SYMBOLS: <ox> TYPE c.
    DO. " set all checkboxes to 'X' or ' '
      ADD 1 TO n. on = |OX_{ n WIDTH = 2 ALIGN = RIGHT PAD = '0' }|.
      ASSIGN (on) TO <ox>.
      IF sy-subrc <> 0.  EXIT.  ENDIF.
      <ox> = val.
    ENDDO.
  ENDMETHOD.
ENDCLASS.

DEFINE set_icon.
  CALL FUNCTION 'ICON_CREATE'
   EXPORTING  name = &2  text = ''  add_stdinf = space
   IMPORTING  result = &1  EXCEPTIONS OTHERS = 1 ##FM_SUBRC_OK.
END-OF-DEFINITION.

LOAD-OF-PROGRAM.
  demo=>get_formats( ).
  set_icon s_all icon_select_all.
  set_icon d_all icon_deselect_all.

AT SELECTION-SCREEN OUTPUT.
  demo=>show_options( ).

AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'SLA'.  demo=>set_options( 'X' ).
    WHEN 'DLA'.  demo=>set_options( ' ' ).
  ENDCASE.

START-OF-SELECTION.
  demo=>main( ).

TOP-OF-PAGE.
  demo=>header( ).
