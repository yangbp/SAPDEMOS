REPORT demo_json_oo_writer.

CLASS json_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA writer TYPE REF TO if_sxml_writer.
    CLASS-METHODS write_element IMPORTING name TYPE string
                                          attr TYPE string OPTIONAL
                                          value TYPE string OPTIONAL
                                RAISING cx_sxml_state_error.
ENDCLASS.

CLASS json_demo IMPLEMENTATION.
  METHOD main.
    writer =
      CAST if_sxml_writer(
             cl_sxml_string_writer=>create(
               type = if_sxml=>co_xt_json  ) ).
    TRY.
        write_element( name  = 'object' ).
        write_element( name  = 'str'    attr = 'order'
                       value = '4711' ).
        writer->close_element( ).
        write_element( name  = 'object' attr = 'head' ).
        write_element( name  = 'str'    attr = 'status'
                       value = 'confirmed' ).
        writer->close_element( ).
        write_element( name  = 'str'    attr = 'date'
                       value = '07-19-2012' ).
        writer->close_element( ).
        writer->close_element( ).
        write_element( name  = 'object' attr = 'body' ).
        write_element( name  = 'object' attr = 'item' ).
        write_element( name  = 'str'    attr = 'units'
                       value = '2' ).
        writer->close_element( ).
        write_element( name  = 'str'    attr = 'price'
                       value = '17.00' ).
        writer->close_element( ).
        write_element( name  = 'str'    attr = 'Part No.'
                       value = '0110' ).
        writer->close_element( ).
        writer->close_element( ).
        write_element( name  = 'object' attr = 'item' ).
        write_element( name  = 'str'    attr = 'units'
                       value = '1' ).
        writer->close_element( ).
        write_element( name  = 'str'    attr = 'price'
                       value = '10.50' ).
        writer->close_element( ).
        write_element( name  = 'str'    attr = 'Part No.'
                       value = '1609' ).
        writer->close_element( ).
        writer->close_element( ).
        write_element( name  = 'object' attr = 'item' ).
        write_element( name  = 'str'    attr = 'units'
                       value = '5' ).
        writer->close_element( ).
        write_element( name  = 'str'    attr = 'price'
                       value = '12.30' ).
        writer->close_element( ).
        write_element( name  = 'str'    attr = 'Part No.'
                       value = '1710' ).
        writer->close_element( ).
        writer->close_element( ).
        writer->close_element( ).
        writer->close_element( ).
      CATCH cx_sxml_state_error INTO DATA(error).
        cl_demo_output=>display( error->get_text( ) ).
        RETURN.
    ENDTRY.
    DATA(json) =
      CAST cl_sxml_string_writer( writer )->get_output(  ).
    cl_demo_output=>display_json( json ).
  ENDMETHOD.
  METHOD write_element.
    writer->open_element( name = name ).
    IF attr IS NOT INITIAL.
      writer->write_attribute( name = 'name' value = attr ).
    ENDIF.
    IF value IS NOT INITIAL.
      writer->write_value( value = value ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  json_demo=>main( ).
