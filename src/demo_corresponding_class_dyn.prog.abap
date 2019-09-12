REPORT demo_corresponding_class_dyn.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES:
      BEGIN OF names,
        n1 TYPE c LENGTH 2,
        n2 TYPE c LENGTH 2,
        n3 TYPE c LENGTH 2,
      END OF names.

    DATA:
      BEGIN OF struct1,
        a1 TYPE string VALUE 'a1',
        a2 TYPE string VALUE 'a2',
        a3 TYPE string VALUE 'a3',
      END OF struct1,
      BEGIN OF struct2,
        b1 TYPE string VALUE 'b1',
        b2 TYPE string VALUE 'b2',
        b3 TYPE string VALUE 'b3',
      END OF struct2.

    DATA(src) = VALUE names( n1 = 'a1' n2 = 'a2' n3 = 'a3').
    DATA(dst) = VALUE names( n1 = 'b3' n2 = 'b2' n3 = 'b1').

    cl_demo_input=>new(
      )->add_field( CHANGING field = src-n1
      )->add_field( CHANGING field = dst-n1
      )->add_line(
      )->add_field( CHANGING field = src-n2
      )->add_field( CHANGING field = dst-n2
      )->add_line(
      )->add_field( CHANGING field = src-n3
      )->add_field( CHANGING field = dst-n3
      )->request( ).

    TRY.
        DATA(mapper) =
          cl_abap_corresponding=>create(
            source      = struct1
            destination = struct2
            mapping     = VALUE cl_abap_corresponding=>mapping_table(
              ( level = 0 kind = 1 srcname = src-n1 dstname = dst-n1 )
              ( level = 0 kind = 1 srcname = src-n2 dstname = dst-n2 )
              ( level = 0 kind = 1 srcname = src-n3 dstname = dst-n3 )
            ) ).

        mapper->execute( EXPORTING source      = struct1
                         CHANGING  destination = struct2 ).
      CATCH cx_corr_dyn_error INTO DATA(exc).
        cl_demo_output=>display( exc->get_text( ) ).
    ENDTRY.

    cl_demo_output=>display( struct2 ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
