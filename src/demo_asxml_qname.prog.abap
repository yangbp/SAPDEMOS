REPORT demo_asxml_qname.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: name1  TYPE string,
          name2  TYPE string,
          qname1 TYPE xsdqname,
          qname2 TYPE xsdqname.

    DATA xmlstring TYPE string.

    name1 = qname1 = '{test_uri}Value1'.
    name2 = qname2 = '{test_uri}Value2'.

    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'Serialization of Strings' ).
    CALL TRANSFORMATION id SOURCE test1 = name1
                                  test2 = name2
                           RESULT XML xmlstring.
    out->write_xml( xmlstring ).

    out->next_section( 'Serialization of XSDQNAME' ).
    CALL TRANSFORMATION id SOURCE test1 = qname1
                                  test2 = qname2
                           RESULT XML xmlstring.
    out->write_xml( xmlstring ).

    out->next_section( 'Source for Deserialization' ).
    xmlstring =
    `<?xml version="1.0" encoding="utf-8" ?>`   &&
    `<asx:abap `                                &&
      `xmlns:asx="http://www.sap.com/abapxml" ` &&
      `xmlns:demox="my_uri"  version="1.0">`    &&
    `<asx:values >`                             &&
    `<TEST1>demox:Value1</TEST1>`               &&
    `<TEST2>Value2</TEST2>`                     &&
    `</asx:values>`                             &&
    `</asx:abap>`.
    out->write_xml( xmlstring ).

    out->next_section( 'Deserialization' ).
    CALL TRANSFORMATION id SOURCE XML xmlstring
                           RESULT test1 = name1
                                  test2 = name2.
    CALL TRANSFORMATION id SOURCE XML xmlstring
                           RESULT test1 = qname1
                                  test2 = qname2.
    out->display(
      |{ name1  WIDTH = 20 }{ name2  WIDTH = 20 }| & |\n| &
      |{ qname1 WIDTH = 20 }{ qname2 WIDTH = 20 }| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
