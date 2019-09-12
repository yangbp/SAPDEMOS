REPORT demo_local_exception_1.

CLASS cx_local_exception DEFINITION
                         INHERITING FROM cx_static_check.
ENDCLASS.

START-OF-SELECTION.
  TRY.
      RAISE EXCEPTION TYPE cx_local_exception.
    CATCH cx_local_exception.
      cl_demo_output=>display( 'Local Exception!' ).
  ENDTRY.
