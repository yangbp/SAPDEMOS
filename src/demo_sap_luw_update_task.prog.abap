REPORT demo_sap_luw_update.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    CALL FUNCTION 'DEMO_UPDATE_DELETE' IN UPDATE TASK.

    WAIT UP TO 1 SECONDS. "<--- Roll-out/Roll-in with database commit

    DATA(values) = VALUE demo_update_tab(
      ( id = 'X' col1 = 100 col2 = 200 col3 = 300 col4 = 400 )
      ( id = 'Y' col1 = 110 col2 = 210 col3 = 310 col4 = 410 )
      ( id = 'Z' col1 = 120 col2 = 220 col3 = 320 col4 = 420 ) ).

    CALL FUNCTION 'DEMO_UPDATE_INSERT' IN UPDATE TASK
      EXPORTING
        values = values.

    COMMIT WORK AND WAIT. "<---- End SAP LUW and start a new one

    SELECT *
           FROM demo_update
           INTO TABLE @DATA(result).
    cl_demo_output=>write( result ).

    SET UPDATE TASK LOCAL.

    DELETE TABLE values WITH TABLE KEY id = 'X'.

    CALL FUNCTION 'DEMO_UPDATE_DELETE' IN UPDATE TASK
      EXPORTING
        values = values.

    WAIT UP TO 1 SECONDS. "<--- Roll-out/Roll-in with database commit

    values = VALUE #(
      ( id = 'Y' col1 = 1100 col2 = 2100 col3 = 3100 col4 = 4100 )
      ( id = 'Z' col1 = 1200 col2 = 2200 col3 = 3200 col4 = 4200 ) ).

    CALL FUNCTION 'DEMO_UPDATE_MODIFY' IN UPDATE TASK
      EXPORTING
        values = values.

    WAIT UP TO 1 SECONDS. "<--- Roll-out/Roll-in with database commit

    values = VALUE #(
      ( id = 'Y' col1 = 1111 col2 = 2111 col3 = 3111 col4 = 4111 ) ).

    CALL FUNCTION 'DEMO_UPDATE_UPDATE' IN UPDATE TASK
      EXPORTING
        values = values.

    COMMIT WORK. "<---- End SAP LUW and start a new one

    SELECT *
           FROM demo_update
           INTO TABLE @result.
    cl_demo_output=>write( result ).

    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
