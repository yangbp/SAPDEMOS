REPORT demo_is_not_bound.

CLASS cls DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA dref TYPE REF TO i.
    CLASS-METHODS main.
ENDCLASS.

CLASS cls IMPLEMENTATION.
  METHOD main.
    DATA number TYPE i.
    dref = REF #( number ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  cls=>main( ).
  IF cls=>dref IS NOT INITIAL AND
     cls=>dref IS NOT BOUND.
    cl_demo_output=>display(
      'stack reference is not initial but not bound' ).
  ENDIF.
