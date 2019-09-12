REPORT abap_objects_enjoy_4.

************************************************************************
* Simple example for interfaces
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
    WRITE: / 'Vehicle:',               "#EC NOTEXT
             'Speed =',     speed,     "#EC NOTEXT
             'Max-Speed =', max_speed. "#EC NOTEXT
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
    WRITE: / 'Truck',                    "#EC NOTEXT
             'Speed =',     speed,       "#EC NOTEXT
             'Max-Speed =', max_speed.   "#EC NOTEXT
  ENDMETHOD.
ENDCLASS.

*-----------------------------------------------------------------------

CLASS ship DEFINITION INHERITING FROM vehicle.
  PUBLIC SECTION.
    DATA name TYPE string READ-ONLY.
    METHODS: constructor IMPORTING name TYPE string,
             status~write REDEFINITION.
ENDCLASS.

*---------------------------------------------------------------------*
*       CLASS ship IMPLEMENTATION
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
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
ENDCLASS.

*-----------------------------------------------------------------------

CLASS helicopter DEFINITION.
  PUBLIC SECTION.
    INTERFACES status.
    ALIASES write FOR status~write.
ENDCLASS.

CLASS helicopter IMPLEMENTATION.
  METHOD status~write.
    ULINE.
    WRITE: 'Helicopter'.    "#EC NOTEXT
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
                    ship TYPE ship
                         EXPORTING name = 'Titanic', "#EC NOTEXT
                    heli TYPE helicopter.
    APPEND: truck TO status_tab,
            ship  TO status_tab,
            heli  TO status_tab.
    CALL METHOD: truck->speed_up EXPORTING step = 30,
                  ship->speed_up EXPORTING step = 10.
    LOOP AT status_tab INTO status.
      CALL METHOD status->write.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

************************************************************************
* START-OF-SELECTION is triggered by the runtime system
************************************************************************

START-OF-SELECTION.
  CALL METHOD main=>start.

************************************************************************
