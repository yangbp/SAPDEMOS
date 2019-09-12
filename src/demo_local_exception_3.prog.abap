REPORT demo_local_exception_3.

CLASS cx_local_exception DEFINITION
                         INHERITING FROM cx_sy_arithmetic_error.
  PUBLIC SECTION.
    METHODS constructor IMPORTING situation TYPE string.
ENDCLASS.

CLASS cx_local_exception IMPLEMENTATION.
  METHOD constructor.
    super->constructor( operation = situation ).
  ENDMETHOD.
ENDCLASS.

DATA oref TYPE REF TO cx_local_exception.
DATA text TYPE string.

START-OF-SELECTION.
  TRY.
      RAISE EXCEPTION TYPE cx_local_exception
        EXPORTING
          situation = `START-OF-SELECTION`.
    CATCH cx_local_exception INTO oref.
      text = oref->get_text( ).
      cl_demo_output=>display( text ).
  ENDTRY.
