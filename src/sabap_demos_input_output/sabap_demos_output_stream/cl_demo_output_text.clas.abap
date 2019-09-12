CLASS cl_demo_output_text DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-EVENTS completed
      EXPORTING
        VALUE(ev_text) TYPE string .

    CLASS-METHODS handle_output
          FOR EVENT completed OF cl_demo_output_stream
      IMPORTING
          !ev_output .
    TYPE-POOLS abap .
    CLASS-METHODS set_display
      IMPORTING
        !iv_mode TYPE abap_bool DEFAULT abap_true .
  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPE-POOLS abap .
    CLASS-DATA gv_display TYPE abap_bool VALUE abap_true. "#EC NOTEXT .

    CLASS-METHODS convert
      IMPORTING
        !iv_xml        TYPE xstring
      RETURNING
        VALUE(rv_text) TYPE string
      RAISING cx_sy_regex_too_complex.
    CLASS-METHODS format_text
      CHANGING
        !cv_text TYPE string .
    CLASS-METHODS format_xml
      CHANGING
        !cv_text TYPE string
      RAISING cx_sy_regex_too_complex.
    CLASS-METHODS format_json
      CHANGING
        !cv_text TYPE string .
    CLASS-METHODS format_html
      CHANGING
        !cv_text TYPE string .
    CLASS-METHODS format_data
      CHANGING
        !cv_text TYPE string .
ENDCLASS.



