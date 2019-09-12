PROGRAM demo_jawbreaker_html_740.

CLASS game DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor,
      display.
  PRIVATE SECTION.
    TYPES:
      t_vector TYPE STANDARD TABLE OF i WITH EMPTY KEY,
      t_matrix TYPE STANDARD TABLE OF t_vector WITH EMPTY KEY,
      BEGIN OF coord,
        x TYPE i,
        y TYPE i,
      END OF coord.
    DATA:
      n      TYPE i,
      field  TYPE t_matrix,
      moves  TYPE i,
      filled TYPE i,
      colors TYPE TABLE OF string WITH EMPTY KEY,
      header TYPE string.
    METHODS:
      at_click FOR EVENT sapevent OF cl_abap_browser IMPORTING action,
      delete IMPORTING VALUE(cursor) TYPE coord
                       VALUE(color) TYPE i OPTIONAL,
      slide.
ENDCLASS.

CLASS game IMPLEMENTATION.
  METHOD constructor.
    DATA(wh) = `width:18px;height:18px`.
    colors = VALUE #( ( `lightblue`)
                      ( `cornflowerblue`)
                      ( `darkblue`)
                      ( `steelblue`) ).
    header = `<html><head><style type="text/css">` &
             `.bx{text-decoration:none;cursor:hand;` &&
             wh && `} a{` && wh && `}` &&
              REDUCE string(
               INIT s = `` FOR co IN colors INDEX INTO ci
               NEXT s = |{ s }.c{ ci }\{background-color:{ co }\}| ) &&
                        `</style></head><body leftmargin="35" ` &
                        `topmargin="60" scroll="no">` &
                        `<table border="0">`.

    DATA(size) = 5.
    cl_demo_input=>request( CHANGING field = size ).
    n = COND #( WHEN size < 2
                  THEN 2
                WHEN size > 15
                  THEN 15
                  ELSE size ).

    field = VALUE #( LET r = cl_abap_random_int=>create(
                               seed = CONV i( sy-uzeit )
                               min  = 1
                               max = lines( colors ) ) IN
                     FOR i = 1 UNTIL i > n
                     ( VALUE #( FOR j = 1 UNTIL j > n
                                ( r->get_next( ) ) ) ) ).
    filled = n * n.
    SET HANDLER at_click.
  ENDMETHOD.

  METHOD display.
    cl_abap_browser=>show_html(
     title        = CONV cl_abap_browser=>title( sy-title )
     size         = cl_abap_browser=>small
     format       = cl_abap_browser=>portrait
     context_menu = 'X'
     html_string  = COND #( WHEN filled > 0 THEN
       REDUCE string(
        INIT  h = header
        FOR   y = 1  UNTIL y > n
        NEXT  h = h && `<tr>` &&
         REDUCE string( INIT k = ``
          FOR  x = 1  UNTIL x > n
          LET  c = field[ x ][ y ] IN
          NEXT k = k &&
                   COND #( WHEN c = 0
                             THEN `<td><a/></td>`
                             ELSE |<td class=c{ c }>| &
                                  |<a href="sapevent:| &
                                  |x{ x WIDTH = 2
                                        ALIGN = right
                                        PAD   = '0' }| &
                                  |y{ y WIDTH = 2
                                        ALIGN = right
                                        PAD    = '0' }">| &
                                  |<div class="bx"/></a></td>| ) )
         && `</tr>` )
       && `</table></body></html>`
      ELSE |Finished in { moves } moves!| )
    ).
  ENDMETHOD.

  METHOD at_click.
    moves = moves + 1.
    delete( VALUE #( x = CONV i( action+1(2) )
                     y = CONV i( action+4(2) ) ) ).
    slide( ).
    display( ).
  ENDMETHOD.

  METHOD delete.
    CHECK cursor-x >= 1 AND cursor-x <= n AND
          cursor-y >= 1 AND cursor-y <= n.
    ASSIGN field[ cursor-x ][ cursor-y ] TO FIELD-SYMBOL(<color>).
    IF color IS NOT SUPPLIED.
      color = <color>.
    ELSEIF <color> <> color OR color = 0.
      RETURN.
    ENDIF.
    <color> = 0.
    filled = filled - 1.

    delete( cursor = VALUE #( x = cursor-x - 1
                              y = cursor-y ) color = color ). "left
    delete( cursor = VALUE #( x = cursor-x + 1
                              y = cursor-y ) color = color ). "right
    delete( cursor = VALUE #( x = cursor-x
                              y = cursor-y - 1 ) color = color ). "up
    delete( cursor = VALUE #( x = cursor-x
                              y = cursor-y + 1 ) color = color ). "down
  ENDMETHOD.

  METHOD slide.
    field = VALUE #( LET fld = field IN
      FOR <column> IN fld
        LET rest = VALUE t_vector(
                      FOR j IN <column>
                      WHERE ( table_line <> 0 ) ( j ) )
            zeroed = n - lines( rest ) IN
        ( VALUE t_vector( FOR k = 1 UNTIL k > n
                          ( COND #( WHEN k <= zeroed THEN 0
                                    ELSE rest[ k - zeroed ] ) ) ) ) ).
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  NEW game( )->display( ).
