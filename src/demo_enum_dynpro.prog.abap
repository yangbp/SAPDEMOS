REPORT demo_enum_dynpro.

TYPES:
  basetype TYPE c LENGTH 1,
  BEGIN OF ENUM size BASE TYPE basetype,
    i VALUE IS INITIAL,
    s VALUE 'S',
    l VALUE 'M',
    m VALUE 'L',
  END OF ENUM size.

DATA size TYPE size VALUE s.

DATA ok_code TYPE sy-ucomm.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    CALL SCREEN 100.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN100'.
ENDMODULE.

MODULE user_command_0100 INPUT.
  IF ok_code IS NOT INITIAL.
    LEAVE PROGRAM.
  ELSE.
    cl_demo_output=>display(
      |Size: { CONV basetype( size )
      }\n{ COND string( WHEN strlen(
             CONV string( size ) ) > 1 THEN size
             ELSE `` ) }| ).
  ENDIF.
  CLEAR ok_code.
ENDMODULE.
