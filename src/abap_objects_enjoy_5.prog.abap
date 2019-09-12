REPORT abap_objects_enjoy_5.

************************************************************************
* Simple example for events
************************************************************************

INTERFACE status.
  METHODS write.
ENDINTERFACE.

*-----------------------------------------------------------------------

CLASS vehicle DEFINITION.
  PUBLIC SECTION.
    INTERFACES status.
    METHODS: speed_up IMPORTING step TYPE i,
             stop.
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
  METHOD status~write.
    WRITE: / 'Vehicle:',
             'Speed =',     speed,
             'Max-Speed =', max_speed.
  ENDMETHOD.
ENDCLASS.

*-----------------------------------------------------------------------

CLASS truck DEFINITION INHERITING FROM vehicle.
  PUBLIC SECTION.
    METHODS: constructor,
             status~write REDEFINITION.
ENDCLASS.

CLASS truck IMPLEMENTATION.
  METHOD constructor.
    call method super->constructor.
    max_speed = 100.
  ENDMETHOD.
  METHOD status~write.
    WRITE: / 'Truck',
             'Speed =',     speed,
             'Max-Speed =', max_speed.
  ENDMETHOD.
ENDCLASS.

*-----------------------------------------------------------------------

CLASS ship DEFINITION INHERITING FROM vehicle.
  PUBLIC SECTION.
    DATA name TYPE string READ-ONLY.
    METHODS: constructor IMPORTING name TYPE string,
             status~write REDEFINITION,
             speed_up REDEFINITION.
    EVENTS damaged.
ENDCLASS.

CLASS ship IMPLEMENTATION.
  METHOD constructor.
    call method super->constructor.
    max_speed = 30.
    me->name = name.
  ENDMETHOD.
  METHOD status~write.
    WRITE: /  name,
             'Speed =',     speed,
             'Max-Speed =', max_speed.
  ENDMETHOD.
  METHOD speed_up.
    speed = speed + step.
      IF speed > max_speed.
        max_speed = 0.
        CALL METHOD stop.
        RAISE EVENT damaged.
      ENDIF.
  ENDMETHOD.
ENDCLASS.

*-----------------------------------------------------------------------

CLASS helicopter DEFINITION.
  PUBLIC SECTION.
    INTERFACES status.
    ALIASES write FOR status~write.
    METHODS RECEIVE FOR EVENT DAMAGED OF ship
                    IMPORTING sender.
ENDCLASS.

CLASS helicopter IMPLEMENTATION.
  METHOD status~write.
    ULINE.
    WRITE: 'Helicopter'.
  ENDMETHOD.
  METHOD RECEIVE.
    CALL METHOD me->write.
    WRITE: 'received call from', sender->name.
    ULINE.
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
    DATA: status TYPE REF TO status,
          status_tab TYPE TABLE OF REF TO status,
          truck  TYPE REF TO truck,
          ship   TYPE REF TO ship,
          heli   TYPE REF TO helicopter.
    CREATE OBJECT: truck TYPE truck,
                    ship TYPE ship EXPORTING name = 'Titanic',
                    heli TYPE helicopter.
    SET HANDLER HELI->RECEIVE FOR ALL INSTANCES.
    APPEND: truck TO status_tab,
            ship  TO status_tab,
            heli  to status_tab.
    CALL METHOD: truck->speed_up EXPORTING step = 30,
                  ship->speed_up EXPORTING step = 10.
    LOOP AT status_tab INTO status.
      CALL METHOD status->write.
    ENDLOOP.
    DO 5 TIMES.
      CALL METHOD: ship->speed_up EXPORTING step = 10.
    ENDDO.
  ENDMETHOD.
ENDCLASS.

************************************************************************
* START-OF-SELECTION is triggered by the runtime system
************************************************************************

START-OF-SELECTION.
  CALL METHOD main=>start.

************************************************************************
