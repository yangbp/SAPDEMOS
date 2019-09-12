REPORT demo_sap_luw_on_commit.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      delete IMPORTING values TYPE demo_update_tab,
      insert IMPORTING values TYPE demo_update_tab,
      modify IMPORTING values TYPE demo_update_tab,
      update IMPORTING values TYPE demo_update_tab.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA(values) = VALUE demo_update_tab( ).
    EXPORT values = values TO MEMORY ID 'DEL'.
    PERFORM delete ON COMMIT.

    WAIT UP TO 1 SECONDS. "<--- Roll-out/Roll-in with database commit

    values = VALUE #(
      ( id = 'X' col1 = 100 col2 = 200 col3 = 300 col4 = 400 )
      ( id = 'Y' col1 = 110 col2 = 210 col3 = 310 col4 = 410 )
      ( id = 'Z' col1 = 120 col2 = 220 col3 = 320 col4 = 420 ) ).

    EXPORT values = values TO MEMORY ID 'INS'.
    PERFORM insert ON COMMIT .

    COMMIT WORK. "<---- End SAP LUW and start a new one

    SELECT *
           FROM demo_update
           INTO TABLE @DATA(result).
    cl_demo_output=>write( result ).

    DELETE TABLE values WITH TABLE KEY id = 'X'.

    EXPORT values = values TO MEMORY ID 'DEL'.
    PERFORM delete ON COMMIT.

    WAIT UP TO 1 SECONDS. "<--- Roll-out/Roll-in with database commit

    values = VALUE #(
      ( id = 'Y' col1 = 1100 col2 = 2100 col3 = 3100 col4 = 4100 )
      ( id = 'Z' col1 = 1200 col2 = 2200 col3 = 3200 col4 = 4200 ) ).

    EXPORT values = values TO MEMORY ID 'MOD'.
    PERFORM modify ON COMMIT.

    WAIT UP TO 1 SECONDS. "<--- Roll-out/Roll-in with database commit

    values = VALUE #(
      ( id = 'Y' col1 = 1111 col2 = 2111 col3 = 3111 col4 = 4111 ) ).

    EXPORT values = values TO MEMORY ID 'UPD'.
    PERFORM update ON COMMIT .

    COMMIT WORK. "<---- End SAP LUW and start a new one

    SELECT *
           FROM demo_update
           INTO TABLE @result.
    cl_demo_output=>write( result ).

    cl_demo_output=>display( ).
  ENDMETHOD.

  METHOD delete.
    IF values IS NOT INITIAL.
      DELETE demo_update FROM TABLE values.
    ELSE.
      DELETE FROM demo_update.
    ENDIF.
  ENDMETHOD.

  METHOD insert.
    INSERT demo_update FROM TABLE values.
  ENDMETHOD.

  METHOD modify.
    MODIFY demo_update FROM TABLE values.
  ENDMETHOD.

  METHOD update.
    UPDATE demo_update FROM TABLE values.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).

FORM delete.
  DATA values TYPE demo_update_tab.
  IMPORT values = values FROM MEMORY ID 'DEL'.
  IF sy-subrc = 0.
    demo=>delete( values ).
    DELETE FROM MEMORY ID 'DEL'.
  ENDIF.
ENDFORM.

FORM insert.
  DATA values TYPE demo_update_tab.
  IMPORT values = values FROM MEMORY ID 'INS'.
  IF sy-subrc = 0.
    demo=>insert( values ).
  ENDIF.
ENDFORM.

FORM modify.
  DATA values TYPE demo_update_tab.
  IMPORT values = values FROM MEMORY ID 'MOD'.
  IF sy-subrc = 0.
    demo=>modify( values ).
  ENDIF.
ENDFORM.

FORM update.
  DATA values TYPE demo_update_tab.
  IMPORT values = values FROM MEMORY ID 'UPD'.
  IF sy-subrc = 0.
    demo=>update( values ).
  ENDIF.
ENDFORM.
