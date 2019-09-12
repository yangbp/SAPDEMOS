REPORT demo_abap_objects_events NO STANDARD PAGE HEADING.

************************************************************************
* Declarations
************************************************************************

INTERFACE i_vehicle.
  DATA     max_speed TYPE i.
  EVENTS:  speed_change EXPORTING value(new_speed) TYPE i.
  METHODS: drive,
           stop.
ENDINTERFACE.

CLASS c_ship DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    INTERFACES i_vehicle.
  PRIVATE SECTION.
    ALIASES max FOR i_vehicle~max_speed.
    DATA ship_speed TYPE i.
ENDCLASS.

CLASS c_truck DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    INTERFACES i_vehicle.
  PRIVATE SECTION.
    ALIASES max FOR i_vehicle~max_speed.
    DATA truck_speed TYPE i.
ENDCLASS.

CLASS status DEFINITION.
  PUBLIC SECTION.
    CLASS-EVENTS button_clicked EXPORTING value(fcode) TYPE sy-ucomm.
    CLASS-METHODS: class_constructor,
                   user_action.
ENDCLASS.

CLASS c_list DEFINITION.
  PUBLIC SECTION.
    METHODS: fcode_handler FOR EVENT button_clicked OF status
                               IMPORTING fcode,
             list_change   FOR EVENT speed_change OF i_vehicle
                               IMPORTING new_speed,
             list_output.
  PRIVATE SECTION.
    DATA: id TYPE i,
          ref_ship  TYPE REF TO c_ship,
          ref_truck TYPE REF TO c_truck,
          BEGIN OF line,
            id TYPE i,
            flag(1) TYPE c,
            iref  TYPE REF TO i_vehicle,
            speed TYPE i,
          END OF line,
          list LIKE SORTED TABLE OF line WITH UNIQUE KEY id.
ENDCLASS.

DATA list TYPE REF TO c_list.

************************************************************************
* Implementations
************************************************************************

CLASS c_ship IMPLEMENTATION.
  METHOD constructor.
    max = 30.
  ENDMETHOD.
  METHOD i_vehicle~drive.
    CHECK ship_speed < max.
    ship_speed = ship_speed + 10.
    RAISE EVENT i_vehicle~speed_change
                EXPORTING new_speed = ship_speed.
  ENDMETHOD.
  METHOD i_vehicle~stop.
    CHECK ship_speed > 0.
    ship_speed = 0.
    RAISE EVENT i_vehicle~speed_change
                EXPORTING new_speed = ship_speed.
  ENDMETHOD.
ENDCLASS.

CLASS c_truck IMPLEMENTATION.
  METHOD constructor.
    max = 150.
  ENDMETHOD.
  METHOD i_vehicle~drive.
    CHECK truck_speed < max.
    truck_speed = truck_speed + 50.
    RAISE EVENT i_vehicle~speed_change
                EXPORTING new_speed = truck_speed.
  ENDMETHOD.
  METHOD i_vehicle~stop.
    CHECK truck_speed > 0.
    truck_speed = 0.
    RAISE EVENT i_vehicle~speed_change
                EXPORTING new_speed = truck_speed.
  ENDMETHOD.
ENDCLASS.

CLASS status IMPLEMENTATION.
  METHOD class_constructor.
    SET PF-STATUS 'VEHICLE'.
    WRITE 'Click a button!'.
  ENDMETHOD.
  METHOD user_action.
    RAISE EVENT button_clicked EXPORTING fcode = sy-ucomm.
  ENDMETHOD.
ENDCLASS.

CLASS c_list IMPLEMENTATION.
  METHOD fcode_handler.
    CLEAR line.
    CASE fcode.
      WHEN 'CREA_SHIP'.
        id = id + 1.
        CREATE OBJECT ref_ship.
        line-id = id.
        line-flag = 'C'.
        line-iref = ref_ship.
        APPEND line TO list.
      WHEN 'CREA_TRUCK'.
        id = id + 1.
        CREATE OBJECT ref_truck.
        line-id = id.
        line-flag = 'T'.
        line-iref = ref_truck.
        APPEND line TO list.
      WHEN 'DRIVE'.
        CHECK sy-lilli > 0.
        line = list[ sy-lilli ].
        line-iref->drive( ).
      WHEN 'STOP'.
        LOOP AT list INTO line.
          line-iref->stop( ).
        ENDLOOP.
      WHEN 'CANCEL'.
        LEAVE PROGRAM.
    ENDCASE.
    list_output( ).
  ENDMETHOD.
  METHOD list_change.
    line-speed = new_speed.
    MODIFY TABLE list FROM line.
  ENDMETHOD.
  METHOD list_output.
    sy-lsind = 0.
    SET TITLEBAR 'TIT'.
    LOOP AT list INTO line.
      IF line-flag = 'C'.
        WRITE / icon_ws_ship AS ICON.
      ELSEIF line-flag = 'T'.
        WRITE / icon_ws_truck AS ICON .
      ENDIF.
      WRITE: 'Speed = ', line-speed.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.


************************************************************************
* Program events
************************************************************************

START-OF-SELECTION.
  CREATE OBJECT list.
  SET HANDLER: list->fcode_handler,
               list->list_change FOR ALL INSTANCES.

AT USER-COMMAND.
  status=>user_action( ).
