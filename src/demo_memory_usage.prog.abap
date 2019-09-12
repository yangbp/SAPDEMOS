REPORT demo_memory_usage.

CLASS lcl DEFINITION.
  PUBLIC SECTION.
    DATA atab TYPE TABLE OF i.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    CONSTANTS n TYPE i VALUE 1000.

    DATA: itab TYPE TABLE OF i,
          dref TYPE REF   TO i,
          rtab TYPE TABLE OF REF TO i,
          ltab TYPE TABLE OF i,
          ttab LIKE TABLE OF ltab,
          oref TYPE REF   TO lcl,
          otab TYPE TABLE OF REF TO lcl.

    FIELD-SYMBOLS <line> TYPE any.

    DO n TIMES.

      APPEND sy-index TO itab.

      CLEAR dref.
      CREATE DATA dref.
      dref->* = sy-index.
      APPEND dref TO rtab.

      CLEAR ltab.
      APPEND sy-index TO ltab.
      APPEND ltab TO ttab.

      CLEAR oref.
      CREATE OBJECT oref.
      APPEND sy-index TO oref->atab.
      APPEND oref TO otab.

    ENDDO.

    BREAK-POINT ##no_break.

    LOOP AT itab ASSIGNING <line>.
      FREE <line>.
    ENDLOOP.

    LOOP AT rtab ASSIGNING <line>.
      FREE <line>.
    ENDLOOP.

    LOOP AT ttab ASSIGNING <line>.
      FREE <line>.
    ENDLOOP.

    LOOP AT otab ASSIGNING <line>.
      FREE <line>.
    ENDLOOP.

    BREAK-POINT ##no_break.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
