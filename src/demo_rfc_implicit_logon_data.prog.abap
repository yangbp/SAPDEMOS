REPORT demo_rfc_implicit_logon_data.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      BEGIN OF logon_data,
        uname       TYPE sy-uname,
        mandt       TYPE sy-mandt,
        logon_langu TYPE sy-langu,
        langu       TYPE sy-langu,
      END OF logon_data.

    IF cl_abap_syst=>get_logon_language( ) <> 'E'.
      SET LOCALE LANGUAGE 'E'.
    ELSE.
      SET LOCALE LANGUAGE 'D'.
    ENDIF.

    logon_data = VALUE #(
        uname       = sy-uname
        mandt       = sy-mandt
        logon_langu = cl_abap_syst=>get_logon_language( )
        langu       = cl_abap_syst=>get_language( ) ).
    ASSERT logon_data-langu = sy-langu.

    DATA(out) = cl_demo_output=>new(
      )->next_section( 'Parameters of Caller'
      )->write( logon_data ).

    CALL FUNCTION 'DEMO_RFM_LOGON_DATA' DESTINATION 'NONE'
      IMPORTING
        uname       = logon_data-uname
        mandt       = logon_data-mandt
        logon_langu = logon_data-logon_langu
        langu       = logon_data-langu.

    out->next_section( 'Parameters of Callee'
      )->write( logon_data )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
