REPORT demo_create_data_via_handle.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: struct_type TYPE REF TO cl_abap_structdescr,
          dref        TYPE REF TO data,
          oref        TYPE REF TO cx_sy_struct_creation.

    DATA column1 TYPE c LENGTH 30.
    DATA column2 TYPE c LENGTH 30.

    FIELD-SYMBOLS: <struc>  TYPE any,
                   <comp1>  TYPE any,
                   <comp2>  TYPE any.

    cl_demo_input=>add_field( CHANGING field = column1 ).
    cl_demo_input=>add_field( CHANGING field = column2 ).
    cl_demo_input=>request( ).

    column1 = to_upper( column1 ).
    column2 = to_upper( column2 ).

    TRY.
        struct_type = cl_abap_structdescr=>get(
          VALUE #(
            ( name = column1 type = cl_abap_elemdescr=>get_c( 40 ) )
            ( name = column2 type = cl_abap_elemdescr=>get_i( )    )
                 )
                                               ).
        CREATE DATA dref TYPE HANDLE struct_type.
      CATCH cx_sy_struct_creation INTO oref.
        cl_demo_output=>display( oref->get_text( ) ).
        RETURN.
    ENDTRY.

    ASSIGN dref->* TO <struc>.
    ASSIGN COMPONENT column1 OF STRUCTURE <struc> TO <comp1>.
    <comp1> = 'Amount'.

    ASSIGN dref->* TO <struc>.
    ASSIGN COMPONENT column2 OF STRUCTURE <struc> TO <comp2>.
    <comp2> = 11.

    cl_demo_output=>display( |{ column1 WIDTH = 32 } { <comp1> }\n| &
                             |{ column2 WIDTH = 32 } { <comp2> }| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
