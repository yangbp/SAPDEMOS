REPORT demo_round.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA: BEGIN OF mode,
                  value LIKE cl_abap_math=>round_half_up,
                  name  TYPE abap_attrdescr-name,
                END OF mode,
                modes LIKE SORTED TABLE OF mode
                      WITH UNIQUE KEY name.
    CLASS-METHODS get_modes.
    TYPES:
      BEGIN OF line,
        number          TYPE decfloat34,
        ceiling   TYPE decfloat34,
        down      TYPE decfloat34,
        floor     TYPE decfloat34,
        half_down TYPE decfloat34,
        half_even TYPE decfloat34,
        half_up   TYPE decfloat34,
        up        TYPE decfloat34,
      END OF line.
    CLASS-DATA output TYPE TABLE OF line.
    CLASS-METHODS write_output IMPORTING VALUE(idx) TYPE i
                                         VALUE(col) TYPE i
                                         text       TYPE clike.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA number TYPE decfloat34.
    cl_demo_output=>begin_section( `Rounding Function` ).
    get_modes( ).
    DO 21 TIMES.
      number = - ( sy-index - 11 ) / 10.
      write_output(
        idx = sy-index
        col = '1'
        text = |{ number }| ).
      LOOP AT modes INTO mode.
        write_output(
          idx = sy-index
          col = sy-tabix + 1
          text = |{ round( val  = number
                           dec  = 0
                           mode = mode-value ) }| ).
      ENDLOOP.
    ENDDO.
    cl_demo_output=>display( output ).
  ENDMETHOD.
  METHOD get_modes.
    DATA: modes   TYPE abap_attrdescr_tab,
          mode    LIKE LINE OF modes.
    FIELD-SYMBOLS <mode> LIKE cl_abap_math=>round_half_up.
    modes =
      CAST cl_abap_classdescr(
             cl_abap_classdescr=>describe_by_name( 'CL_ABAP_MATH' )
             )->attributes.
    DELETE modes WHERE name NP 'ROUND_*' OR is_constant <> 'X'.
    LOOP AT modes INTO mode.
      ASSIGN cl_abap_math=>(mode-name) TO <mode>.
      demo=>mode-value = <mode>.
      demo=>mode-name = mode-name.
      INSERT demo=>mode INTO TABLE demo=>modes.
    ENDLOOP.
  ENDMETHOD.
  METHOD write_output.
    ASSIGN output[ idx ] TO FIELD-SYMBOL(<line>).
    IF sy-subrc <> 0.
      DO.
        APPEND INITIAL LINE TO output ASSIGNING <line>.
        IF sy-tabix = idx.
          EXIT.
        ENDIF.
      ENDDO.
    ENDIF.
    ASSIGN COMPONENT col OF STRUCTURE <line> TO FIELD-SYMBOL(<col>).
    <col> = text.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
