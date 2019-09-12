REPORT demo_event_inheritance.

CLASS c1 DEFINITION.
  PUBLIC SECTION.
    CLASS-EVENTS  ce1.
    CLASS-METHODS cm1.
    EVENTS  ie1.
    METHODS im1.
ENDCLASS.

CLASS c2 DEFINITION INHERITING FROM c1.
  PUBLIC SECTION.
    CLASS-METHODS cm2.
    METHODS im2.
ENDCLASS.

CLASS c3 DEFINITION INHERITING FROM c2.
  PUBLIC SECTION.
    CLASS-METHODS cm3.
    METHODS im3.
ENDCLASS.

CLASS c4 DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS cm4 FOR EVENT ce1 OF c2.
    METHODS im4 FOR EVENT ie1 OF c2.
ENDCLASS.

CLASS event_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA handle_flag TYPE c LENGTH 1.
    CLASS-METHODS main.
ENDCLASS.

CLASS event_demo IMPLEMENTATION.
  METHOD main.

    DATA oref1 TYPE REF TO c1.
    DATA oref2 TYPE REF TO c2.
    DATA oref3 TYPE REF TO c3.
    DATA oref4 TYPE REF TO c4.

    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'Static event' ).
    SET HANDLER c4=>cm4.
    c1=>cm1( ).
    out->write( |c1=>cm1( ): { handle_flag }| ).
    c2=>cm1( ).
    out->write( |c2=>cm1( ): { handle_flag }| ).
    c3=>cm1( ).
    out->write( |c3=>cm1( ): { handle_flag }| ).
    c2=>cm2( ).
    out->write( |c2=>cm2( ): { handle_flag }| ).
    c3=>cm2( ).
    out->write( |c3=>cm2( ): { handle_flag }| ).
    c3=>cm3( ).
    out->write( |c3=>cm3( ): { handle_flag }| ).

    out->next_section( 'Instance event' ).
    CREATE OBJECT: oref1, oref2, oref3, oref4.
    SET HANDLER oref4->im4 FOR ALL INSTANCES.
    oref1->im1( ).
    out->write( |oref1->im1( ): { handle_flag }| ).
    oref2->im1( ).
    out->write( |oref2->im1( ): { handle_flag }| ).
    oref3->im1( ).
    out->write( |oref3->im1( ): { handle_flag }| ).
    oref2->im2( ).
    out->write( |oref2->im2( ): { handle_flag }| ).
    oref3->im2( ).
    out->write( |oref3->im2( ): { handle_flag }| ).
    oref3->im3( ).
    out->write( |oref3->im3( ): { handle_flag }| ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  event_demo=>main( ).

CLASS c1 IMPLEMENTATION.
  METHOD cm1.
    CLEAR event_demo=>handle_flag.
    RAISE EVENT ce1.
  ENDMETHOD.
  METHOD im1.
    CLEAR event_demo=>handle_flag.
    RAISE EVENT ie1.
  ENDMETHOD.
ENDCLASS.

CLASS c2 IMPLEMENTATION.
  METHOD cm2.
    CLEAR event_demo=>handle_flag.
    RAISE EVENT ce1.
  ENDMETHOD.
  METHOD im2.
    CLEAR event_demo=>handle_flag.
    RAISE EVENT ie1.
  ENDMETHOD.
ENDCLASS.

CLASS c3 IMPLEMENTATION.
  METHOD cm3.
    CLEAR event_demo=>handle_flag.
    RAISE EVENT ce1.
  ENDMETHOD.
  METHOD im3.
    CLEAR event_demo=>handle_flag.
    RAISE EVENT ie1.
  ENDMETHOD.
ENDCLASS.

CLASS c4 IMPLEMENTATION.
  METHOD cm4.
    event_demo=>handle_flag = 'X'.
  ENDMETHOD.
  METHOD im4.
    event_demo=>handle_flag = 'X'.
  ENDMETHOD.
ENDCLASS.
