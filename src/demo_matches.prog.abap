REPORT demo_matches.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA email TYPE string VALUE `abc.def@ghi.jkl`.
    cl_demo_input=>request( CHANGING field = email ).
    IF matches( val   = email
                regex = `\w+(\.\w+)*@(\w+\.)+((\l|\u){2,4})` ).
      cl_demo_output=>display( 'Format OK' ).
    ELSEIF matches(
             val   = email
             regex = `[[:alnum:],!#\$%&'\*\+/=\?\^_``\{\|}~-]+`     &
                    `(\.[[:alnum:],!#\$%&'\*\+/=\?\^_``\{\|}~-]+)*` &
                    `@[[:alnum:]-]+(\.[[:alnum:]-]+)*`              &
                    `\.([[:alpha:]]{2,})` ).
      cl_demo_output=>display( 'Syntax OK but unusual' ).
    ELSE.
      cl_demo_output=>display( 'Wrong format!' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
