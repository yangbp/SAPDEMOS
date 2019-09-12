class CL_DEMO_CALL_FROM_ST definition
  public
  final
  create public .

public section.
*"* public components of class CL_DEMO_CALL_FROM_ST
*"* do not include other source files here!!!

  types:
    t_spfli_tab TYPE SORTED TABLE OF spfli WITH UNIQUE KEY carrid connid .

  class-data FLIGHT_TAB type T_SPFLI_TAB .

  class-methods CLASS_CONSTRUCTOR .
  class-methods GET_FLIGHTS
    importing
      !CARRID type SPFLI-CARRID .
  class-methods MAIN .
protected section.
*"* protected components of class CL_DEMO_CALL_FROM_ST
*"* do not include other source files here!!!
private section.
*"* private components of class CL_DEMO_CALL_FROM_ST
*"* do not include other source files here!!!

  class-data SPFLI_TAB type T_SPFLI_TAB .
ENDCLASS.



CLASS CL_DEMO_CALL_FROM_ST IMPLEMENTATION.


METHOD class_constructor.
  SELECT *
         FROM spfli
         INTO TABLE @spfli_tab.
ENDMETHOD.


METHOD get_flights.
  flight_tab = spfli_tab.
  DELETE flight_tab WHERE carrid <> carrid.
ENDMETHOD.


METHOD main.
  DATA:  scarr_tab  TYPE SORTED TABLE OF scarr
                    WITH UNIQUE KEY carrid.

  SELECT *
         FROM scarr
         INTO TABLE @scarr_tab.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.
  TRY.
      CALL TRANSFORMATION demo_st_with_method_call
        SOURCE scarr_tab = scarr_tab
               spfli_tab = spfli_tab
        RESULT XML data(xml).
        cl_demo_output=>display_xml( xml ).
    CATCH cx_st_call_method_error INTO data(exc).
      cl_demo_output=>display_text( exc->get_text( ) ).
      RETURN.
  ENDTRY.
ENDMETHOD.
ENDCLASS.
