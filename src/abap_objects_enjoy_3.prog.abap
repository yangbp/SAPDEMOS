REPORT abap_objects_enjoy_3.

************************************************************************
* Simple example for inheritance
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

*-----------------------------------------------------------------------

CLASS truck DEFINITION INHERITING FROM vehicle.
  PUBLIC SECTION.
    METHODS: constructor,
             write REDEFINITION.
ENDCLASS.

CLASS truck IMPLEMENTATION.
  METHOD constructor.
    call method super->constructor.
    max_speed = 100.
  ENDMETHOD.
  METHOD write.
    WRITE: / 'Truck',                   "#EC NOTEXT
             'Speed =',     speed,      "#EC NOTEXT
             'Max-Speed =', max_speed.  "#EC NOTEXT
  ENDMETHOD.
ENDCLASS.

*-----------------------------------------------------------------------

CLASS ship DEFINITION INHERITING FROM vehicle.
  PUBLIC SECTION.
    DATA name TYPE string READ-ONLY.
    METHODS: constructor IMPORTING name TYPE string,
             write REDEFINITION.
ENDCLASS.

CLASS ship IMPLEMENTATION.
  METHOD constructor.
    call method super->constructor.
    max_speed = 30.
    me->name = name.
  ENDMETHOD.
  METHOD write.
    WRITE: /  name,                         "#EC NOTEXT
             'Speed =',     speed,          "#EC NOTEXT
             'Max-Speed =', max_speed.      "#EC NOTEXT
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
    DATA: vehicle  TYPE REF TO vehicle,
          vehicle_tab TYPE TABLE OF REF TO vehicle,
          truck TYPE REF TO truck,
          ship  TYPE REF TO ship.
    CREATE OBJECT: truck TYPE truck,
                   ship TYPE ship
                        EXPORTING name = 'Titanic'. "#EC NOTEXT
    APPEND: truck TO vehicle_tab,
             ship TO vehicle_tab.
    CALL METHOD: truck->speed_up EXPORTING step = 30,
                  ship->speed_up EXPORTING step = 10.
    LOOP AT vehicle_tab INTO vehicle.
      CALL METHOD vehicle->write.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

************************************************************************
* START-OF-SELECTION is triggered by the runtime system
************************************************************************

START-OF-SELECTION.
  CALL METHOD main=>start.

************************************************************************
