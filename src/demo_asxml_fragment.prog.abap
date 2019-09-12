REPORT demo_asxml_fragment.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA out TYPE REF TO if_demo_output.
    CLASS-METHODS prepare_fragment
       RETURNING VALUE(xml) TYPE xstring.
    CLASS-METHODS serialize
      IMPORTING source TYPE any
                node   TYPE string
                trafo  TYPE string
                text   TYPE string
      RETURNING VALUE(result) TYPE xstring.
    CLASS-METHODS deserialize
      IMPORTING source TYPE xstring
                node   TYPE string
                trafo  TYPE string
                text   TYPE string
      EXPORTING result TYPE any.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: xstr    TYPE xstring,
          xsdstr  TYPE xsdany,
          xmlstr1 TYPE xstring,
          xmlstr2 TYPE xstring.

    out = cl_demo_output=>new( ).

    xstr = prepare_fragment( ).

    xmlstr1 = serialize(
      source = xstr
      node   = 'ROOT'
      trafo  = 'ID'
      text =  'XSLT-Serialization of XML-Fragment from XSTRING' ).

    xsdstr = xstr.

    xmlstr1 = serialize(
      source = xsdstr
      node   = 'ROOT'
      trafo  = 'ID'
      text =  'XSLT-Serialization of XML-Fragment from XSDANY' &
              ' into node ROOT' ).

    xmlstr2 = serialize(
      source = xsdstr
      node   = 'X'
      trafo  = 'ID'
      text =  'XSLT-Serialization of XML-Fragment from XSDANY' &
              ' into node X' ).


    deserialize(
      EXPORTING
        source = xmlstr1
        node   = 'ROOT'
        trafo  = 'ID'
        text   = 'XSLT-Deserialization of XSLT-result with node ROOT' &
                 ' into XSTRING'
      IMPORTING result = xstr ).
    deserialize(
      EXPORTING
        source = xmlstr2
        node   = 'X'
        trafo  = 'ID'
        text   = 'XSLT-Deserialization of XSLT-result with node X' &
                 ' into XSTRING'
      IMPORTING result = xstr ).

    deserialize(
      EXPORTING
        source = xmlstr1
        node   = 'ROOT'
        trafo  = 'ID'
        text   = 'XSLT-Deserialization of XSLT-result with node ROOT' &
                 ' into XSDANY'
      IMPORTING result = xsdstr ).
    deserialize(
      EXPORTING
        source = xmlstr2
        node   = 'X'
        trafo  = 'ID'
        text   = 'XSLT-Deserialization of XSLT-result with node X' &
                 ' into XSDANY'
      IMPORTING result = xsdstr ).

    deserialize(
      EXPORTING
        source = xmlstr1
        node   = 'X'
        trafo  = 'ID'
        text   = 'XSLT-Deserialization of XSLT-result with node ROOT' &
                 ' into XSDANY using node X'
      IMPORTING result = xsdstr ).
    deserialize(
      EXPORTING
        source = xmlstr2
        node   = 'ROOT'
        trafo  = 'ID'
        text   = 'XSLT-Deserialization of XSLT-result with node X' &
                 ' into XSDANY using node ROOT'
      IMPORTING result = xsdstr ).

    out->display( ).
  ENDMETHOD.
  METHOD prepare_fragment.
    out->begin_section(
      )->begin_section( 'XML-Fragment' ).
    xml = cl_abap_codepage=>convert_to(
      `<?xml version="1.0" encoding="utf-8" ?>` &&
      `<X>`            &&
      `Text`           &&
      `<X1>Text1</X1>` &&
      `<X2>Text1</X2>` &&
      `</X>` ).
    out->write_xml( xml
      )->end_section( ).
  ENDMETHOD.
  METHOD serialize.
    DATA(source_tab) = VALUE abap_trans_srcbind_tab(
     ( name = node value = REF #( source ) ) ).
    TRY.
        out->begin_section( text ).
        CALL TRANSFORMATION (trafo)
          SOURCE (source_tab)
          RESULT XML result.
        out->write_xml( result ).
      CATCH cx_transformation_error.
        out->write_text( 'Error' ).
    ENDTRY.
    out->end_section( ).
  ENDMETHOD.
  METHOD deserialize.
    DATA(result_tab) = VALUE abap_trans_resbind_tab(
     ( name = node value = REF #( result ) ) ).
    TRY.
        out->begin_section( text ).
        CALL TRANSFORMATION (trafo)
          SOURCE XML source
          RESULT (result_tab)
          OPTIONS clear = 'all'.
        IF result IS NOT INITIAL.
          out->write_xml( result ).
        ELSE.
          out->write_text( 'Initial' ).
        ENDIF.
      CATCH cx_transformation_error.
        out->write_text( 'Error' ).
    ENDTRY.
    out->end_section( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
