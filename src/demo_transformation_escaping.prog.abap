REPORT demo_transformation_escaping.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA xml TYPE string.

    DATA(text) = `<>&"`.

    DATA(out) = cl_demo_output=>new(
      )->begin_section( `Text`
      )->write( text

      )->next_section( `XSLT`

      )->begin_section( `<xsl:output method="text" />` ).
    CALL TRANSFORMATION demo_escaping_text SOURCE text = text
                                           RESULT XML xml.
    out->write( xml

      )->next_section( `<xsl:output method="xml" />` ).
    CALL TRANSFORMATION demo_escaping_xml SOURCE text = text
                                          RESULT XML xml.
    out->write( xml

      )->next_section( `<xsl:output method="html" />` ).
    CALL TRANSFORMATION demo_escaping_html SOURCE text = text
                                           RESULT XML xml.
    out->write( xml

      )->next_section( `<xsl:output method="html" />` ).
    CALL TRANSFORMATION demo_escaping_js SOURCE text = text
                                         RESULT XML xml.
    out->write( xml
      )->end_section(

      )->next_section( `ST` ).
    CALL TRANSFORMATION demo_escaping_st SOURCE text = text
                                         RESULT XML xml.
    out->write( xml ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
