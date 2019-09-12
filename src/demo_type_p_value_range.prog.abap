REPORT demo_type_p_value_range.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:length   TYPE i VALUE 2,
         decimals TYPE i VALUE 2.
    cl_demo_input=>add_field( EXPORTING text  = `Length`
                              CHANGING  field = length ).
    cl_demo_input=>request(   EXPORTING text  = `Decimals`
                              CHANGING  field = decimals ).
    DATA dref TYPE REF TO data.
    FIELD-SYMBOLS <pack> TYPE p.
    TRY.
        IF decimals > 2 * length - 1.
          RAISE EXCEPTION TYPE cx_sy_create_data_error.
        ENDIF.
        CREATE DATA dref TYPE p LENGTH length DECIMALS decimals.
        ASSIGN dref->* TO <pack>.
      CATCH cx_sy_create_data_error.
        cl_demo_output=>display( 'Wrong input values ...' ).
        LEAVE PROGRAM.
    ENDTRY.

    DATA(lower)
      = cl_abap_exceptional_values=>get_min_value( <pack> ).
    IF lower IS NOT INITIAL.
      ASSIGN lower->* TO FIELD-SYMBOL(<lower>).
      cl_demo_output=>write_data( <lower> ).
    ENDIF.

    ASSERT <lower> =  CONV decfloat34(
     ( ipow( base = -10 exp = 2 * length - 1 ) + 1 ) /
       ipow( base  = 10 exp = decimals ) ).

    DATA(upper)
       = cl_abap_exceptional_values=>get_max_value( <pack> ).
    IF upper IS NOT INITIAL.
      ASSIGN upper->* TO FIELD-SYMBOL(<upper>).
      cl_demo_output=>write_data( <upper> ).
    ENDIF.

    ASSERT <upper> = CONV decfloat34(
     ( ipow( base = +10 exp = 2 * length - 1 ) - 1 ) /
       ipow( base  = 10 exp = decimals ) ).

    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
