REPORT demo_get_nametab.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA typename TYPE typename.
    cl_demo_input=>request( EXPORTING text = `Dictionary Type`
                            CHANGING  field = typename ).
    typename = to_upper( typename ).

    cl_abap_typedescr=>describe_by_name(
      EXPORTING  p_name         = typename
      RECEIVING  p_descr_ref    = DATA(tdescr)
      EXCEPTIONS type_not_found = 4 ).
    IF sy-subrc <> 0.
      cl_demo_output=>display( `Type ` && typename && ` not found` ).
      RETURN.
    ENDIF.

    DATA(header) = tdescr->get_ddic_header( ). "Nametab header
    DATA(fields) = tdescr->get_ddic_object( ). "Nametab field descr

    DATA(out) = cl_demo_output=>new(
      )->begin_section( `Nametab for ` && typename
      )->write( header
      )->write( fields
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
