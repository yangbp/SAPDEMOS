REPORT  demo_assign_increment.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA assign TYPE c LENGTH 1 VALUE '1'.
    cl_demo_input=>request(
      EXPORTING text  = `ASSIGN statement (1 to 6)`
      CHANGING  field = assign ).

    DATA: BEGIN OF struc,
            word TYPE c LENGTH 4 VALUE 'abcd',
            int1 TYPE i          VALUE 111,
            int2 TYPE i          VALUE 222,
            stri TYPE string     VALUE `efgh`,
          END OF struc.

    FIELD-SYMBOLS: <word> LIKE struc-word,
                   <int>  TYPE i.

    CASE assign.
      WHEN '1'. "-> sy-subrc 0
        ASSIGN struc-word INCREMENT 1 TO <word> RANGE struc.
      WHEN '2'. "-> Runtime error
        ASSIGN struc-word INCREMENT 1 TO <int>  RANGE struc.
      WHEN '3'. "-> Runtime error
        ASSIGN struc-word INCREMENT 2 TO <word> RANGE struc.
      WHEN '4'. "-> Runtime error
        ASSIGN struc-word INCREMENT 2 TO <int>  RANGE struc.
      WHEN '5'. "-> sy-subrc 4
        ASSIGN struc-word INCREMENT 3 TO <word> RANGE struc.
      WHEN '6'. "-> sy-subrc 4
        ASSIGN struc-word INCREMENT 3 TO <int>  RANGE struc.
      WHEN OTHERS.
        cl_demo_output=>display( 'Enter a number between 1 and 6' ).
        RETURN.
    ENDCASE.

    cl_demo_output=>write( |sy-subrc: { sy-subrc }| ).
    IF <word> IS ASSIGNED OR <int> IS ASSIGNED.
      cl_demo_output=>write( 'Field symbol is assigned' ).
    ENDIF.
    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
