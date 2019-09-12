REPORT demo_describe_enums.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    TYPES:
      BEGIN OF ENUM size,
        s, m, l, xl, xxl,
      END OF ENUM size.

    DATA(size) = VALUE size( ).

    out->begin_section( 'DESCRIBE FIELD' ).

    DESCRIBE FIELD size TYPE DATA(type)
                        LENGTH DATA(length) IN BYTE MODE
                        OUTPUT-LENGTH DATA(output_length).

    out->write_data( type
      )->write_data( length
      )->write_data( output_length ).

    out->next_section( 'CL_ABAP_ENUMDESCR' ).

    DATA(enum_descr) = CAST cl_abap_enumdescr(
      cl_abap_typedescr=>describe_by_data( size ) ).

    out->write_data( enum_descr->kind
      )->write_data( enum_descr->type_kind
      )->write_data( enum_descr->base_type_kind
      )->write_data( enum_descr->members ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
