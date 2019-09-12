************************************************************************
*& Report  DEMO_ABAP_OBJECTS_GENERAL                                   *
*&                                                                     *
*&---------------------------------------------------------------------*
*&   Demo for ABAP Objects                                             *
*&                                                                     *
*&   This program includes                                             *
*&   CLASSES, OBJECTS, INTERFACES and EVENTS.                          *
*&   It should comprise the functionality of ABAP OO in Release 4.0A.  *
*&                                                                     *
*&   There are some classes C_BICYCLE, C_MOTORCYCLE and C_MOUNTAIN     *
*&   and an interface I_BIKE.                                          *
*&                                                                     *
*&   The instances (objects) of these classes are controlled by an     *
*&   interactive list and a selection screen.                          *
*&                                                                     *
************************************************************************

REPORT  demo_abap_objects_general.

INCLUDE <icon>.
TYPE-POOLS bikes.

************************************************************************
* Declaration part
************************************************************************

* Global fields

DATA: change_direction(1) TYPE c,
      gear_status TYPE i VALUE 1,
      change_result(1) TYPE c,
      ignition(1) TYPE c.

* Selection screen

SELECTION-SCREEN BEGIN OF SCREEN 500 AS WINDOW TITLE tit.
PARAMETERS: gear_hgh RADIOBUTTON GROUP rad,
            gear_low RADIOBUTTON GROUP rad.
SELECTION-SCREEN END OF SCREEN 500.

* Interfaces

INTERFACE i_bike.
  METHODS: drive,
           stop.
ENDINTERFACE.

* Class definitions

CLASS c_motorcycle DEFINITION.
  PUBLIC SECTION.
    INTERFACES i_bike.
    METHODS ignite.
  PRIVATE SECTION.
    DATA speed TYPE i.
ENDCLASS.

CLASS c_mountain DEFINITION.
  PUBLIC SECTION.
    METHODS: uphill   IMPORTING gradient TYPE i,
             downhill IMPORTING gradient TYPE i.
    EVENTS:  e_mountain EXPORTING value(speedchange) TYPE i.
ENDCLASS.

CLASS c_bicycle DEFINITION.
  PUBLIC SECTION.
    DATA color TYPE bikes_color.
    CLASS-DATA team TYPE bikes_team.
    INTERFACES i_bike.
    METHODS: set_gear,
             change_gear IMPORTING change_to TYPE c
                         EXPORTING gear TYPE i
                                   gear_change TYPE c,
             change_speed FOR EVENT e_mountain OF c_mountain
                          IMPORTING speedchange.
  PRIVATE SECTION.
    CONSTANTS: min_gear TYPE i VALUE 1,
               max_gear TYPE i VALUE 18.
    DATA: speed TYPE i,
          gear  TYPE  i VALUE 1.
    METHODS: gear_info IMPORTING change_flag TYPE c,
             output.
ENDCLASS.

* References to classes

DATA: mybike1     TYPE REF TO c_bicycle,
      mybike2     TYPE REF TO c_bicycle,
      mt_ventoux  TYPE REF TO c_mountain,
      mymoto      TYPE REF TO c_motorcycle.

* References to interfaces

DATA: bike_if TYPE REF TO i_bike,
      tab_bike_if TYPE TABLE OF REF TO i_bike.

************************************************************************
* Event processing blocks
************************************************************************

* Start-of-selection, creates objects and interactive list

