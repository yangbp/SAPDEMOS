REPORT demo_sql_expr_literal.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA carrier TYPE scarr-carrid.
    cl_demo_input=>request( CHANGING field = carrier ).

    SELECT SINGLE @abap_true
           FROM scarr
           WHERE carrid = @carrier
           INTO @DATA(exists).
      IF exists = abap_true.
        cl_demo_output=>display(
          |Carrier { carrier } exists in SCARR| ).
      ELSE.
        cl_demo_output=>display(
          |Carrier { carrier } does not exist in SCARR| ).
      ENDIF.
    ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
