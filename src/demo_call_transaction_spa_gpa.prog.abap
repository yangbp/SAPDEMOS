REPORT demo_call_transaction_spa_gpa.

PARAMETERS: carrid TYPE spfli-carrid,
            connid TYPE spfli-connid.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    SET PARAMETER ID: 'CAR' FIELD carrid,
                      'CON' FIELD connid.
    TRY.
        CALL TRANSACTION 'DEMO_TRANSACTION' WITH AUTHORITY-CHECK.
      CATCH cx_sy_authorization_error.
        RETURN.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
