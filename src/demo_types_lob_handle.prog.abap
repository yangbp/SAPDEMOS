REPORT kellerh_test.

CLASS demo_lob_handles DEFINITION.
  PUBLIC SECTION.
    TYPES:

      lob_handle_structure_1 TYPE demo_lob_table
                             READER FOR COLUMNS clob1 blob1,


      lob_handle_structure_2 TYPE demo_lob_table
                             LOB HANDLE FOR ALL COLUMNS,

      lob_handle_structure_3 TYPE demo_lob_table
                             LOCATOR FOR ALL BLOB COLUMNS
                             WRITER FOR ALL CLOB COLUMNS,

      lob_handle_structure_4 TYPE demo_lob_table
                             READER FOR COLUMNS clob1 clob2
                             LOB HANDLE FOR ALL BLOB COLUMNS
                             LOCATOR FOR ALL OTHER CLOB COLUMNS,

      lob_handle_structure_5 TYPE demo_lob_table
                             READER FOR COLUMNS blob1 blob2 blob3
                             LOCATOR FOR COLUMNS clob1 clob2 clob3
                             LOB HANDLE FOR ALL OTHER COLUMNS,

      lob_handle_structure_6 TYPE demo_lob_table
                             READER FOR COLUMNS blob1
                             LOCATOR FOR COLUMNS blob2
                             LOB HANDLE FOR COLUMNS blob3
                             LOB HANDLE FOR ALL CLOB COLUMNS.

    CLASS-METHODS main.

  PRIVATE SECTION.
    CLASS-DATA out TYPE REF TO if_demo_output.
    CLASS-METHODS output_type IMPORTING struct TYPE string.
ENDCLASS.

CLASS demo_lob_handles IMPLEMENTATION.
  METHOD main.
    out = cl_demo_output=>new( ).
    DO 6 TIMES.
      output_type( |LOB_HANDLE_STRUCTURE_{ sy-index }| ).
    ENDDO.
    out->display( ).
  ENDMETHOD.
  METHOD output_type.
    TYPES: BEGIN OF result,
             component_name TYPE string,
             absolute_name  TYPE string,
           END OF result,
           results TYPE TABLE OF result WITH EMPTY KEY.

    out->next_section( struct
      )->write_data(
           VALUE results(
             FOR component IN CAST cl_abap_structdescr(
               cl_abap_structdescr=>describe_by_name( struct )
                 )->components
             WHERE ( type_kind = cl_abap_typedescr=>typekind_oref )
             ( VALUE #(
                 component_name = component-name
                 absolute_name  = CAST cl_abap_refdescr(
                   cl_abap_typedescr=>describe_by_name(
                     struct && `-` && component-name )
                       )->get_referenced_type(
                       )->absolute_name ) ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo_lob_handles=>main( ).
