REPORT demo_st_decimals_option.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      call_transformation
        CHANGING writer TYPE REF TO cl_sxml_string_writer.
    CLASS-DATA:
      integer   TYPE i            VALUE 1234,
      pack      TYPE p DECIMALS 4 VALUE '1234.5678',
      decf      TYPE decfloat34   VALUE '1234.5678',
      binf      TYPE f            VALUE '1234.5678',
      timestmpl TYPE timestampl,
      datetimel TYPE xsddatetime_long_z.

ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    GET TIME STAMP FIELD timestmpl.
    datetimel = timestmpl.

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
    CALL TRANSFORMATION demo_st_decimals_option
      SOURCE integer      = integer
             pack         = pack
             decf         = decf
             binf         = binf
             timestmpl    = timestmpl
             datetimel    = datetimel
      RESULT XML writer.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
