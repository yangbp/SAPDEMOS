REPORT demo_output_stream.

***********************************************************************
* Demonstrates the different possibilites for accessing               *
* CL_DEMO_OUTPUT_STREAM                                               *
***********************************************************************

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF struct,
        col1 TYPE c LENGTH 3,
        col2 TYPE c LENGTH 3,
      END OF struct,
      itab TYPE STANDARD TABLE OF struct
           WITH EMPTY KEY.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    "Example data
    DATA(itab) = VALUE itab( ( col1 = 'a11'  col2 = 'b12' )
                             ( col1 = 'a21'  col2 = 'b22' )  ).

    "XML data from CL_DEMO_OUTPUT_STREAM
    DATA(stream) = cl_demo_output_stream=>open( ).
    stream->write_text( iv_text   = 'XML of CL_DEMO_OUTPUT_STREAM'
                        iv_format = if_demo_output_formats=>heading
                        iv_level  = 1 ).
    stream->write_data( ia_value  = itab
                        iv_format = if_demo_output_formats=>nonprop ).
    DATA(xml) = stream->close( ).
    cl_abap_browser=>show_xml( xml_xstring = xml ).

    "HTML output with CL_DEMO_OUTPUT_STREAM
    stream = cl_demo_output_stream=>open( ).
    SET HANDLER cl_demo_output_html=>handle_output FOR stream.
    stream->write_text( iv_text   = 'CL_DEMO_OUTPUT_STREAM for HTML'
                        iv_format = if_demo_output_formats=>heading
                        iv_level  = 1 ).
    stream->write_data( ia_value  = itab
                        iv_format = if_demo_output_formats=>nonprop ).
    stream->close( ).
    SET HANDLER cl_demo_output_html=>handle_output FOR stream
                                                   ACTIVATION ' '.

    "Text output with CL_DEMO_OUTPUT_STREAM
    stream = cl_demo_output_stream=>open( ).
    SET HANDLER cl_demo_output_text=>handle_output FOR stream.
    stream->write_text( iv_text   = 'CL_DEMO_OUTPUT_STREAM for Text' ).
    stream->write_data( ia_value  = itab ).
    stream->close( ).
    SET HANDLER cl_demo_output_text=>handle_output FOR stream
                                                   ACTIVATION ' '.

    "HTML output with static method of CL_DEMO_OUTPUT
    cl_demo_output=>begin_section( 'Static Method of CL_DEMO_OUTPUT for HTML' ).
    cl_demo_output=>display( itab ).

    "Text output with static method of CL_DEMO_OUTPUT
    cl_demo_output=>set_mode( cl_demo_output=>text_mode ).
    cl_demo_output=>begin_section( 'Static Method of CL_DEMO_OUTPUT for Text' ).
    cl_demo_output=>display( itab ).

    "HTML output with instance method of CL_DEMO_OUTPUT
    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'Instance Method of CL_DEMO_OUTPUT for HTML'
      )->write( itab )->display( ).

    "Text output with instance method of CL_DEMO_OUTPUT
    out = cl_demo_output=>new( cl_demo_output=>text_mode
      )->begin_section( 'Instance Method of CL_DEMO_OUTPUT for Text'
      )->write( itab )->display( ).

    "HTML data from CL_DEMO_OUTPUT with static method GET
    cl_demo_output=>set_mode( cl_demo_output=>html_mode ).
    cl_demo_output=>begin_section( 'Static Method of CL_DEMO_OUTPUT for getting HTML' ).
    cl_demo_output=>write( itab ).
    DATA(html) = cl_demo_output=>get( ).
    cl_abap_browser=>show_html( html_string = html ).

    "Text data from CL_DEMO_OUTPUT with static method GET
    cl_demo_output=>set_mode( cl_demo_output=>text_mode ).
    cl_demo_output=>begin_section( 'Static Method of CL_DEMO_OUTPUT for getting Text' ).
    cl_demo_output=>write( itab ).
    DATA(text) = cl_demo_output=>get( ).
    cl_demo_text=>display_string( text ).

    "HTML data from CL_DEMO_OUTPUT with instance method GET
    out = cl_demo_output=>new(
      )->begin_section( 'Instance Method of CL_DEMO_OUTPUT for getting HTML'
      )->write( itab ).
    html = out->get( ).
    cl_abap_browser=>show_html( html_string = html ).

    "Text data from CL_DEMO_OUTPUT with instance method GET
    out = cl_demo_output=>new( cl_demo_output=>text_mode
      )->begin_section( 'Instance Method of CL_DEMO_OUTPUT for getting Text'
      )->write( itab ).
    text = out->get( ).
    cl_demo_text=>display_string( text ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
