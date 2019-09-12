REPORT demo_modify_table_using_key.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: sflight_tab TYPE HASHED TABLE
                      OF sflight
                      WITH UNIQUE KEY primary_key
                        COMPONENTS carrid connid fldate
                      WITH NON-UNIQUE SORTED KEY plane_type
                        COMPONENTS planetype,
          sflight_wa  LIKE LINE OF sflight_tab,
          count       TYPE i.

    SELECT *
           FROM sflight
           WHERE carrid = 'LH'
           INTO TABLE @sflight_tab.

    LOOP AT sflight_tab INTO sflight_wa USING KEY plane_type
                                        WHERE planetype = 'A310-300'.
      sflight_wa-seatsmax = sflight_wa-seatsmax + 20.
      MODIFY sflight_tab INDEX sy-tabix
                         USING KEY loop_key
                         FROM  sflight_wa
                         TRANSPORTING seatsmax.
      IF sy-subrc = 0.
        count = count + 1.
      ENDIF.
    ENDLOOP.

    cl_demo_output=>display( |{ count } flights modified| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
