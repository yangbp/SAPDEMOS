REPORT demo_st_format_option.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      call_transformation
        CHANGING writer TYPE REF TO cl_sxml_string_writer.
    CLASS-DATA:
      boolean        TYPE abap_bool,
      hex            TYPE xstring VALUE '0123456789ABCDEF',
      datetime       TYPE timestamp,
      datetime_long  TYPE timestampl,
      datetimeoffset TYPE c LENGTH 18,
      datetimelocal  TYPE c LENGTH 14,
      guid_16        TYPE x LENGTH 16,
      guid_32        TYPE c LENGTH 32,
      guid_22        TYPE c LENGTH 22,
      qname1         TYPE string VALUE `{uri_1}name1`,
      qname2         TYPE string VALUE `{uri_2}name2`,
      uri            TYPE string VALUE `:;<=>?[\]^_``{|}~`,
      uri1           TYPE string VALUE `Rock'n'Roll & Blues`,
      language       TYPE sy-langu VALUE 'E',
      currcode       TYPE tcurc-waers VALUE 'EUR',
      unitcode       TYPE t006-msehi VALUE 'TON',
      number         TYPE p DECIMALS 3 VALUE '123.000',
      numtext        TYPE n LENGTH 10 VALUE '0000123456'.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    GET TIME STAMP FIELD datetime.
    GET TIME STAMP FIELD datetime_long.
    datetimeoffset = |{ datetime WIDTH = 14 }+180|.
    datetimelocal = datetime.

    DATA(system_uuid) = cl_uuid_factory=>create_system_uuid( ).
    TRY.
        guid_16 = system_uuid->create_uuid_x16( ).
        guid_32 = system_uuid->create_uuid_c32( ).
        guid_22 = system_uuid->create_uuid_c22( ).
      CATCH cx_uuid_error.
        CLEAR guid_16.
        CLEAR guid_32.
        CLEAR guid_22.
    ENDTRY.

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
    CALL TRANSFORMATION demo_st_format_option
      SOURCE boolean        = boolean
             hex            = hex
             time           = sy-timlo
             date           = sy-datlo
             datetime       = datetime
             datetime_long  = datetime_long
             datetimeoffset = datetimeoffset
             datetimelocal  = datetimelocal
             guid_16        = guid_16
             guid_32        = guid_32
             guid_22        = guid_22
             qname1         = qname1
             qname2         = qname2
             uri            = uri
             urifull        = uri
             uri1           = uri1
             language       = language
             currcode       = currcode
             unitcode       = unitcode
             number         = number
             numtext        = numtext
      RESULT XML writer.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
