REPORT demo_amdp_function_type.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA    out TYPE REF TO if_demo_output.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS get_info IMPORTING entity   TYPE string
                                     function TYPE string.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    out = cl_demo_output=>new(
      )->begin_section(
          `Client Dependent Table Function without Client Input` ).
    get_info( entity   = `DEMO_CDS_GET_SCARR_SPFLI`
              function = `CL_DEMO_AMDP_FUNCTIONS` ).
    out->begin_section(
          `Client Dependent Table Function with Client Input` ).
    get_info( entity   = `DEMO_CDS_GET_SCARR_SPFLI_INPCL`
              function = `CL_DEMO_AMDP_FUNCTIONS_INPCL` ).
    out->begin_section(
          `Client Independent Table Function with Client Field` ).
    get_info( entity   = `DEMO_CDS_GET_SCARR_SPFLI_CLNT`
              function = `CL_DEMO_AMDP_FUNCTIONS_CLNT` ).
    out->begin_section(
          `Client Independent Table Function without Client Field` ).
    get_info( entity   = `DEMO_CDS_GET_SCARR_SPFLI_NOCL`
              function = `CL_DEMO_AMDP_FUNCTIONS_NOCL` ).
    out->display( ).
  ENDMETHOD.
  METHOD get_info.
    CONSTANTS meth_name TYPE string VALUE `GET_SCARR_SPFLI_FOR_CDS`.
    out->begin_section( `CDS Table Function Type`
      )->write(
        CAST cl_abap_structdescr(
          cl_abap_typedescr=>describe_by_name(
            entity ) )->components ).

    DATA(class) = CAST cl_abap_classdescr(
      cl_abap_typedescr=>describe_by_name(
        function ) ).
    DATA(method) = class->methods[ name = meth_name ].

    out->next_section( `AMDP Function Parameters`
      )->write( method-parameters
      )->next_section( `AMDP Function Return Value Line Type`
      )->write( CAST cl_abap_structdescr(
                CAST cl_abap_tabledescr(
                  class->get_method_parameter_type(
                    p_method_name = meth_name
                    p_parameter_name = method-parameters[
                                        parm_kind = 'R' ]-name
               ) )->get_table_line_type( ) )->components
      )->end_section( )->end_section( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
