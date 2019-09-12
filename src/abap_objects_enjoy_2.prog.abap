REPORT abap_objects_enjoy_2.

************************************************************************
* Simple example for a class and its objects
************************************************************************

CLASS vehicle DEFINITION.
  PUBLIC SECTION.
    METHODS: speed_up IMPORTING step TYPE i,
             stop,
             write.
  PROTECTED SECTION.
    DATA: speed     TYPE i,
          max_speed TYPE i VALUE 50.
ENDCLASS.

CLASS vehicle IMPLEMENTATION.
  METHOD speed_up.
    speed = speed + step.
    IF speed > max_speed.
      speed = max_speed.
    ENDIF.
  ENDMETHOD.
  METHOD stop.
    speed = 0.
  ENDMETHOD.
  METHOD write.
    WRITE: / 'Vehicle:',                "#EC NOTEXT
             'Speed =',     speed,      "#EC NOTEXT
             'Max-Speed =', max_speed.  "#EC NOTEXT
  ENDMETHOD.
ENDCLASS.

************************************************************************
* Class MAIN, enter your coding inside method START
************************************************************************

CLASS main DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS start.
ENDCLASS.

CLASS main IMPLEMENTATION.
  METHOD start.
    DATA vehicle     TYPE REF TO vehicle.
    DATA vehicle_tab TYPE TABLE OF REF TO vehicle.
    DATA tabindex TYPE i.
    DO 10 TIMES.
      CREATE OBJECT vehicle TYPE vehicle.
      APPEND vehicle TO vehicle_tab.
    ENDDO.
    LOOP AT vehicle_tab INTO vehicle.
      tabindex = sy-tabix * 10.
      CALL METHOD: vehicle->speed_up EXPORTING step = tabindex,
                   vehicle->write.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

************************************************************************
* START-OF-SELECTION is triggered by the runtime system
************************************************************************

START-OF-SELECTION.
  CALL METHOD main=>start.

************************************************************************
