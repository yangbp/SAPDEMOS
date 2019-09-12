REPORT demo_ixml_parsing.

CLASS ixml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS
      main.
  PRIVATE SECTION.
    CLASS-DATA out TYPE REF TO if_demo_output.
    CLASS-METHODS:
      process_errors
        IMPORTING parser TYPE REF TO if_ixml_parser,
      process_dom
        IMPORTING document TYPE REF TO if_ixml_node.
ENDCLASS.

CLASS ixml_demo IMPLEMENTATION.
  METHOD main.
    DATA(ixml) = cl_ixml=>create( ).
    DATA(stream_factory) = ixml->create_stream_factory( ).
    DATA(document) = ixml->create_document( ).
    DATA(parser) = ixml->create_parser(
      document = document
      stream_factory = stream_factory
      istream = stream_factory->create_istream_string( string =
        `<?xml version="1.0"?>` &&
        `<order number="4711">` &&
        ` <head>` &&
        ` <status>confirmed</status>` &&
        ` <date format="mm-dd-yyyy">07-19-2012</date>` &&
        ` </head>` &&
        ` <body>` &&
        ` <item units="2" price="17.00">Part No. 0110</item>` &&
        ` <item units="1" price="10.50">Part No. 1609</item>` &&
        ` <item units="5" price="12.30">Part No. 1710</item>` &&
        ` </body>` &&
        `</order>` ) ).
    IF parser->parse( ) <> 0.
      process_errors( parser ).
    ELSE.
      process_dom( document ).
    ENDIF.
    out->display( ).
  ENDMETHOD.
  METHOD process_dom.
    IF document IS INITIAL.
      RETURN.
    ENDIF.
    out = cl_demo_output=>new(
      )->begin_section( 'DOM Tree' ).
    DATA(iterator) = document->create_iterator( ).
    DATA(node) = iterator->get_next( ).
    WHILE NOT node IS INITIAL.
      DATA(indent) = node->get_height( ) * 2.
      CASE node->get_type( ).
        WHEN if_ixml_node=>co_node_element.
          DATA(attributes) = node->get_attributes( ).
          out->write( |Element:{ repeat( val = ` `
                                         occ = indent + 2  )
                              }{ node->get_name( ) }| ).
          IF NOT attributes IS INITIAL.
            DO attributes->get_length( ) TIMES.
              DATA(attr) = attributes->get_item( sy-index - 1 ).
              out->write( |Attribute:{ repeat( val = ` `
                                               occ = indent )
                                     }{ attr->get_name( ) } = {
                                        attr->get_value( ) } | ).
            ENDDO.
          ENDIF.
        WHEN if_ixml_node=>co_node_text OR
        if_ixml_node=>co_node_cdata_section.
          out->write( |Text:{ repeat( val = ` ` occ = indent + 5 )
                           }{ node->get_value( ) }| ).
      ENDCASE.
      node = iterator->get_next( ).
    ENDWHILE.
  ENDMETHOD.
  METHOD process_errors.
    DO parser->num_errors(
         min_severity = if_ixml_parse_error=>co_warning ) TIMES.
      IF parser->get_error(
           index = sy-index - 1
           min_severity =  if_ixml_parse_error=>co_warning
             )->get_severity( ) = if_ixml_parse_error=>co_warning.
        out->write_text( parser->get_error(
          index = sy-index - 1
          min_severity = if_ixml_parse_error=>co_warning
            )->get_reason( ) ).
      ELSE.
        out->write_text( parser->get_error(
          index = sy-index - 1
          min_severity = if_ixml_parse_error=>co_warning
            )->get_reason( ) ).
      ENDIF.
    ENDDO.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
