CLASS cl_demo_string_processing DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS main .
  PROTECTED SECTION.
*"* protected components of class ZCL_DEMO_STRING_PROCESSING
*"* do not include other source files here!!!
  PRIVATE SECTION.
    CLASS-METHODS create_html_70  RETURNING VALUE(html) TYPE string.
    CLASS-METHODS create_html_702 RETURNING VALUE(html) TYPE string.
    CLASS-METHODS create_html_740 RETURNING VALUE(html) TYPE string.

    CLASS-METHODS get_width
      RETURNING
        VALUE(width) TYPE i .
    CLASS-METHODS get_iso_langu
      IMPORTING
        !langu           TYPE t002-spras
      RETURNING
        VALUE(iso_langu) TYPE t002-laiso .
ENDCLASS.



CLASS CL_DEMO_STRING_PROCESSING IMPLEMENTATION.


  METHOD create_html_70.
    DATA iso_langu TYPE t002-laiso.
    DATA width     TYPE i.
    DATA length1   TYPE i.
    DATA length2   TYPE i.
    DATA buffer    TYPE c LENGTH 100.
    DATA buffer1   TYPE string.
    DATA buffer2   TYPE string.
    DATA result    TYPE i.
    DATA title     TYPE cl_abap_browser=>title.

    iso_langu  = get_iso_langu( sy-langu ).
    CONCATENATE html `<html lang="` iso_langu `">` INTO html.

    CONCATENATE html `<head>` INTO html.
    CONCATENATE html `<meta name="Demo" content="Demo">` INTO html.
    CONCATENATE html `<style type="text/css">` INTO html.
    CONCATENATE html `span.cn {font-family: Courier New;}` INTO html.
    CONCATENATE html `</style>` INTO html.
    CONCATENATE html `</head>` INTO html.
    CONCATENATE html `<body>` INTO html.
    CONCATENATE html `<h3>` text-tit `</h3>` INTO html.
    CONCATENATE html '<span class ="cn">' INTO html.

    width = get_width( ) * 16.
    WRITE width TO buffer LEFT-JUSTIFIED.
    CONCATENATE html `<hr width=` buffer ` align=left>` INTO html.

    length1 = get_width( ) / 2.
    WRITE text-hd1 TO buffer LEFT-JUSTIFIED.
    SHIFT buffer(length1) RIGHT DELETING TRAILING ` `.
    buffer1 = buffer(length1).
    REPLACE ALL OCCURRENCES OF ` ` IN buffer1 WITH '&nbsp;'.
    length2 = get_width( ).
    WRITE text-hd2 TO buffer LEFT-JUSTIFIED.
    SHIFT buffer(length2) RIGHT DELETING TRAILING ` `.
    buffer2 = buffer(length2).
    REPLACE ALL OCCURRENCES OF ` ` IN buffer2 WITH '&nbsp;'.
    CONCATENATE html `<i>` buffer1 buffer2 `</i>` INTO html.

    width = get_width( ) * 16.
    WRITE width TO buffer LEFT-JUSTIFIED.
    CONCATENATE html `<hr width=` buffer ` align=left>` INTO html.

    DO 10 TIMES.

      result = sy-index ** 2.

      length1 = get_width( ) / 2.
      WRITE sy-index TO buffer LEFT-JUSTIFIED.
      SHIFT buffer(length1) RIGHT DELETING TRAILING ` `.
      buffer1 = buffer(length1).
      REPLACE ALL OCCURRENCES OF ` ` IN buffer1 WITH '&nbsp;'.
      length2 = get_width( ).
      WRITE result TO buffer LEFT-JUSTIFIED.
      SHIFT buffer(length2) RIGHT DELETING TRAILING ` `.
      buffer2 = buffer(length2).
      REPLACE ALL OCCURRENCES OF ` ` IN buffer2 WITH '&nbsp;'.
      CONCATENATE html buffer1 buffer2 `<br>` INTO html.

    ENDDO.

    width = get_width( ) * 16.
    WRITE width TO buffer LEFT-JUSTIFIED.
    CONCATENATE html `<hr width=` buffer ` align=left>` INTO html.

    CONCATENATE html '</span>' INTO html.
    CONCATENATE html `</body>` INTO html.
    CONCATENATE html `</html>` INTO html.
  ENDMETHOD.


  METHOD create_html_702.
    html = |<html lang="{ get_iso_langu( sy-langu ) }">|           &&
           `<head>`                                                &&
           `<meta name="Demo" content="Demo">`                     &&
           `<style type="text/css">`                               &&
           `span.cn {font-family: Courier New;}`                   &&
           `</style>`                                              &&
           `</head>`                                               &&
           `<body>`                                                &&
           |<h3>{ text-tit }</h3>|                                 &&
           '<span class ="cn">'                                    &&
           |<hr width={ get_width( ) * 16 } align=left>|           &&
           replace( val = |<i>{ text-hd1
                                  WIDTH = get_width( ) / 2
                                  ALIGN = RIGHT
                                  PAD   = '#' }{
                                text-hd2
                                  WIDTH = get_width( )
                                  ALIGN = RIGHT
                                  PAD   = '#' }</i>|
                             sub  = '#'
                             with = '&nbsp;'
                             occ  = 0 )                            &&
           |<hr width={ get_width( ) * 16 } align=left>|.
    DO 10 TIMES.
      html = html                                                  &&
             replace( val = |{ sy-index
                                 WIDTH = get_width( ) / 2
                                 ALIGN = RIGHT
                                 PAD   = '#' }{
                               sy-index ** 2
                                 WIDTH = get_width( )
                                 ALIGN = RIGHT
                                 PAD   = '#' }<br>|
                      sub  = '#'
                      with = '&nbsp;'
                      occ  = 0 ).
    ENDDO.
    html = html                                                    &&
           |<hr width={ get_width( ) * 16 } align=left>|           &&
           '</span>'                                               &&
           `</body>`                                               &&
           `</html>`.
  ENDMETHOD.


  METHOD create_html_740.
    html = |<html lang="{ get_iso_langu( sy-langu ) }">|           &&
           `<head>`                                                &&
           `<meta name="Demo" content="Demo">`                     &&
           `<style type="text/css">`                               &&
           `span.cn {font-family: Courier New;}`                   &&
           `</style>`                                              &&
           `</head>`                                               &&
           `<body>`                                                &&
           |<h3>{ text-tit }</h3>|                                 &&
           '<span class ="cn">'                                    &&
           |<hr width={ get_width( ) * 16 } align=left>|           &&
           REPLACE( val = |<i>{ text-hd1
                                  WIDTH = get_width( ) / 2
                                  ALIGN = RIGHT
                                  PAD   = '#' }{
                                text-hd2
                                  WIDTH = get_width( )
                                  ALIGN = RIGHT
                                  PAD   = '#' }</i>|
                             sub  = '#'
                             WITH = '&nbsp;'
                             occ  = 0 )                            &&
           |<hr width={ get_width( ) * 16 } align=left>|           &&
           REDUCE string( INIT h TYPE string
                          FOR idx = 1 UNTIL idx > 10
                          NEXT h = h &&
                            REPLACE( val = |{ idx
                                                WIDTH = get_width( ) / 2
                                                ALIGN = right
                                                PAD   = '#'
                                           }{ idx ** 2
                                                WIDTH = get_width( )
                                                ALIGN = right
                                                PAD   = '#' }<br>|
                                     sub  = '#'
                                     WITH = '&nbsp;'
                                     occ  = 0 ) )                  &&
           |<hr width={ get_width( ) * 16 } align=left>|           &&
           '</span>'                                               &&
           `</body>`                                               &&
           `</html>`.
  ENDMETHOD.


  METHOD get_iso_langu.
    SELECT SINGLE laiso
           INTO @iso_langu
           FROM t002
           WHERE spras = @langu.
    IF sy-subrc <> 0 .
      RETURN.
    ENDIF.
  ENDMETHOD.


  METHOD get_width.
    width = 20.
  ENDMETHOD.


  METHOD main.
    DATA(html_70)  = create_html_70( ).
    DATA(html_702) = create_html_702( ).
    DATA(html_740) = create_html_740( ).
    IF html_70  = html_702 AND
       html_702 = html_740.
      cl_abap_browser=>show_html( EXPORTING html_string = html_740 ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
