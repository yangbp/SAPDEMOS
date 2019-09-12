REPORT demo_local_exception_2.

CLASS cx_local_exception DEFINITION
                         INHERITING FROM cx_static_check.
  PUBLIC SECTION.
    DATA local_text TYPE string.
    METHODS constructor IMPORTING text TYPE string.
ENDCLASS.

CLASS cx_local_exception IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    local_text = text.
  ENDMETHOD.
ENDCLASS.

DATA oref TYPE REF TO cx_local_exception.

START-OF-SELECTION.
  TRY.
      RAISE EXCEPTION TYPE cx_local_exception
        EXPORTING
          text = `Local Exception`.
    CATCH cx_local_exception INTO oref.
      cl_demo_output=>display( oref->local_text ).
  ENDTRY.
