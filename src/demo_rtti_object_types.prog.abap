REPORT demo_rtti_object_types.

CLASS conv_exc DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS c1 DEFINITION.
ENDCLASS.

CLASS c2 DEFINITION.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: otype1 TYPE c LENGTH 30 VALUE 'C1',
          otype2 TYPE c LENGTH 30 VALUE 'C2'.

    DATA: oref1 TYPE REF TO object,
          oref2 TYPE REF TO object.

    DATA: descr_ref1 TYPE REF TO cl_abap_typedescr,
          descr_ref2 TYPE REF TO cl_abap_typedescr.

    cl_demo_input=>add_field( CHANGING field = otype1 ).
    cl_demo_input=>request(   CHANGING field = otype2 ).

    TRY.
        otype1 = cl_abap_dyn_prg=>check_whitelist_str(
          EXPORTING
            val                      = otype1
            whitelist                =  `C1,C2` ).
        otype2 = cl_abap_dyn_prg=>check_whitelist_str(
          EXPORTING
            val                      = otype2
            whitelist                =  `C1,C2` ).
      CATCH cx_abap_not_in_whitelist.
        cl_demo_output=>display( 'Input not allowed' ).
        LEAVE PROGRAM.
    ENDTRY.

    TRY.
        CREATE OBJECT: oref1 TYPE (otype1),
                       oref2 TYPE (otype2).

      CATCH cx_sy_create_object_error.
        cl_demo_output=>display( 'Create object error!' ).
        LEAVE PROGRAM.

      CATCH cx_root.
        cl_demo_output=>display( 'Other error!' ).
        LEAVE PROGRAM.

    ENDTRY.

    descr_ref1 = cl_abap_typedescr=>describe_by_object_ref( oref1 ).
    descr_ref2 = cl_abap_typedescr=>describe_by_object_ref( oref2 ).

    TRY.
        IF descr_ref1 <> descr_ref2.
          RAISE EXCEPTION TYPE conv_exc.
        ELSE.
          oref1 = oref2.
        ENDIF.

      CATCH conv_exc.
        cl_demo_output=>display(
          `Assignment from type `   && |\n| &&
          descr_ref2->absolute_name && |\n| &&
          `to `                     && |\n| &&
          descr_ref1->absolute_name && |\n| &&
          `not allowed!` ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
