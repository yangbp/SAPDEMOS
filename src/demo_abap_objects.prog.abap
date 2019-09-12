REPORT demo_abap_objects.

*---------------------------------------------------------------------*
*       CLASS main DEFINITION
*---------------------------------------------------------------------*
*       Main class definition                                         *
*---------------------------------------------------------------------*
CLASS main DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA out TYPE REF TO if_demo_output.
    CLASS-METHODS:
      class_constructor,
      start,
      objects,
      inheritance,
      interfaces,
      events.
ENDCLASS.

*---------------------------------------------------------------------*
*       INTERFACE status
*---------------------------------------------------------------------*
*       Interface definition                                          *
*---------------------------------------------------------------------*
INTERFACE status.
  METHODS write.
ENDINTERFACE.

*---------------------------------------------------------------------*
*       CLASS vessel DEFINITION
*---------------------------------------------------------------------*
*       Superclass definition                                         *
*---------------------------------------------------------------------*
CLASS vessel DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor,
      drive
        IMPORTING speed_up TYPE i,
      get_id
        RETURNING VALUE(id) TYPE i.
  PROTECTED SECTION.
    DATA: speed     TYPE i,
          max_speed TYPE i VALUE 100.
  PRIVATE SECTION.
    CLASS-DATA object_count TYPE i.
    DATA       id           TYPE i.
ENDCLASS.

*---------------------------------------------------------------------*
*       CLASS vessel IMPLEMENTATION
*---------------------------------------------------------------------*
*       Superclass implementation                                     *
*---------------------------------------------------------------------*
CLASS vessel IMPLEMENTATION.
  METHOD constructor.
    object_count = object_count + 1.
    id = object_count.
  ENDMETHOD.
  METHOD drive.
    speed = speed + speed_up.
    IF speed > max_speed.
      speed = max_speed.
    ENDIF.
  ENDMETHOD.
  METHOD get_id.
    id = me->id.
  ENDMETHOD.
ENDCLASS.

*---------------------------------------------------------------------*
*       CLASS ship DEFINITION
*---------------------------------------------------------------------*
*       Subclass definition                                           *
*---------------------------------------------------------------------*
CLASS ship DEFINITION INHERITING FROM vessel.
  PUBLIC SECTION.
    INTERFACES status.
    DATA name TYPE string READ-ONLY.
    METHODS:
      constructor
        IMPORTING name TYPE string,
      drive
        REDEFINITION.
    EVENTS emergency_call.
ENDCLASS.

*---------------------------------------------------------------------*
*       CLASS ship IMPLEMENTATION
*---------------------------------------------------------------------*
*       Subclass implementation                                       *
*---------------------------------------------------------------------*
CLASS ship IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    max_speed = 30.
    me->name = name.
  ENDMETHOD.
  METHOD status~write.
    DATA id TYPE c LENGTH 1.
    id = me->get_id( ).
    main=>out->write( |{ name } is vessel { id
                       } and has speed { speed }| ).
  ENDMETHOD.
  METHOD drive.
    speed = speed + speed_up.
    IF speed > max_speed.
      max_speed = 0.
      speed = 0.
      RAISE EVENT emergency_call.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

*---------------------------------------------------------------------*
*       CLASS coast_guard DEFINITION
*---------------------------------------------------------------------*
*       Event handler definition                                      *
*---------------------------------------------------------------------*
CLASS coast_guard DEFINITION.
  PUBLIC SECTION.
    INTERFACES status.
    METHODS receive
            FOR EVENT emergency_call OF ship
      IMPORTING sender.
    ALIASES write FOR status~write.
  PRIVATE SECTION.
    DATA caller TYPE string.
ENDCLASS.

