REPORT demo_rfc_exceptions.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA msg TYPE c LENGTH 255.

    DATA(out) = cl_demo_output=>new( ).

    "Classical exception handling
    CALL FUNCTION 'DEMO_RFM_CLASSIC_EXCEPTION'
      DESTINATION 'NONE'
      EXCEPTIONS
        system_failure        = 1  MESSAGE msg
        communication_failure = 2  MESSAGE msg
        OTHERS                = 3.
    CASE sy-subrc.
      WHEN 1.
        out->write( |EXCEPTION SYSTEM_FAILURE | && msg ).
      WHEN 2.
        out->write( |EXCEPTION COMMUNICATION_FAILURE | && msg ).
      WHEN 3.
        out->write( |EXCEPTION OTHERS| ).
    ENDCASE.

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