START-OF-SELECTION.

  c_bicycle=>team = 'Fuzzy Wheels'.

  CREATE OBJECT mybike1.
  mybike1->color = 'Blue'.
  CREATE OBJECT mybike2.
  mybike2->color = 'Red'.

  CREATE OBJECT: mt_ventoux,
                 mymoto.

  SET HANDLER: mybike1->change_speed FOR mt_ventoux,
               mybike2->change_speed FOR mt_ventoux.

  bike_if = mybike1.
  APPEND bike_if TO tab_bike_if.
  bike_if = mybike2.
  APPEND bike_if TO tab_bike_if.
  bike_if = mymoto.
  APPEND bike_if TO tab_bike_if.

  WRITE c_bicycle=>team.

  SKIP TO LINE 5. POSITION 5.
  WRITE: mybike1->color, 'bike, gear is', (2) gear_status.
  FORMAT HOTSPOT ON.
  SKIP TO LINE 7. POSITION 10.
  WRITE: 'Change gear!' COLOR 4.
  SKIP TO LINE 8.POSITION 10.
  WRITE 'Drive!' COLOR 5.
  SKIP TO LINE 9. POSITION 10.
  WRITE 'Stop!' COLOR 6.
  FORMAT HOTSPOT OFF.

  SKIP TO LINE 11. POSITION 5.
  WRITE: mybike2->color, 'bike, gear is', (2) gear_status.
  FORMAT HOTSPOT ON.
  SKIP TO LINE 13. POSITION 10.
  WRITE: 'Change gear!' COLOR 4.
  SKIP TO LINE 14. POSITION 10.
  WRITE 'Drive!' COLOR 5.
  SKIP TO LINE 15. POSITION 10.
  WRITE 'Stop!' COLOR 6.
  FORMAT HOTSPOT OFF.

  SKIP TO LINE 17. POSITION 25.
  WRITE: icon_overview AS ICON,
         'Mountain!' COLOR 2, 40 icon_sort_up AS ICON HOTSPOT,
                              45 icon_sort_down AS ICON HOTSPOT.

  SKIP TO LINE 19. POSITION 5.
  WRITE 'Motorcycle'.
  SKIP TO LINE 21. POSITION 10.
  WRITE: 'Ignition ' HOTSPOT COLOR 3, ignition AS CHECKBOX INPUT OFF.
  SKIP TO LINE 22. POSITION 10.
  WRITE 'Drive!' HOTSPOT COLOR 5.
  SKIP TO LINE 23. POSITION 10.
  WRITE 'Stop!' HOTSPOT COLOR 6.

  SKIP TO LINE 25. POSITION 25.
  WRITE: icon_breakpoint AS ICON HOTSPOT, 'Stop all!' HOTSPOT COLOR 2.

* At line-selection, reacts to user interaction and calls methods

AT LINE-SELECTION.
  CASE sy-curow.
    WHEN 7.
      change_result = 'N'.
      CALL METHOD: mybike1->set_gear,
                   mybike1->change_gear
                            EXPORTING change_to = change_direction
                            IMPORTING gear = gear_status
                                      gear_change = change_result.
      IF change_result = 'Y'.
        READ LINE 5. MODIFY LINE 5 FIELD VALUE gear_status.
      ENDIF.
    WHEN 8.
      CALL METHOD mybike1->i_bike~drive.
    WHEN 9.
      CALL METHOD mybike1->i_bike~stop.
    WHEN 13.
      change_result = 'N'.
      CALL METHOD: mybike2->set_gear,
                   mybike2->change_gear
                            EXPORTING change_to = change_direction
                            IMPORTING gear = gear_status
                                      gear_change = change_result.
      IF change_result = 'Y'.
        READ LINE 11. MODIFY LINE 11 FIELD VALUE gear_status.
      ENDIF.
    WHEN 14.
      CALL METHOD mybike2->i_bike~drive.
    WHEN 15.
      CALL METHOD mybike2->i_bike~stop.
    WHEN 17.
      IF sy-cucol = 41.
        CALL METHOD mt_ventoux->uphill EXPORTING gradient = 2.
      ELSEIF sy-cucol = 46.
        CALL METHOD mt_ventoux->downhill EXPORTING gradient = 3.
      ENDIF.
    WHEN 21.
      CALL METHOD mymoto->ignite.
    WHEN 22.
      CALL METHOD mymoto->i_bike~drive.
    WHEN 23.
      CALL METHOD mymoto->i_bike~stop.
    WHEN 25.
      LOOP AT tab_bike_if INTO bike_if.
        CALL METHOD bike_if->stop.
      ENDLOOP.
  ENDCASE.

