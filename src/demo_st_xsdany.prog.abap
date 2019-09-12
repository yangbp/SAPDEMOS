REPORT demo_st_xsdany.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA out TYPE REF TO if_demo_output.
    CLASS-METHODS prepare_fragment
       RETURNING VALUE(xml) TYPE xsdany.
    CLASS-METHODS serialize
      IMPORTING source TYPE xsdany
                trafo  TYPE string
                text   TYPE string
      RETURNING VALUE(result) TYPE xstring.
    CLASS-METHODS deserialize
      IMPORTING source TYPE xstring
                trafo  TYPE string
                text   TYPE string.
    CLASS-METHODS invoke_deserialization
      IMPORTING source TYPE xstring
                text   TYPE string.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    out = cl_demo_output=>new( ).

    DATA(xsdstr) = prepare_fragment( ).

    DATA(xmlstr1) = serialize(
      source = xsdstr
      trafo  = 'DEMO_ST_XSDANY'
      text =  'ST-Serialization of XML-Fragment' ).
    DATA(xmlstr2) = serialize(
      source = xsdstr
      trafo  = 'DEMO_ST_XSDANY_LAX'
      text =  'Lax ST-Serialization of XML-Fragment' ).
    DATA(xmlstr3) = serialize(
      source = xsdstr
      trafo  = 'DEMO_ST_XSDANY_NO_ROOT'
      text =  'noRoot-ST-Serialization of XML-Fragment' ).
    DATA(xmlstr4) = serialize(
      source = xsdstr
      trafo  = 'DEMO_ST_XSDANY_LAX_NO_ROOT'
      text =  'Lax noRoot-ST-Serialization of XML-Fragment' ).
    out->line( ).

    invoke_deserialization( source = xmlstr1
                            text   = `` ).
    invoke_deserialization( source = xmlstr2
                            text   = `lax ` ).
    invoke_deserialization( source = xmlstr3
                            text   = `noRoot-` ).
    invoke_deserialization( source = xmlstr4
                            text   = `lax noRoot-` ).

    out->display( ).
  ENDMETHOD.
  METHOD prepare_fragment.
    out->begin_section( 'XML-Fragment' ).
    xml = cl_abap_codepage=>convert_to(
          `<?xml version="1.0" encoding="utf-8" ?>` &&
          `<X>`              &&
            `Text`           &&
            `<X1>Text1</X1>` &&
            `<X2>Text1</X2>` &&
          `</X>` ).
    out->write_xml( xml )->line( ).
  ENDMETHOD.
  METHOD serialize.
    TRY.
        out->begin_section( text ).
        CALL TRANSFORMATION (trafo)
          SOURCE root = source
          RESULT XML result.
        out->write_xml( result ).
      CATCH cx_transformation_error.
        out->write_text( 'Error' ).
    ENDTRY.
    out->end_section( ).
  ENDMETHOD.
  METHOD deserialize.
    DATA result TYPE xsdany.
    TRY.
        out->begin_section( text ).
        CALL TRANSFORMATION (trafo)
          SOURCE XML source
          RESULT root = result
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
  METHOD invoke_deserialization.
    deserialize(
  EXPORTING
    source = source
    trafo  = 'DEMO_ST_XSDANY'
    text   = `ST-Deserialization of `
             && text && `ST-result` ).
    deserialize(
      EXPORTING
        source = source
        trafo  = 'DEMO_ST_XSDANY_LAX'
        text   = `Lax ST-Deserialization of `
                 && text && `ST-result` ).
    deserialize(
      EXPORTING
        source = source
        trafo  = 'DEMO_ST_XSDANY_NO_ROOT'
        text   = `noRoot-ST-Deserialization of `
                 && text && `ST-result` ).
    deserialize(
      EXPORTING
        source = source
        trafo  = 'DEMO_ST_XSDANY_LAX_NO_ROOT'
        text   = `Lax noRoot-ST-Deserialization of `
                 && text && `ST-result` ).
    out->line( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
