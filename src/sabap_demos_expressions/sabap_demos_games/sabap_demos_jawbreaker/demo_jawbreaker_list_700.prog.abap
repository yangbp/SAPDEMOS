REPORT demo_jawbreaker_list_700 NO STANDARD PAGE HEADING.

CLASS game DEFINITION.
  PUBLIC SECTION.
    METHODS:
      init,
      display,
      click.
  PRIVATE SECTION.
    TYPES:
      blocks_one_dim TYPE STANDARD TABLE OF i
                     WITH NON-UNIQUE DEFAULT KEY,
      blocks_two_dim TYPE STANDARD TABLE OF blocks_one_dim
                     WITH NON-UNIQUE DEFAULT KEY,
      BEGIN OF coord,
        x TYPE i,
        y TYPE i,
      END OF coord.
    DATA:
      field  TYPE blocks_two_dim,
      clicks TYPE i.
    METHODS:
      delete IMPORTING VALUE(cursor) TYPE coord
                       VALUE(color) TYPE i OPTIONAL,
      slide.
ENDCLASS.

CLASS game IMPLEMENTATION.
  METHOD init.
    DATA:
      column    TYPE blocks_one_dim,
      rnd_color TYPE REF TO cl_abap_random_int,
      seed      TYPE i,
      color     TYPE i.

    seed = sy-uzeit.
    rnd_color = cl_abap_random_int=>create( seed = seed
                                            min  = 1
                                            max  = 4 ).

    DO 15 TIMES.
      CLEAR column.
      DO 15 TIMES.
        color = rnd_color->get_next( ).
        INSERT color INTO TABLE column.
      ENDDO.
      INSERT column INTO TABLE field.
    ENDDO.
  ENDMETHOD.

  METHOD display.
    DATA:
      x                   TYPE i,
      y                   TYPE i,
      is_not_yet_finished TYPE abap_bool.
    FIELD-SYMBOLS:
      <column> LIKE LINE OF field,
      <color>  TYPE i.

    sy-lsind = 0.
    SET BLANK LINES ON.

    DO 15 TIMES.
      y = 16 - sy-index.
      DO 15 TIMES.
        x = sy-index.
        READ TABLE field INDEX x ASSIGNING <column>.
        READ TABLE <column> INDEX y ASSIGNING <color>.
        IF <color> <> 0.
          WRITE '  ' COLOR = <color> NO-GAP HOTSPOT ON.
          is_not_yet_finished = abap_true.
        ELSE.
          WRITE '  ' COLOR = <color> NO-GAP.
        ENDIF.
      ENDDO.
      NEW-LINE.
    ENDDO.
    IF is_not_yet_finished = abap_false.
      WRITE: / 'Finished with', (3) clicks, 'clicks!'.
    ENDIF.
  ENDMETHOD.

  METHOD click.
    DATA:
      cursor TYPE coord.

    cursor-x = ( sy-cucol - 1 ) / 2.
    cursor-y = 16 - sy-curow.

    clicks = clicks + 1.

    delete( cursor ).
    slide( ).
    display( ).
  ENDMETHOD.

  METHOD delete.
    DATA:
      next TYPE coord.
    FIELD-SYMBOLS:
      <column> LIKE LINE OF field,
      <color>  TYPE i.

    IF cursor-x < 1 OR cursor-x > 15 OR
       cursor-y < 1 OR cursor-y > 15.
      RETURN.
    ENDIF.

    READ TABLE field INDEX cursor-x ASSIGNING <column>.
    READ TABLE <column> INDEX cursor-y ASSIGNING <color>.
    IF color IS NOT SUPPLIED.
      color = <color>.
    ELSEIF <color> <> color OR color = 0.
      RETURN.
    ENDIF.
    <color> = 0.

    next = cursor.
    next-x = next-x - 1.
    delete( cursor = next color = color ).

    next = cursor.
    next-x = next-x + 1.
    delete( cursor = next color = color ).

    next = cursor.
    next-y = next-y - 1.
    delete( cursor = next color = color ).

    next = cursor.
    next-y = next-y + 1.
    delete( cursor = next color = color ).

  ENDMETHOD.

  METHOD slide.
    DATA:
      x      TYPE i,
      y      TYPE i,
      offset TYPE i.
    FIELD-SYMBOLS:
      <column>  LIKE LINE OF field,
      <color>   TYPE i,
      <move_to> TYPE i.

    DO 15 TIMES.
      x = sy-index.
      READ TABLE field INDEX x ASSIGNING <column>.
      CLEAR offset.
      DO 15 TIMES.
        y = sy-index.
        READ TABLE <column> INDEX y ASSIGNING <color>.
        IF <color> = 0.
          offset = offset + 1.
        ELSEIF offset <> 0.
          y = y - offset.
          READ TABLE <column> INDEX y ASSIGNING <move_to>.
          <move_to> = <color>.
        ENDIF.
      ENDDO.
      DO offset TIMES.
        y = 16 - sy-index.
        READ TABLE <column> INDEX y ASSIGNING <color>.
        <color> = 0.
      ENDDO.
    ENDDO.
  ENDMETHOD.

ENDCLASS.

DATA:
  my_game TYPE REF TO game.

START-OF-SELECTION.
  CREATE OBJECT my_game.
  my_game->init( ).
  my_game->display( ).

AT LINE-SELECTION.
  my_game->click( ).
