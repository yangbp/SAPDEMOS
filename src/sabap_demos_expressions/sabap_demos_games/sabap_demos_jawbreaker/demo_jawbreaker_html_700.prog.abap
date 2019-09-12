PROGRAM demo_jawbreaker_html_700.

CLASS game DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor,
      display.
  PRIVATE SECTION.
    TYPES:
      t_vector TYPE STANDARD TABLE OF i
               WITH NON-UNIQUE DEFAULT KEY,
      t_matrix TYPE STANDARD TABLE OF t_vector
               WITH NON-UNIQUE DEFAULT KEY,
      BEGIN OF t_coord,
        x TYPE i,
        y TYPE i,
      END OF t_coord.
    DATA:
      n      TYPE i,
      field  TYPE t_matrix,
      moves  TYPE i,
      filled TYPE i,
      colors TYPE TABLE OF string WITH DEFAULT KEY,
      header TYPE cl_abap_browser=>html_table.
    METHODS:
      at_click FOR EVENT sapevent OF cl_abap_browser IMPORTING action,
      delete IMPORTING VALUE(cursor) TYPE t_coord
                       VALUE(color)  TYPE i OPTIONAL,
      slide,
      append_line IMPORTING VALUE(line) TYPE string
                  CHANGING  html        TYPE STANDARD TABLE .
ENDCLASS.

CLASS game IMPLEMENTATION.
  METHOD constructor.
    DATA:
      size      TYPE i VALUE 5,
      column    TYPE t_vector,
      rnd_color TYPE REF TO cl_abap_random_int,
      seed      TYPE i,
      ci        TYPE i,
      cs        TYPE string,
      cc        TYPE c LENGTH 1,
      wh        TYPE string VALUE `width:18px;height:18px`.

    APPEND: `lightblue` TO colors, `cornflowerblue` TO colors,
            `darkblue`  TO colors, `steelblue` TO colors.

    APPEND: '<html><head><style type="text/css">' TO header,
            `.bx{text-decoration:none;cursor:hand;` TO header,
             wh TO header,
             `}  a{` TO header,
             wh TO header,
             `}` TO header.
    LOOP AT colors INTO cs.
      WRITE sy-tabix TO cc.
      CONCATENATE '.c' cc '{background-color:' cs '}' INTO cs.
      APPEND cs TO header.
    ENDLOOP.
    APPEND '</style></head><body leftmargin="35"' &
           ' topmargin="60" scroll="no"><table border="0">' TO header.

    cl_demo_input=>request( CHANGING field = size ).
    IF size < 2.
      n = 2.
    ELSEIF size > 15.
      n = 15.
    ELSE.
      n = size.
    ENDIF.

    seed = sy-uzeit.
    rnd_color = cl_abap_random_int=>create( seed = seed
                                            min  = 1
                                            max = 4 ).

    DO n TIMES.
      CLEAR column.
      DO n TIMES.
        ci = rnd_color->get_next( ).
        INSERT ci INTO TABLE column.
      ENDDO.
      INSERT column INTO TABLE field.
    ENDDO.

    filled = n * n.
    SET HANDLER at_click.
  ENDMETHOD.

  METHOD display.
    DATA:
      x     TYPE i,
      y     TYPE i,
      title TYPE cl_abap_browser=>title,
      html  TYPE cl_abap_browser=>html_table,
      line  LIKE LINE OF html,
      box   TYPE string,
      cc    TYPE c LENGTH 1,
      xn    TYPE n LENGTH 2,
      yn    TYPE n LENGTH 2.
    FIELD-SYMBOLS:
      <column> LIKE LINE OF field,
      <color>  TYPE i.

    IF filled = 0.
      WRITE me->moves TO line LEFT-JUSTIFIED.
      CONCATENATE `Finished in ` line ` moves!` INTO line ##NO_TEXT.
      APPEND line TO html.

    ELSE.
      html = header.

      DO n TIMES.
        y = sy-index.
        box = '<tr>'.
        DO n TIMES.
          x = sy-index.
          READ TABLE field INDEX x ASSIGNING <column>.
          READ TABLE <column> INDEX y ASSIGNING <color>.
          IF <color> <> 0.
            cc = <color>.
            xn = x.
            yn = y.
            CONCATENATE box
             '<td class=c' cc '>'
             '<a href="sapevent:x' xn 'y' yn '">'
             '<div class="bx"/></a></td>' INTO box.
          ELSE.
            CONCATENATE box '<td><a/></td>' INTO box.
          ENDIF.
        ENDDO.
        CONCATENATE box '</tr>' INTO box.
        append_line( EXPORTING line = box
                     CHANGING  html = html ).
      ENDDO.

      APPEND '</table></body></html>' TO html.
    ENDIF.

    title = sy-title.
    cl_abap_browser=>show_html(
      html  = html
      title = title
      size  = cl_abap_browser=>small
      format = cl_abap_browser=>portrait  context_menu = 'X' ).
  ENDMETHOD.

  METHOD at_click.
    DATA cursor TYPE t_coord.
    moves = moves + 1.
    cursor-x = action+1(2).
    cursor-y = action+4(2).
    delete( cursor ).
    slide( ).
    display( ).
  ENDMETHOD.

  METHOD delete.
    FIELD-SYMBOLS:
      <column> LIKE LINE OF field,
      <color>  TYPE i.

    CHECK cursor-x >= 1 AND cursor-x <= n AND
          cursor-y >= 1 AND cursor-y <= n.
    READ TABLE field INDEX cursor-x ASSIGNING <column>.
    READ TABLE <column> INDEX cursor-y ASSIGNING <color>.
    IF color IS NOT SUPPLIED.
      color = <color>.
    ELSEIF <color> <> color OR color = 0.
      RETURN.
    ENDIF.
    <color> = 0.
    filled = filled - 1.

    DATA next TYPE t_coord.
    next-x = cursor-x - 1.
    next-y = cursor-y.
    delete( cursor = next color = color ).  " left
    next-x = cursor-x + 1.
    delete( cursor = next color = color ).  " right
    next-x = cursor-x .
    next-y = cursor-y - 1.
    delete( cursor = next color = color ).  " up
    next-y = cursor-y + 1.
    delete( cursor = next color = color ).  " down
  ENDMETHOD.

  METHOD slide.
    DATA:
      rest   TYPE t_vector,
      zeroed TYPE i,
      i      TYPE i.
    FIELD-SYMBOLS:
      <column> LIKE LINE OF field,
      <color>  TYPE i.
    LOOP AT field ASSIGNING <column>.
      CLEAR rest.
      LOOP AT <column> ASSIGNING <color> WHERE table_line <> 0.
        APPEND <color> TO rest.
      ENDLOOP.
      zeroed = n - lines( rest ).
      LOOP AT <column> ASSIGNING <color>.
        IF sy-tabix <= zeroed.
          <color> = 0.
        ELSE.
          i = sy-tabix - zeroed.
          READ TABLE rest INDEX i INTO <color>.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD append_line.
    DATA html_line TYPE LINE OF cl_abap_browser=>html_table.
    DATA length TYPE i.
    DATA pos TYPE i.
    DESCRIBE FIELD html_line LENGTH length IN CHARACTER MODE.
    pos = strlen( line ).
    WHILE pos > length.
      APPEND line(length) TO html.
      SHIFT line LEFT BY length PLACES.
      SUBTRACT length FROM pos.
    ENDWHILE.
    APPEND line TO html.
  ENDMETHOD.

ENDCLASS.

DATA:
  my_game TYPE REF TO game.

START-OF-SELECTION.
  CREATE OBJECT my_game.
  my_game->display( ).
