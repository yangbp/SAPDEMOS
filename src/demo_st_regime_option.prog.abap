REPORT demo_st_regime_option.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      call_transformation
        CHANGING writer TYPE REF TO cl_sxml_string_writer.
    CLASS-DATA:
      time    TYPE t,
      boolean TYPE xsdboolean,
      numtext TYPE n LENGTH 3.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    time = sy-timlo.
    boolean = abap_true.
    numtext = '255'.

    DATA(out) = cl_demo_output=>new( )->next_section( 'XML' ).
    DATA(writer) = cl_sxml_string_writer=>create(
            type = if_sxml=>co_xt_xml10 ).
    call_transformation( CHANGING writer = writer ).
    DATA(result) = writer->get_output( ).
    out->write_xml( result
       )->next_section( 'JSON' ).
    writer = cl_sxml_string_writer=>create(
      type = if_sxml=>co_xt_json ).
    call_transformation( CHANGING writer = writer ).
    result = writer->get_output( ).
    out->write_json( result
      )->display( ).
  ENDMETHOD.
  METHOD call_transformation.
    CALL TRANSFORMATION demo_st_regime_option
      SOURCE time    = time
             boolean = boolean
             numtext = numtext
    result xml writer.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
