REPORT demo_asxml_id_vs_st LINE-SIZE 160 NO STANDARD PAGE HEADING.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: str TYPE string,
          xml TYPE string,
          len TYPE i.

    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'XSLT ID' ).
    str = `     `.
    len = strlen( str ).
    out->write_text( |String length before: { len }| ).
    CALL TRANSFORMATION id SOURCE node = str
                           RESULT XML xml.
    out->write_xml( xml ).
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT node = str.
    len = strlen( str ).
    out->write_text( |String length after: { len }| ).

    out->next_section( 'ST tt:copy' ).
    str = `     `.
    len = strlen( str ).
    out->write_text( |String length before: { len }| ).
    CALL TRANSFORMATION demo_asxml_copy SOURCE root = str
                                        RESULT XML xml.
    out->write_xml( xml ).
    CALL TRANSFORMATION demo_asxml_copy SOURCE XML xml
                                        RESULT root = str.
    len = strlen( str ).
    out->write_text( |String length after: { len }|
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
