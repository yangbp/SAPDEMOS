REPORT demo_abap_xml_schema_mapping.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: uuid        TYPE xsduuid_char,
          uuid1       TYPE xsduuid_char,
          uuid2       TYPE xsduuid_char,
          exc_trafo   TYPE REF TO cx_transformation_error,
          exc_prev    TYPE REF TO cx_root.

    FIELD-SYMBOLS <uuid> TYPE sysuuid_c32.

    TRY.
        uuid = cl_uuid_factory=>create_system_uuid(
          )->create_uuid_c32( ).
        ASSIGN uuid TO <uuid>.
        CALL TRANSFORMATION id SOURCE uuid1 = uuid
                                      uuid2 = <uuid>
                               RESULT XML DATA(xml_xstring).
       cl_abap_browser=>show_xml( xml_xstring = xml_xstring ).
      CATCH cx_uuid_error.
        RETURN.
      CATCH cx_transformation_error.
        RETURN.
    ENDTRY.

    TRY.
        CALL TRANSFORMATION demo_uuid SOURCE XML xml_xstring
                                      RESULT uuid1 = uuid1
                                             uuid2 = uuid2.
      CATCH cx_transformation_error INTO exc_trafo.
        MESSAGE exc_trafo TYPE 'I' DISPLAY LIKE 'E'.
        IF exc_trafo->previous IS NOT INITIAL.
          exc_prev = exc_trafo->previous.
          MESSAGE exc_prev TYPE 'I' DISPLAY LIKE 'E'.
        ENDIF.
    ENDTRY.
    MESSAGE `UUID1 = ` && uuid1 TYPE 'I'.
    MESSAGE `UUID2 = ` && uuid2 TYPE 'I'.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
