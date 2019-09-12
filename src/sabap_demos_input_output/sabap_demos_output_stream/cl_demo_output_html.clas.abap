CLASS cl_demo_output_html DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-EVENTS completed
      EXPORTING
        VALUE(ev_html) TYPE string .

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
                VALUE(rv_html) TYPE string
      RAISING   cx_sy_regex_too_complex.
    CLASS-METHODS format_html
      CHANGING
        !cv_html TYPE string .
    CLASS-METHODS format_xml
      CHANGING
               !cv_html TYPE string
      RAISING  cx_sy_regex_too_complex.
    CLASS-METHODS format_json
      CHANGING
        !cv_html TYPE string .
    CLASS-METHODS format_text
      CHANGING
        !cv_html TYPE string .
    CLASS-METHODS format_data
      CHANGING
        !cv_html TYPE string .
ENDCLASS.



CLASS CL_DEMO_OUTPUT_HTML IMPLEMENTATION.


  METHOD convert.

    CALL TRANSFORMATION id SOURCE XML iv_xml
                           RESULT XML rv_html.

    REPLACE ALL OCCURRENCES OF `<ab:compValue></ab:compValue>` IN rv_html WITH `<ab:compValue>&nbsp;</ab:compValue>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:compValue/>` IN rv_html WITH `<ab:compValue>&nbsp;</ab:compValue>` ##no_text.

    SHIFT rv_html LEFT BY find( val = rv_html sub = `<ab:abapOutput` ) PLACES.
    REPLACE `<ab:abapOutput xmlns:ab="http://www.sap.com/abapdemos">` IN rv_html WITH
    `<html lang="EN">` &&
           `<head>` &&
           `<meta name="Output" content="Data">` &&
           `<style type="text/css">` &&
           `body    { font-family: Arial; font-size: 90%; }` &&
           `table   { font-family: Arial; font-size: 90%; }` &&
           `caption { font-family: Arial; font-size: 90%;  font-weight:bold; text-align:left; }`  &&
           `span.heading1 {font-size: 150%; color:#000080; font-weight:bold;}`   &&
           `span.heading2 {font-size: 135%; color:#000080; font-weight:bold;}`   &&
           `span.heading3 {font-size: 120%; color:#000080; font-weight:bold;}`   &&
           `span.heading4 {font-size: 105%; color:#000080; font-weight:bold;}`   &&
           `span.normal   {font-size: 100%; color:#000000; font-weight:normal;}` &&
           `span.nonprop  {font-family: Courier New; font-size: 100%; color:#000000; font-weight:400;}` &&
           `span.nowrap   {white-space:nowrap; }` &&
           `span.nprpnwrp {font-family: Courier New; font-size: 100%; color:#000000; font-weight:400; white-space:nowrap; }` &&
           `tr.header   {background-color:#D3D3D3; }`      &&
           `tr.body     {background-color:#EFEFEF; }`      &&
           `</style>` &&
           `</head>` ##no_text.

    REPLACE `</ab:abapOutput>` IN rv_html WITH `</html>` ##no_text.
    REPLACE `<ab:output>` IN rv_html WITH `<body>` ##no_text.
    REPLACE `</ab:output>` IN rv_html WITH `</body>` ##no_text.
    REPLACE ALL OCCURRENCES OF REGEX `<([^>]+)/>` IN rv_html WITH `<$1></$1>` ##no_text.
    format_data( CHANGING cv_html = rv_html ).
    REPLACE ALL OCCURRENCES OF REGEX ` format=("[^"]+")>`  IN rv_html WITH `><span class=$1>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:text>` IN rv_html WITH `<p>` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:text>` IN rv_html WITH `</span></p>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:object>` IN rv_html WITH `<table border="0" summary="data display" title="ABAP Data">` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:object>` IN rv_html WITH `</table><br>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:name>` IN rv_html WITH `<caption><span class="nowrap">` ##no_text. "`<tr><th colspan="100" align="left">`.
    REPLACE ALL OCCURRENCES OF `</ab:name>` IN rv_html WITH `</span></caption>` ##no_text. "`</th><tr>`.
    REPLACE ALL OCCURRENCES OF `<ab:components>` IN rv_html WITH `<tr class="header">` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:components>` IN rv_html WITH `</span></tr>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:compName>` IN rv_html WITH `<td>` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:compName>` IN rv_html WITH `</td>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:data>` IN rv_html WITH `` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:data>` IN rv_html WITH `` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:row>` IN rv_html WITH `<tr class="body">` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:row>` IN rv_html WITH `</tr>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab:compValue>` IN rv_html WITH `<td><span class="nowrap">` ##no_text.
    REPLACE ALL OCCURRENCES OF `<span class="nowrap"><span class="nonprop">` IN rv_html WITH `<span class="nprpnwrp">` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab:compValue>` IN rv_html WITH `</span></td>` ##no_text.
    REPLACE ALL OCCURRENCES OF `&amp;lt;` IN rv_html WITH `&lt;` ##no_text.
    IF rv_html CS '<ab:xml>' AND
       rv_html CS '</ab:xml>'.
      format_xml( CHANGING cv_html = rv_html ).
    ENDIF.
    IF rv_html CS '<ab:json>' AND
       rv_html CS '</ab:json>'.
      format_json( CHANGING cv_html = rv_html ).
    ENDIF.
    IF rv_html CS '<ab:html>' AND
       rv_html CS '</ab:html>'.
      format_html( CHANGING cv_html = rv_html ).
    ENDIF.
    IF rv_html CS '<span class="nonprop">' OR
       rv_html CS '<span class="normal">' OR
       rv_html CS '<span class="nprpnwrp">'.
      format_text( CHANGING cv_html = rv_html ).
    ENDIF.
  ENDMETHOD.


  METHOD format_data.
    DATA lv_off TYPE i.
    DATA lv_len TYPE i.
    DATA lv_subrc TYPE sy-subrc.
    WHILE lv_subrc = 0.
      FIND `<ab:data format="nonprop">` IN cv_html MATCH OFFSET lv_off ##no_text.
      lv_subrc = sy-subrc.
      IF lv_subrc = 0.
        REPLACE `<ab:data format="nonprop">` IN cv_html WITH `<ab:data>` ##no_text.
        FIND `</ab:data>` IN SECTION OFFSET lv_off OF cv_html MATCH OFFSET lv_len.
        REPLACE ALL OCCURRENCES OF `<ab:compValue>`
                IN SECTION OFFSET lv_off LENGTH lv_len - lv_off
                OF cv_html WITH `<ab:compValue format="nonprop">` ##no_text.
      ENDIF.
    ENDWHILE.
  ENDMETHOD.


  METHOD format_html.
    "Formatted HTML output
    DATA lt_html TYPE TABLE OF string.
    FIELD-SYMBOLS <lv_html> TYPE string.
    REPLACE ALL OCCURRENCES OF `<ab:html>` IN cv_html WITH `<<<<ab:html>`.
    REPLACE ALL OCCURRENCES OF `</ab:html>` IN cv_html WITH `</ab:html><<<`.
    SPLIT cv_html AT '<<<' INTO TABLE lt_html.
    DELETE lt_html WHERE table_line IS INITIAL.
    LOOP AT lt_html ASSIGNING <lv_html> WHERE table_line CS `<ab:html>`.
      IF <lv_html>(9) =  `<ab:html>`.
        REPLACE ALL OCCURRENCES OF `ab:lt` IN <lv_html> WITH `<` ##no_text.
        REPLACE ALL OCCURRENCES OF `ab:gt` IN <lv_html> WITH `>` ##no_text.
        REPLACE ALL OCCURRENCES OF `ab:amp` IN <lv_html> WITH `&` ##no_text.
        REPLACE `<ab:html>` IN <lv_html> WITH `<p>`.
        REPLACE `</ab:html>` IN <lv_html> WITH `</p>`.
      ENDIF.
    ENDLOOP.
    CONCATENATE LINES OF lt_html INTO cv_html.
  ENDMETHOD.


  METHOD format_json.
    "Format plain XML output
    DATA lt_html TYPE TABLE OF string.
    FIELD-SYMBOLS <lv_html> TYPE string.
    REPLACE ALL OCCURRENCES OF `<ab:json>` IN cv_html WITH `<<<<ab:json>`.
    REPLACE ALL OCCURRENCES OF `</ab:json>` IN cv_html WITH `</ab:json><<<`.
    SPLIT cv_html AT '<<<' INTO TABLE lt_html.
    DELETE lt_html WHERE table_line IS INITIAL.
    LOOP AT lt_html ASSIGNING <lv_html> WHERE table_line CS `<ab:json>`.
      IF <lv_html>(9) =  `<ab:json>`.
        REPLACE ALL OCCURRENCES OF |\n| IN <lv_html> WITH `<br>`.
        REPLACE ALL OCCURRENCES OF | | IN <lv_html> WITH `&nbsp;`.
        <lv_html> = `<p><span class="nonprop">` && <lv_html> && `</span></p>`.
      ENDIF.
    ENDLOOP.
    CONCATENATE LINES OF lt_html INTO cv_html.
  ENDMETHOD.


  METHOD format_text.
    "Handle whitespace characters in textlike data
    CONSTANTS: lc_heading  TYPE string VALUE `<span class="heading`,
               lc_normal   TYPE string VALUE `<span class="normal">`,
               lc_nonprop  TYPE string VALUE `<span class="nonprop">`,
               lc_nprpnwrp TYPE string VALUE `<span class="nprpnwrp">`.
    DATA: lv_heading  TYPE i,
          lv_normal   TYPE i,
          lv_nonprop  TYPE i,
          lv_nprpnwrp TYPE i.
    DATA: lv_part1 TYPE string,
          lv_part2 TYPE string.
    DATA lt_html TYPE TABLE OF string.
    FIELD-SYMBOLS <lv_html> TYPE string.
    REPLACE ALL OCCURRENCES OF `<span` IN cv_html WITH `<<<<span`.
    REPLACE ALL OCCURRENCES OF `</span>` IN cv_html WITH `</span><<<`.
    SPLIT cv_html AT '<<<' INTO TABLE lt_html.
    DELETE lt_html WHERE table_line IS INITIAL.
    lv_heading  = strlen( lc_heading ).
    lv_normal   = strlen( lc_normal ).
    lv_nonprop  = strlen( lc_nonprop ).
    lv_nprpnwrp = strlen( lc_nprpnwrp ).
    LOOP AT lt_html ASSIGNING <lv_html> WHERE table_line CS `<span`.
      IF strlen( <lv_html> ) > lv_heading AND <lv_html>+0(lv_heading) = lc_heading.
        lv_heading = lv_heading + 3.
        lv_part1 = <lv_html>+0(lv_heading).
        lv_part2 = <lv_html>+lv_heading.
        REPLACE ALL OCCURRENCES OF |&amp;| IN lv_part2 WITH `&`.
        <lv_html> = lv_part1 && lv_part2.
      ENDIF.
      IF strlen( <lv_html> ) > lv_normal AND <lv_html>+0(lv_normal) = lc_normal.
        lv_part1 = <lv_html>+0(lv_normal).
        lv_part2 = <lv_html>+lv_normal.
        REPLACE ALL OCCURRENCES OF |&amp;| IN lv_part2 WITH `&`.
        REPLACE ALL OCCURRENCES OF |\n|    IN lv_part2 WITH `<br>`.
        REPLACE ALL OCCURRENCES OF |\r|    IN lv_part2 WITH `<br>`.
        <lv_html> = lv_part1 && lv_part2.
      ENDIF.
      IF strlen( <lv_html> ) > lv_nonprop AND <lv_html>+0(lv_nonprop) = lc_nonprop.
        lv_part1 = <lv_html>+0(lv_nonprop).
        lv_part2 = <lv_html>+lv_nonprop.
        REPLACE ALL OCCURRENCES OF |&amp;| IN lv_part2 WITH `&`.
        REPLACE ALL OCCURRENCES OF |\n|    IN lv_part2 WITH `<br>`.
        REPLACE ALL OCCURRENCES OF |\r|    IN lv_part2 WITH `<br>`.
        REPLACE ALL OCCURRENCES OF |\t|    IN lv_part2 WITH `      `.
        REPLACE ALL OCCURRENCES OF | |     IN lv_part2 WITH `&nbsp;`.
        "REPLACE ALL OCCURRENCES OF |-|     IN lv_part2 WITH `&#8209;`. "non breaking hyphen
        <lv_html> = lv_part1 && lv_part2.
      ENDIF.
      IF strlen( <lv_html> ) > lv_nprpnwrp AND <lv_html>+0(lv_nprpnwrp) = lc_nprpnwrp.
        lv_part1 = <lv_html>+0(lv_nprpnwrp).
        lv_part2 = <lv_html>+lv_nprpnwrp.
        REPLACE ALL OCCURRENCES OF |&amp;| IN lv_part2 WITH `&`.
        REPLACE ALL OCCURRENCES OF |\n|    IN lv_part2 WITH `<br>`.
        REPLACE ALL OCCURRENCES OF |\r|    IN lv_part2 WITH `<br>`.
        REPLACE ALL OCCURRENCES OF |\t|    IN lv_part2 WITH `      `.
        REPLACE ALL OCCURRENCES OF | |     IN lv_part2 WITH `&nbsp;`.
        <lv_html> = lv_part1 && lv_part2.
      ENDIF.
    ENDLOOP.
    CLEAR cv_html.
    CONCATENATE LINES OF lt_html INTO cv_html.
  ENDMETHOD.


  METHOD format_xml.
    "Format plain XML output
    DATA lt_html TYPE TABLE OF string.
    FIELD-SYMBOLS <lv_html> TYPE string.
    REPLACE ALL OCCURRENCES OF REGEX `(encoding="[^"]+"\?\&gt;).(\&lt;)` IN cv_html WITH `$1$2`.
    REPLACE ALL OCCURRENCES OF `<ab:xml>` IN cv_html WITH `<<<<ab:xml>`.
    REPLACE ALL OCCURRENCES OF `</ab:xml>` IN cv_html WITH `</ab:xml><<<`.
    SPLIT cv_html AT '<<<' INTO TABLE lt_html.
    DELETE lt_html WHERE table_line IS INITIAL.
    LOOP AT lt_html ASSIGNING <lv_html> WHERE table_line CS `<ab:xml>`.
      IF <lv_html>(8) =  `<ab:xml>`.
        REPLACE ALL OCCURRENCES OF |\n| IN <lv_html> WITH `<br>`.
        REPLACE ALL OCCURRENCES OF | | IN <lv_html> WITH `&nbsp;`.
        <lv_html> = `<p><span class="nonprop">` && <lv_html> && `</span></p>`.
      ENDIF.
    ENDLOOP.
    CONCATENATE LINES OF lt_html INTO cv_html.
  ENDMETHOD.


  METHOD handle_output.
    DATA lv_html TYPE string.
    DATA lv_gui_flag TYPE abap_bool VALUE abap_false.
    DATA lt_errors TYPE TABLE OF string ##needed.

    TRY.
        lv_html = convert( ev_output ).
      CATCH cx_sy_regex_too_complex.
        lv_html = `<html><body>Data too complex or too large, output not possible.</body></html>` ##no_text.
    ENDTRY.

    IF gv_display = abap_true.
      CALL FUNCTION 'GUI_IS_AVAILABLE'
        IMPORTING
          return = lv_gui_flag.
    ENDIF.
    IF lv_gui_flag IS NOT INITIAL.
      cl_abap_browser=>show_html( EXPORTING html_string = lv_html
                                            title = `Output`
                                            check_html = abap_false
                                  IMPORTING html_errors = lt_errors  ) ##no_text.
    ELSE.
      RAISE EVENT completed EXPORTING ev_html = lv_html.
      EXPORT result_html = lv_html TO MEMORY ID 'RESULT_HTML'.
    ENDIF.

  ENDMETHOD.


  METHOD set_display.
    gv_display = iv_mode.
  ENDMETHOD.
ENDCLASS.
