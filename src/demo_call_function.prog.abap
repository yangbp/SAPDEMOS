REPORT demo_call_function.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: itab TYPE spfli_tab,
          jtab TYPE spfli_tab.

    DATA carrier TYPE s_carr_id VALUE 'LH'.
    cl_demo_input=>request( CHANGING field = carrier ).

    DATA(out) = cl_demo_output=>new( ).

    CALL FUNCTION 'READ_SPFLI_INTO_TABLE'
      EXPORTING
        id        = carrier
      IMPORTING
        itab      = itab
      EXCEPTIONS
        not_found = 4.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              INTO DATA(msg).
      out->write( msg ).
    ENDIF.

    TRY.
        CALL FUNCTION 'READ_SPFLI_INTO_TABLE_NEW'
          EXPORTING
            id   = carrier
          IMPORTING
            itab = jtab.
      CATCH cx_no_flight_found INTO DATA(exc).
        out->write( exc->get_text( ) ).
    ENDTRY.

    ASSERT itab = jtab.
    out->display( itab ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
