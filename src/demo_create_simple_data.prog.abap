REPORT demo_create_simple_data.

CLASS create_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS create_data IMPORTING
                                VALUE(typ) TYPE c
                                VALUE(len) TYPE i
                                VALUE(dec) TYPE i
                              RETURNING
                                VALUE(dref) TYPE REF TO data
                              RAISING cx_sy_create_data_error.
ENDCLASS.

CLASS create_demo IMPLEMENTATION.
  METHOD main.
    DATA dref TYPE REF TO data.
    FIELD-SYMBOLS <fs> TYPE any.


    DATA: type     LENGTH 10 TYPE c,
          length   TYPE i,
          decimals TYPE i.

    cl_demo_input=>add_field( EXPORTING text  = `Builtin ABAP Type`
                              CHANGING  field = type ).
    cl_demo_input=>add_field( EXPORTING text  = `Length`
                              CHANGING  field = length ).
    cl_demo_input=>request(   EXPORTING text  = `Decimals`
                              CHANGING  field = decimals ).

    TRY.
        IF to_lower( type ) = 'p' AND decimals > 2 * length - 1.
          "Would lead to undefined state for packed number
          RAISE EXCEPTION TYPE cx_sy_create_data_error.
        ENDIF.
        dref = create_data( typ = type
                            len = length
                            dec = decimals ).
        ASSIGN dref->* TO <fs>.
        DESCRIBE FIELD <fs> TYPE type
                            LENGTH length IN BYTE MODE
                            DECIMALS decimals.
        cl_demo_output=>display( |{ type } { length } { decimals }| ).
      CATCH cx_sy_create_data_error.
        cl_demo_output=>display( |Error creating { type } {
                                                   length } {
                                                   decimals }| ).
    ENDTRY.
  ENDMETHOD.
  METHOD create_data.
    TRANSLATE typ TO LOWER CASE.
    CASE typ.
      WHEN 'd' OR 'decfloat16' OR 'decfloat34' OR 'f' OR 'i'
               OR 'string' OR 't' OR 'xstring'.
        CREATE DATA dref TYPE (typ).
      WHEN 'c' OR 'n' OR 'x'.
        CREATE DATA dref TYPE (typ) LENGTH len.
      WHEN 'p'.
        CREATE DATA dref TYPE p LENGTH len DECIMALS dec.
      WHEN OTHERS.
        RAISE EXCEPTION TYPE cx_sy_create_data_error.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  create_demo=>main( ).
