REPORT demo_ixml_render.

CLASS ixml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS ixml_demo IMPLEMENTATION.
  METHOD main.
    DATA source_tab TYPE TABLE OF i.
    source_tab = VALUE #( FOR j = 1 UNTIL j > 10
                        ( ipow( base = 2 exp = j ) ) ).
    DATA(ixml) = cl_ixml=>create( ).
    DATA(document) = ixml->create_document( ).
    CALL TRANSFORMATION id SOURCE text = `Powers of 2`
                                  numbers = source_tab
                           RESULT XML document.
    DO 7 TIMES.
      document->find_from_name_ns( name = 'item' )->remove_node( ).
    ENDDO.

    DATA(out) = cl_demo_output=>new(
      )->begin_section(
      `Renderer for complete document` ).
    DATA xml_string TYPE string.
    ixml->create_renderer( document = document
                           ostream  = ixml->create_stream_factory(
                                        )->create_ostream_cstring(
                                             string = xml_string )
                                               )->render( ).
    out->write_xml( xml_string )->line( ).

    out->next_section(
       `Method render for complete document` ).
    CLEAR xml_string.
    document->render( ostream  = ixml->create_stream_factory(
                                   )->create_ostream_cstring(
                                        string = xml_string ) ).
    out->write_xml( xml_string )->line( ).

    out->next_section(
      `Method render for subnode recursive` ).
    CLEAR xml_string.
    document->find_from_name_ns( name = 'NUMBERS'
    )->render( ostream  = ixml->create_stream_factory(
                            )->create_ostream_cstring(
                                 string = xml_string )
               recursive = abap_true ).
    out->write( xml_string )->line( ).

    out->next_section(
       `Method render of subnode not recursive` ).
    CLEAR xml_string.
    document->find_from_name_ns( name = 'NUMBERS'
    )->render( ostream  = ixml->create_stream_factory(
                            )->create_ostream_cstring(
                                 string = xml_string )
               recursive = abap_false ).
    out->display( xml_string ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
