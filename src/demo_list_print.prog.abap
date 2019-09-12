REPORT demo_list_print LINE-COUNT 10 LINE-SIZE 50.

DATA params LIKE pri_params.
DATA valid  TYPE c LENGTH 1.

PARAMETERS para TYPE c LENGTH 1.

CLASS print_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS print IMPORTING text TYPE string.
ENDCLASS.

INITIALIZATION.

  CALL FUNCTION 'GET_PRINT_PARAMETERS'
    EXPORTING
      destination    = 'LOCL'
      immediately    = ' '
      no_dialog      = 'X'
      line_count     = 10
      line_size      = 50
    IMPORTING
      out_parameters = params
      valid          = valid.

  IF valid <> 'X'.
    LEAVE PROGRAM.
  ENDIF.

  params-prtxt = 'Parameter 1'.
  CALL FUNCTION 'SET_PRINT_PARAMETERS'
    EXPORTING
      in_parameters = params.

START-OF-SELECTION.

  WRITE / 'AAAA'.

  params-prtxt = 'Parameter 2'.
  NEW-PAGE PRINT ON PARAMETERS params NO DIALOG.

  WRITE / 'BBBB'.

  CALL SCREEN 100.

  WRITE / 'GGGG'.

  NEW-PAGE PRINT OFF.

  WRITE / 'HHHH'.

MODULE status_0100 OUTPUT.

  SUPPRESS DIALOG.
  LEAVE TO LIST-PROCESSING AND RETURN TO SCREEN 0.

  WRITE / 'CCCC'.

  params-prtxt = 'Parameter 3'.
  NEW-PAGE PRINT ON PARAMETERS params NO DIALOG.
  WRITE / 'DDDD'.
  print_demo=>print( 'EEEE' ).
  NEW-PAGE PRINT OFF.

  WRITE / 'FFFF'.

ENDMODULE.

CLASS print_demo IMPLEMENTATION.
  METHOD print.

    params-prtxt = 'Parameter 4'.
    TRY.
        NEW-PAGE PRINT ON PARAMETERS params NO DIALOG.
      CATCH cx_sy_nested_print_on.
        NEW-PAGE PRINT ON PARAMETERS params NO DIALOG NEW-SECTION.
    ENDTRY.
    WRITE / text.
    NEW-PAGE PRINT OFF.

  ENDMETHOD.
ENDCLASS.
