REPORT demotexteduce_text.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES strings TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    DATA(words) = VALUE strings(
      ( `All` )
      ( `ABAP` )
      ( `constructs` )
      ( `are` )
      ( `imperative` ) ).
    cl_demo_output=>write( words ).

    "Table comprehension into helper table
    DATA(switched_words) = VALUE strings(
          FOR word IN words
           ( SWITCH #( word WHEN `All`        THEN `Some`
                            WHEN `imperative` THEN `functional`
                            ELSE word ) ) ).
    cl_demo_output=>write_data( switched_words ).

    "Table reduction of helper table
    DATA(sentence) =
      REDUCE string( INIT text = `` sep = ``
        FOR word IN switched_words
        NEXT text = |{ text }{ sep }{ word }| sep = ` ` ) && '.'.
    cl_demo_output=>write_data( sentence ).

    "Obfuscation - all in one
    ASSERT sentence =
      REDUCE string( INIT text = `` sep = ``
        "Table reduction
        FOR word IN VALUE strings(
          "Table comprehension
          FOR word IN words
           ( SWITCH #( word WHEN `All`        THEN `Some`
                            WHEN `imperative` THEN `functional`
                            ELSE word ) ) )
        NEXT text = |{ text }{ sep }{ word }| sep = ` ` ) && '.'.

    cl_demo_output=>display(  ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
