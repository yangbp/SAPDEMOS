REPORT demo_rtti_data_types.

CLASS conv_exc DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: type1 TYPE c LENGTH 30 VALUE 'SCARR',
          type2 TYPE c LENGTH 30 VALUE 'SPFLI'.

    DATA: dref1 TYPE REF TO data,
          dref2 TYPE REF TO data.

    FIELD-SYMBOLS: <data1> TYPE any,
                   <data2> TYPE any.

    DATA: descr_ref1 TYPE REF TO cl_abap_typedescr,
          descr_ref2 TYPE REF TO cl_abap_typedescr.

    cl_demo_input=>add_field( CHANGING field = type1 ).
    cl_demo_input=>request(   CHANGING field = type2 ).

    TRY.
        CREATE DATA: dref1 TYPE (type1),
                     dref2 TYPE (type2).

        ASSIGN: dref1->* TO <data1>,
                dref2->* TO <data2>.

      CATCH cx_sy_create_data_error.
        cl_demo_output=>display( 'Create data error!' ).
        LEAVE PROGRAM.
    ENDTRY.

    descr_ref1 = cl_abap_typedescr=>describe_by_data( <data1> ).
    descr_ref2 = cl_abap_typedescr=>describe_by_data( <data2> ).

    TRY.
        IF descr_ref1 <> descr_ref2.
          RAISE EXCEPTION TYPE conv_exc.
        ELSE.
          <data2> = <data1>.
        ENDIF.
      CATCH conv_exc.
        cl_demo_output=>display(
          `Assignment from type `    &&
          descr_ref2->absolute_name  &&
          ` to `                     &&
          descr_ref1->absolute_name  &&
          ` not allowed!` ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
