REPORT  demo_describe_field.

CLASS conv_exc DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: dref1 TYPE REF TO data,
          dref2 TYPE REF TO data.

    FIELD-SYMBOLS: <data1> TYPE any,
                   <data2> TYPE any.

    DATA: tdescr1 TYPE c LENGTH 1,
          tdescr2 TYPE c LENGTH 1.

    DATA:  type1 TYPE c LENGTH 30 VALUE 'I',
           type2 TYPE c LENGTH 30 VALUE 'C'.

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

    DESCRIBE FIELD: <data1> TYPE tdescr1,
                    <data2> TYPE tdescr2.

    TRY.
        IF tdescr1 <> tdescr2.
          RAISE EXCEPTION TYPE conv_exc.
        ELSE.
          <data2> = <data1>.
        ENDIF.

      CATCH conv_exc.
        cl_demo_output=>display( `Assignment from type ` &&
                                 tdescr2                 &&
                                 ` to `                  &&
                                 tdescr1                 &&
                                 ` not allowed!` ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
