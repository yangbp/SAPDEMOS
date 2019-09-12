REPORT demo_amdp_changing.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    IF NOT cl_abap_dbfeatures=>use_features(
          EXPORTING
            requested_features =
              VALUE #( ( cl_abap_dbfeatures=>call_amdp_method ) ) ).
      cl_demo_output=>display(
        `Current database system does not support AMDP procedures` ).
      RETURN.
    ENDIF.

    DATA lower TYPE scarr-carrid VALUE 'AA'.
    DATA upper TYPE scarr-carrid VALUE 'BA'.
    DATA call_flag TYPE abap_bool.
    cl_demo_input=>new(
       )->add_field( CHANGING field = lower
       )->add_field( CHANGING field = upper
       )->add_line(
       )->add_field( EXPORTING text = 'Indirect call'
                               as_checkbox = abap_true
                     CHANGING  field = call_flag
       )->request( ).

    DATA carriers TYPE cl_demo_amdp_changing=>t_carriers.
    SELECT mandt, carrid
           FROM scarr
           WHERE carrid BETWEEN @lower AND @upper
           ORDER BY mandt, carrid
           INTO CORRESPONDING FIELDS OF TABLE @carriers.
    DATA(out) = cl_demo_output=>new( )->write( carriers ).

    TRY.
        IF call_flag IS INITIAL.
          NEW cl_demo_amdp_changing(
            )->get_carriers( CHANGING carriers = carriers ).
        ELSE.
          NEW cl_demo_amdp_changing(
            )->call_get_carriers( CHANGING carriers = carriers ).
        ENDIF.
      CATCH cx_amdp_error INTO DATA(amdp_error).
        cl_demo_output=>display( amdp_error->get_text( ) ).
        RETURN.
    ENDTRY.

    out->display( carriers ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