*---------------------------------------------------------------------*
*       CLASS coast_guard IMPLEMENTATION
*---------------------------------------------------------------------*
*       Event handler implementation                                  *
*---------------------------------------------------------------------*
CLASS coast_guard IMPLEMENTATION.
  METHOD status~write.
    IF caller IS INITIAL.
      main=>out->write( |Coast guard received no call| ).
    ELSE.
      main=>out->write( |Coast guard received a call from { caller }| ).
    ENDIF.
  ENDMETHOD.
  METHOD receive.
    caller = sender->name.
    write( ).
  ENDMETHOD.
ENDCLASS.

*---------------------------------------------------------------------*
*      System event START-OF-SELECTION
*---------------------------------------------------------------------*
*      Triggered by the ABAP runtime environment automatically        *
*---------------------------------------------------------------------*

START-OF-SELECTION.
  main=>start( ).

*---------------------------------------------------------------------*
*      CLASS main IMPLEMENTATION
*---------------------------------------------------------------------*
*      Main class implementation                                      *
*---------------------------------------------------------------------*
CLASS main IMPLEMENTATION.

  METHOD class_constructor.
    out = cl_demo_output=>new( ).
  ENDMETHOD.

  METHOD start.
    DATA: button1 TYPE abap_bool VALUE abap_true,
          button2 TYPE abap_bool,
          button3 TYPE abap_bool,
          button4 TYPE abap_bool.
    cl_demo_input=>new(
      )->add_field( EXPORTING text = `Objects and Object References`
                              as_checkbox = abap_true
                    CHANGING  field = button1
      )->add_field( EXPORTING text = `Inheritance`
                              as_checkbox = abap_true
                    CHANGING  field = button2
      )->add_field( EXPORTING text = `Interfaces`
                              as_checkbox = abap_true
                    CHANGING  field = button3
      )->add_field( EXPORTING text = `Events`
                              as_checkbox = abap_true
                    CHANGING  field = button4
      )->request( ).

    IF strlen( button1 && button2 && button3 && button4 ) > 1.
      EXIT.
    ELSEIF button1 = abap_true.
      objects( ).
    ELSEIF button2 = abap_true.
      inheritance( ).
    ELSEIF button3 = abap_true.
      interfaces( ).
    ELSEIF button4 = abap_true.
      events( ).
    ENDIF.
    out->display( ).
  ENDMETHOD.

  METHOD objects.
    DATA: vessel1 TYPE REF TO vessel,
          vessel2 TYPE REF TO vessel.
    DATA: vessel_id  TYPE i.
    CREATE OBJECT: vessel1 TYPE vessel,
                   vessel2 TYPE vessel.
    vessel1->drive( 50 ).
    vessel2->drive( 80 ).
    vessel_id = vessel1->get_id( ).
    out->write( |Vessel ID is { vessel_id }| ).
    vessel_id = vessel2->get_id( ).
    out->write( |Vessel ID is { vessel_id }| ).
  ENDMETHOD.

  METHOD inheritance.
    DATA: vessel TYPE REF TO vessel,
          ship   TYPE REF TO ship.
    CREATE OBJECT ship TYPE ship
      EXPORTING
        name = 'Titanic'.
    ship->drive( 20 ).
    vessel = ship.
    vessel->drive( 10 ).
    ship->status~write( ).
  ENDMETHOD.

  METHOD interfaces.
    DATA: status_tab TYPE TABLE OF REF TO status,
          status     TYPE REF TO status.
    status_tab = VALUE #( ( NEW ship( name = 'Titanic' ) )
                          ( NEW coast_guard( ) ) ).
    LOOP AT status_tab INTO status.
      status->write( ).
    ENDLOOP.
  ENDMETHOD.

  METHOD events.
    DATA: ship    TYPE REF TO ship,
          station TYPE REF TO coast_guard.
    CREATE OBJECT: ship EXPORTING name = 'Titanic',
                   station.
    SET HANDLER station->receive FOR ship.
    DO 5 TIMES.
      ship->drive( 10 ).
    ENDDO.
  ENDMETHOD.

ENDCLASS.

*---------------------------------------------------------------------*