CLASS CL_DEMO_OUTPUT_TEXT IMPLEMENTATION.


  METHOD convert.

    CALL TRANSFORMATION id SOURCE XML iv_xml
                           RESULT XML rv_text.

    SHIFT rv_text LEFT BY find( val = rv_text sub = `<ab:abapOutput` ) PLACES.
    REPLACE `<ab:abapOutput xmlns:ab="http://www.sap.com/abapdemos">` IN rv_text WITH ``.

    REPLACE `</ab:abapOutput>` IN rv_text WITH `` ##no_text.
    REPLACE `<ab:output>` IN rv_text WITH `` ##no_text.
    REPLACE `</ab:output>` IN rv_text WITH `` ##no_text.
    REPLACE ALL OCCURRENCES OF REGEX `<([^>]+)/>` IN rv_text WITH `<$1></$1>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:data format="nonprop">` IN rv_text WITH `<ab:data>`.
    REPLACE ALL OCCURRENCES OF REGEX ` format=("[^"]+")>`  IN rv_text WITH `>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:object>` IN rv_text WITH  `` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:object>` IN rv_text WITH  `</table>` && |\n| ##no_text.
    "REPLACE ALL OCCURRENCES OF `<ab:name>` IN rv_text WITH `` ##no_text.
    "REPLACE ALL OCCURRENCES OF `</ab:name>` IN rv_text WITH |:\n| ##no_text.
    REPLACE ALL OCCURRENCES OF REGEX `<ab:name>[^<]+</ab:name>` IN rv_text WITH ``.
    REPLACE ALL OCCURRENCES OF `<ab:components>` IN rv_text WITH `<table><tr>` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:components>` IN rv_text WITH `</tr>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:compName>` IN rv_text WITH `<td>` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:compName>` IN rv_text WITH `</td>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:data>` IN rv_text WITH `` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:data>` IN rv_text WITH `` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:row>` IN rv_text WITH `<tr>`  ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:row>` IN rv_text WITH `</tr>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:compValue>` IN rv_text WITH `<td>` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:compValue>` IN rv_text WITH `</td>` ##no_text.
    REPLACE ALL OCCURRENCES OF `&amp;lt;` IN rv_text WITH `&lt;` ##no_text.

    IF rv_text CS `<table>` AND
       rv_text CS `</table>`.
      format_data( CHANGING cv_text = rv_text ).
    ENDIF.
    IF rv_text CS `<ab:text>` AND
       rv_text CS `</ab:text>`.
      format_text( CHANGING cv_text = rv_text ).
    ENDIF.
    IF rv_text CS '<ab:xml>' AND
       rv_text CS '</ab:xml>'.
      format_xml( CHANGING cv_text = rv_text ).
    ENDIF.
    IF rv_text CS '<ab:json>' AND
       rv_text CS '</ab:json>'.
      format_json( CHANGING cv_text = rv_text ).
    ENDIF.
    IF rv_text CS '<ab:html>' AND
       rv_text CS '</ab:html>'.
      format_html( CHANGING cv_text = rv_text ).
    ENDIF.

  ENDMETHOD.


  METHOD format_data.
    DATA lt_max TYPE TABLE OF i.

    REPLACE ALL OCCURRENCES OF `<tr></tr>` IN cv_text WITH ``.

    DO.
      FIND `<table>` IN cv_text MATCH OFFSET DATA(lv_off1).
      IF sy-subrc <> 0.
        RETURN.
      ENDIF.
      FIND `</table>` IN cv_text MATCH OFFSET DATA(lv_off2).
      DATA(lv_section_old) = substring( val = cv_text
                                        off = lv_off1
                                        len = lv_off2 + strlen( `<\ table>` ) - lv_off1 - 1  ).

      DATA(lv_section_new) = lv_section_old.
      REPLACE `<table>` IN lv_section_new WITH ``.
      REPLACE `</table>` IN lv_section_new WITH ``.
      REPLACE ALL OCCURRENCES OF `<tr>` IN lv_section_new WITH ``.
      REPLACE ALL OCCURRENCES OF `<td>` IN lv_section_new WITH ``.

      SPLIT lv_section_new AT `</tr>` INTO TABLE DATA(lt_rows).
      CLEAR lt_max.
      LOOP AT lt_rows INTO DATA(lv_row).
        SPLIT lv_row AT `</td>` INTO TABLE DATA(lt_columns).
        IF lt_max IS INITIAL.
          DO lines( lt_columns ) TIMES.
            APPEND INITIAL LINE TO lt_max.
          ENDDO.
        ENDIF.
        LOOP AT lt_columns INTO DATA(lv_column).
          READ TABLE lt_max INDEX sy-tabix ASSIGNING FIELD-SYMBOL(<lv_max>).
          IF strlen( lv_column ) > <lv_max>.
            <lv_max> = strlen( lv_column ).
          ENDIF.
        ENDLOOP.
      ENDLOOP.
      SPLIT lv_section_new AT `</tr>` INTO TABLE lt_rows.
      CLEAR lv_section_new.
      LOOP AT lt_rows INTO lv_row.
        SPLIT lv_row AT `</td>` INTO TABLE lt_columns.
        LOOP AT lt_columns INTO lv_column.
          REPLACE ALL OCCURRENCES OF `&lt;`   IN lv_column WITH `<`.
          REPLACE ALL OCCURRENCES OF `&gt;`   IN lv_column WITH `>`.
          REPLACE ALL OCCURRENCES OF `&amp;`  IN lv_column WITH `&`.
          REPLACE ALL OCCURRENCES OF `&quot;` IN lv_column WITH `"`.
          REPLACE ALL OCCURRENCES OF `&apos;` IN lv_column WITH `'`.
          READ TABLE lt_max INDEX sy-tabix INTO DATA(lv_max).
          lv_section_new = lv_section_new && |{ lv_column WIDTH = lv_max + 2 }|.
        ENDLOOP.
        lv_section_new = lv_section_new && |\n|.
      ENDLOOP.

      REPLACE  lv_section_old IN cv_text WITH lv_section_new.
    ENDDO.



  ENDMETHOD.


  METHOD format_html.
    "Format plain HTML output
    DATA lt_text TYPE TABLE OF string.
    FIELD-SYMBOLS <lv_text> TYPE string.
    REPLACE ALL OCCURRENCES OF `<ab:html>` IN cv_text WITH `<<<<ab:html>`.
    REPLACE ALL OCCURRENCES OF `</ab:html>` IN cv_text WITH `</ab:html><<<`.
    SPLIT cv_text AT '<<<' INTO TABLE lt_text.
    DELETE lt_text WHERE table_line IS INITIAL.
    LOOP AT lt_text ASSIGNING <lv_text> WHERE table_line CS `<ab:html>`.
      IF <lv_text>(9) =  `<ab:html>`.
        REPLACE ALL OCCURRENCES OF |ab:lt| IN <lv_text> WITH |<|.
        REPLACE ALL OCCURRENCES OF |ab:gt| IN <lv_text> WITH |>|.
      ENDIF.
    ENDLOOP.
    CONCATENATE LINES OF lt_text INTO cv_text.
    REPLACE ALL OCCURRENCES OF `<ab:html>` IN cv_text WITH ``.
    REPLACE ALL OCCURRENCES OF `</ab:html>` IN cv_text WITH |\n\n|.
  ENDMETHOD.


  METHOD format_json.
    "Format JSON output
    DATA lt_text TYPE TABLE OF string.
    FIELD-SYMBOLS <lv_text> TYPE string.
    REPLACE ALL OCCURRENCES OF `<ab:json>` IN cv_text WITH `<<<<ab:json>`.
    REPLACE ALL OCCURRENCES OF `</ab:json>` IN cv_text WITH `</ab:json><<<`.
    SPLIT cv_text AT '<<<' INTO TABLE lt_text.
    DELETE lt_text WHERE table_line IS INITIAL.
    LOOP AT lt_text ASSIGNING <lv_text> WHERE table_line CS `<ab:json>`.
      IF <lv_text>(9) =  `<ab:json>`.
        REPLACE ALL OCCURRENCES OF `&lt;`   IN <lv_text> WITH `<`.
        REPLACE ALL OCCURRENCES OF `&gt;`   IN <lv_text> WITH `>`.
        REPLACE ALL OCCURRENCES OF `&amp;`  IN <lv_text> WITH `&`.
        REPLACE ALL OCCURRENCES OF `&quot;` IN <lv_text> WITH `"`.
        REPLACE ALL OCCURRENCES OF `&apos;` IN <lv_text> WITH `'`.
      ENDIF.
    ENDLOOP.
    CONCATENATE LINES OF lt_text INTO cv_text.
    REPLACE ALL OCCURRENCES OF `<ab:json>`  IN cv_text WITH ``.
    REPLACE ALL OCCURRENCES OF `</ab:json>` IN cv_text WITH |\n\n|.
  ENDMETHOD.


  METHOD format_text.
    "Format TEXT output
    DATA lt_text TYPE TABLE OF string.
    FIELD-SYMBOLS <lv_text> TYPE string.
    REPLACE ALL OCCURRENCES OF `<ab:text>` IN cv_text WITH `<<<<ab:text>`.
    REPLACE ALL OCCURRENCES OF `</ab:text>` IN cv_text WITH `</ab:text><<<`.
    SPLIT cv_text AT '<<<' INTO TABLE lt_text.
    DELETE lt_text WHERE table_line IS INITIAL.
    LOOP AT lt_text ASSIGNING <lv_text> WHERE table_line CS `<ab:text>`.
      IF <lv_text>(9) =  `<ab:text>`.
        REPLACE ALL OCCURRENCES OF `&lt;`   IN <lv_text> WITH `<`.
        REPLACE ALL OCCURRENCES OF `&gt;`   IN <lv_text> WITH `>`.
        REPLACE ALL OCCURRENCES OF `&amp;`  IN <lv_text> WITH `&`.
        REPLACE ALL OCCURRENCES OF `&quot;` IN <lv_text> WITH `"`.
        REPLACE ALL OCCURRENCES OF `&apos;` IN <lv_text> WITH `'`.
      ENDIF.
    ENDLOOP.
    CONCATENATE LINES OF lt_text INTO cv_text.
    REPLACE ALL OCCURRENCES OF `<ab:text>` IN cv_text WITH ``.
    REPLACE ALL OCCURRENCES OF `</ab:text>` IN cv_text WITH |\n\n|.
  ENDMETHOD.


  METHOD format_xml.
    "Format plain XML output
    DATA lt_text TYPE TABLE OF string.
    FIELD-SYMBOLS <lv_text> TYPE string.
    REPLACE ALL OCCURRENCES OF REGEX `(encoding="[^"]+"\?\&gt;).(\&lt;)` IN cv_text WITH `$1$2`.
    REPLACE ALL OCCURRENCES OF `<ab:xml>` IN cv_text WITH `<<<<ab:xml>`.
    REPLACE ALL OCCURRENCES OF `</ab:xml>` IN cv_text WITH `</ab:xml><<<`.
    SPLIT cv_text AT '<<<' INTO TABLE lt_text.
    DELETE lt_text WHERE table_line IS INITIAL.
    LOOP AT lt_text ASSIGNING <lv_text> WHERE table_line CS `<ab:xml>`.
      IF <lv_text>(8) =  `<ab:xml>`.
        REPLACE ALL OCCURRENCES OF |&lt;| IN <lv_text> WITH |<|.
        REPLACE ALL OCCURRENCES OF |&gt;| IN <lv_text> WITH |>|.
        REPLACE ALL OCCURRENCES OF `&amp;amp;` IN <lv_text> WITH `&`.
      ENDIF.
    ENDLOOP.
    CONCATENATE LINES OF lt_text INTO cv_text.
    REPLACE ALL OCCURRENCES OF `<ab:xml>` IN cv_text WITH ``.
    REPLACE ALL OCCURRENCES OF `</ab:xml>` IN cv_text WITH |\n\n|.
  ENDMETHOD.


  METHOD handle_output.
    DATA lv_text TYPE string.
    DATA lv_gui_flag TYPE abap_bool VALUE abap_false.

    TRY.
        lv_text = convert( ev_output ).
      CATCH cx_sy_regex_too_complex.
        lv_text = `Data too complex or too large, output not possible.` ##no_text.
    ENDTRY.

    IF gv_display = abap_true.
      CALL FUNCTION 'GUI_IS_AVAILABLE'
        IMPORTING
          return = lv_gui_flag.
    ENDIF.
    IF lv_gui_flag IS NOT INITIAL.
      cl_demo_text=>display_string( lv_text  ).
    ELSE.
      RAISE EVENT completed EXPORTING ev_text = lv_text.
      EXPORT result_text = lv_text TO MEMORY ID 'RESULT_TEXT'.
    ENDIF.

  ENDMETHOD.


  METHOD set_display.
    gv_display = iv_mode.
  ENDMETHOD.
ENDCLASS.
