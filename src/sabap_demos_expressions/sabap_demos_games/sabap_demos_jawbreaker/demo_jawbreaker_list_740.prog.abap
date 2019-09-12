REPORT demo_jawbreaker_list_740 NO STANDARD PAGE HEADING.

CLASS game DEFINITION.
  PUBLIC SECTION.
    METHODS:
      init,
      display,
      click.
  PRIVATE SECTION.
    TYPES:
      blocks_one_dim TYPE STANDARD TABLE OF i
                          WITH EMPTY KEY,
      blocks_two_dim TYPE STANDARD TABLE OF blocks_one_dim
                          WITH EMPTY KEY,
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
    field = VALUE #(
      LET r = cl_abap_random_int=>create( seed = CONV i( sy-uzeit )
                                          min  = 1
                                          max  = 4 ) IN
                     FOR i = 1 UNTIL i > 15
                     ( VALUE #( FOR j = 1 UNTIL j > 15
                                ( r->get_next( ) ) ) ) ).
  ENDMETHOD.

  METHOD display.
    sy-lsind = 0.
    SET BLANK LINES ON.

    DO 15 TIMES.
      DATA(y) = 16 - sy-index.
      DO 15 TIMES.
        DATA(x) = sy-index.
        DATA(color) = field[ x ][ y ].
        IF color <> 0.
          WRITE '  ' COLOR = color NO-GAP HOTSPOT ON.
          DATA(is_not_yet_finished) = abap_true.
        ELSE.
          WRITE '  ' COLOR = color NO-GAP.
        ENDIF.
      ENDDO.
      NEW-LINE.
    ENDDO.
    IF is_not_yet_finished = abap_false.
      WRITE: / 'Finished with', (3) clicks, 'clicks!'.
    ENDIF.
  ENDMETHOD.

  METHOD click.
    clicks = clicks + 1.
    delete( VALUE #( x = ( sy-cucol - 1 ) / 2
                     y = 16 - sy-curow ) ).
    slide( ).
    display( ).
  ENDMETHOD.

  METHOD delete.
    IF cursor-x < 1 OR cursor-x > 15 OR
       cursor-y < 1 OR cursor-y > 15.
      RETURN.
    ENDIF.

    ASSIGN field[ cursor-x ][ cursor-y ] TO FIELD-SYMBOL(<color>).
    IF color IS NOT SUPPLIED.
      color = <color>.
    ELSEIF <color> <> color OR color = 0.
      RETURN.
    ENDIF.
    <color> = 0.

    delete( cursor = VALUE #( x = cursor-x - 1
                              y = cursor-y ) color = color ).
    delete( cursor = VALUE #( x = cursor-x + 1
                              y = cursor-y ) color = color ).
    delete( cursor = VALUE #( x = cursor-x
                              y = cursor-y - 1 ) color = color ).
    delete( cursor = VALUE #( x = cursor-x
                              y = cursor-y + 1 ) color = color ).
  ENDMETHOD.

  METHOD slide.
    DO 15 TIMES.
      ASSIGN field[ sy-index ] TO FIELD-SYMBOL(<column>).
      DATA(offset) = 0.
      DO 15 TIMES.
        ASSIGN <column>[ sy-index ] TO FIELD-SYMBOL(<color>).
        IF <color> = 0.
          offset = offset + 1.
        ELSEIF offset <> 0.
          <column>[ sy-index - offset ] = <color>.
        ENDIF.
      ENDDO.
      DO offset TIMES.
        <column>[ 16 - sy-index ] = 0.
      ENDDO.
    ENDDO.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  DATA(my_game) = NEW game( ).
  my_game->init( ).
  my_game->display( ).

AT LINE-SELECTION.
  my_game->click( ).
