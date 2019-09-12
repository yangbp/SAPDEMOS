REPORT demo_sxml_trafo_from_reader.

CLASS sxml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS sxml_demo IMPLEMENTATION.
  METHOD main.

    DATA(xml) = cl_abap_codepage=>convert_to(
      `<document>` &&
      `  <head>` &&
      `    <author>KELLERH</author>` &&
      `    <date>20120824</date>` &&
      `  </head>` &&
      `  <body>` &&
      `    <asx:abap` &&
      `      xmlns:asx="http://www.sap.com/abapxml" version="1.0">` &&
      `      <asx:values>` &&
      `        <TABLE>` &&
      `          <item>1</item>` &&
      `          <item>2</item>` &&
      `          <item>3</item>` &&
      `        </TABLE>` &&
      `      </asx:values>` &&
      `    </asx:abap>` &&
      `  </body>` &&
      `</document>` ).

    DATA(reader) =
      CAST if_sxml_reader( cl_sxml_string_reader=>create( xml ) ).

    WHILE reader->name <> 'body'.
      reader->next_node( ).
    ENDWHILE.

    DATA itab TYPE TABLE OF i.
    CALL TRANSFORMATION id SOURCE XML reader
                           RESULT table = itab.
    cl_demo_output=>display( itab ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  sxml_demo=>main( ).