* At selection-screen, reacts to user interaction on selection screen

AT SELECTION-SCREEN.
  IF gear_hgh = 'X'.
    change_direction = '+'.
  ELSEIF gear_low = 'X'.
    change_direction = '-'.
  ELSE.
    change_direction = ' '.
  ENDIF.

************************************************************************
* Routines
***********************************************************************

* Class implementations

CLASS c_motorcycle IMPLEMENTATION.

  METHOD ignite.
    READ LINE 21 INDEX 0 FIELD VALUE ignition.
    IF ignition = ' '.
      ignition = 'X'.
      MODIFY LINE 21 INDEX 0 FIELD VALUE ignition.
    ELSEIF ignition = 'X'.
      ignition = ' '.
      speed = 0.
      MODIFY LINE 21 INDEX 0 FIELD VALUE ignition.
    ENDIF.
  ENDMETHOD.

  METHOD i_bike~drive.
    IF ignition = 'X'.
      speed = speed + 100.
      MESSAGE s888(sabapdemos) WITH 'Motorcyle speed is' speed.
    ELSEIF ignition = ' '.
      MESSAGE e888(sabapdemos) WITH 'Not possibble, ignition is off!'.
    ENDIF.
  ENDMETHOD.

  METHOD i_bike~stop.
    ignition = ' '.
    READ LINE 21 INDEX 0.
    MODIFY LINE 21 INDEX 0 FIELD VALUE ignition.
    IF speed <> 0.
      speed = 0.
      MESSAGE i888(sabapdemos)
              WITH 'Motorcycle stopped, ignition is off!'.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS c_mountain IMPLEMENTATION.

  METHOD uphill.
    DATA change TYPE i.
    change = -2 * gradient.
    RAISE EVENT e_mountain EXPORTING speedchange = change.
  ENDMETHOD.

  METHOD downhill.
    DATA change TYPE i.
    change = gradient.
    RAISE EVENT e_mountain EXPORTING speedchange = change.
  ENDMETHOD.

ENDCLASS.


CLASS c_bicycle IMPLEMENTATION.

  METHOD i_bike~drive.
    speed = speed  + gear * 10.
    CALL METHOD output.
  ENDMETHOD.

  METHOD i_bike~stop.
    IF speed <> 0.
      speed = 0.
      MESSAGE i888(sabapdemos) WITH team color 'bike has stopped!'.
    ENDIF.
  ENDMETHOD.

  METHOD output.
    MESSAGE s888(sabapdemos) WITH team color 'bike has speed ' speed.
  ENDMETHOD.

  METHOD set_gear.
    tit = |Gear change for { color } bike of team { team }|.
    CALL SELECTION-SCREEN 500 STARTING AT 30 5.
  ENDMETHOD.

  METHOD change_gear.
    gear = me->gear.
    IF change_to = '+'.
      IF gear = max_gear.
        gear_change = 'N'.
      ELSE.
        gear = gear + 1.
        gear_change = 'Y'.
      ENDIF.
    ELSEIF change_to = '-'.
      IF gear = min_gear.
        gear_change = 'N'.
      ELSE.
        gear = gear - 1.
        gear_change = 'Y'.
      ENDIF.
    ELSE.
      gear_change = 'N'.
    ENDIF.
    me->gear = gear.
    CALL METHOD gear_info EXPORTING change_flag = gear_change.
  ENDMETHOD.

  METHOD gear_info.
    IF change_flag = 'Y'.
      MESSAGE s888(sabapdemos) WITH 'Gear changed to' gear.
    ELSEIF change_flag = 'N'.
      MESSAGE s888(sabapdemos) WITH 'No gear change, gear is' gear.
    ENDIF.
  ENDMETHOD.

  METHOD change_speed.
    speed = speed + speedchange.
    MESSAGE i888(sabapdemos) WITH team color 'bike has mountain-speed '
                                            speed.
  ENDMETHOD.

ENDCLASS.
