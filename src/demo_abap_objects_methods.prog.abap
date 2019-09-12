REPORT demo_abap_objects_methods NO STANDARD PAGE HEADING.

************************************************************************
* Global Selection Screens
************************************************************************

SELECTION-SCREEN BEGIN OF: SCREEN 100 TITLE tit1, LINE.
PARAMETERS members TYPE i DEFAULT 10.
SELECTION-SCREEN END OF: LINE, SCREEN 100.

*-----------------------------------------------------------------------

SELECTION-SCREEN BEGIN OF: SCREEN 200 TITLE tit2.
PARAMETERS: drive    RADIOBUTTON GROUP actn,
            stop     RADIOBUTTON GROUP actn,
            gearup   RADIOBUTTON GROUP actn,
            geardown RADIOBUTTON GROUP actn.
SELECTION-SCREEN END OF: SCREEN 200.

************************************************************************
* Class Definitions
************************************************************************

CLASS: c_biker DEFINITION DEFERRED,
       c_bicycle DEFINITION DEFERRED.

*-----------------------------------------------------------------------

CLASS c_team DEFINITION.
  PUBLIC SECTION.
    TYPES: biker_ref TYPE REF TO c_biker,
           biker_ref_tab TYPE STANDARD TABLE OF biker_ref
                                       WITH DEFAULT KEY,
           BEGIN OF status_line_type,
             flag(1)  TYPE c,
             text1(5) TYPE c,
             id       TYPE i,
             text2(7) TYPE c,
             text3(6) TYPE c,
             gear     TYPE i,
             text4(7) TYPE c,
             speed    TYPE i,
           END OF status_line_type.
    CLASS-METHODS: class_constructor.
    METHODS: constructor,
             create_team,
             selection,
             execution.
  PRIVATE SECTION.
    CLASS-DATA: team_members TYPE i,
                counter TYPE i.
    DATA: id TYPE i,
          status_line TYPE status_line_type,
          status_list TYPE SORTED TABLE OF status_line_type
                           WITH UNIQUE KEY id,
          biker_tab TYPE biker_ref_tab,
          biker_selection LIKE biker_tab,
          biker LIKE LINE OF biker_tab.
    METHODS: write_list.
ENDCLASS.

*-----------------------------------------------------------------------

CLASS c_biker DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING team_id TYPE i members TYPE i,
             select_action,
             status_line EXPORTING line TYPE c_team=>status_line_type.
  PRIVATE SECTION.
    CLASS-DATA counter TYPE i.
    DATA: id TYPE i,
          bike TYPE REF TO c_bicycle,
          gear_status  TYPE i VALUE 1,
          speed_status TYPE i VALUE 0.
    METHODS biker_action IMPORTING action TYPE i.
ENDCLASS.

*-----------------------------------------------------------------------

CLASS c_bicycle DEFINITION.
  PUBLIC SECTION.
    METHODS: drive EXPORTING velocity TYPE i,
             stop  EXPORTING velocity TYPE i,
             change_gear IMPORTING change TYPE i
                         RETURNING value(gear) TYPE i
                         EXCEPTIONS gear_min gear_max.
  PRIVATE SECTION.
    DATA: speed TYPE i,
          gear  TYPE i VALUE 1.
    CONSTANTS: max_gear TYPE i VALUE 18,
               min_gear TYPE i VALUE 1.
ENDCLASS.

************************************************************************
* Class Implementations
************************************************************************

CLASS c_team IMPLEMENTATION.

  METHOD class_constructor.
    tit1 = 'Team members ?'.
    CALL SELECTION-SCREEN 100 STARTING AT 5 3.
    IF sy-subrc NE 0.
      team_members = 0.
    ELSE.
      team_members = members.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
    IF team_members <= 0.
      LEAVE PROGRAM.
    ENDIF.
    counter = counter + 1.
    id = counter.
  ENDMETHOD.

  METHOD create_team.
    DO team_members TIMES.
      CREATE OBJECT biker
        EXPORTING
          team_id = id
          members = team_members.
      APPEND biker TO biker_tab.
      CALL METHOD biker->status_line
        IMPORTING
          line = status_line.
      APPEND status_line TO status_list.
    ENDDO.
  ENDMETHOD.

  METHOD selection.
    CLEAR biker_selection.
    DO.
      READ LINE sy-index.
      IF sy-subrc <> 0. EXIT. ENDIF.
      IF sy-lisel+0(1) = 'X'.
        READ TABLE biker_tab INTO biker INDEX sy-index.
        APPEND biker TO biker_selection.
      ENDIF.
    ENDDO.
    CALL METHOD write_list.
  ENDMETHOD.

  METHOD execution.
    CHECK NOT biker_selection IS INITIAL.
    LOOP AT biker_selection INTO biker.
      CALL METHOD biker->select_action.
      CALL METHOD biker->status_line
        IMPORTING
          line = status_line.
      MODIFY TABLE status_list FROM status_line.
    ENDLOOP.
    CALL METHOD write_list.
  ENDMETHOD.

  METHOD write_list.
    SET TITLEBAR 'TIT'.
    sy-lsind = 0.
    SKIP TO LINE 1.
    POSITION 1.
    LOOP AT status_list INTO status_line.
      WRITE: / status_line-flag AS CHECKBOX,
               status_line-text1,
               status_line-id,
               status_line-text2,
               status_line-text3,
               status_line-gear,
               status_line-text4,
               status_line-speed.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*-----------------------------------------------------------------------

CLASS c_biker IMPLEMENTATION.

  METHOD constructor.
    counter = counter + 1.
    id = counter - members * ( team_id - 1 ).
    CREATE OBJECT bike.
  ENDMETHOD.

  METHOD select_action.
    DATA activity TYPE i.
    tit2 = 'Select action for BIKE'.
    tit2+24(3) = id.
    CALL SELECTION-SCREEN 200 STARTING AT 5 15.
    CHECK NOT sy-subrc GT 0.
    IF gearup = 'X' OR geardown = 'X'.
      IF gearup = 'X'.
        activity = 1.
      ELSEIF geardown = 'X'.
        activity = -1.
      ENDIF.
    ELSEIF drive = 'X'.
      activity = 2.
    ELSEIF stop = 'X'.
      activity = 3.
    ENDIF.
    CALL METHOD biker_action( activity ).
  ENDMETHOD.

  METHOD biker_action.
    CASE action.
      WHEN -1 OR 1.
        CALL METHOD bike->change_gear
          EXPORTING
            change   = action
          RECEIVING
            gear     = gear_status
          EXCEPTIONS
            gear_max = 1
            gear_min = 2.
        CASE sy-subrc.
          WHEN 1.
            MESSAGE i888(sabapdemos) WITH 'BIKE' id
                                  ' is already at maximal gear!'.
          WHEN 2.
            MESSAGE i888(sabapdemos) WITH 'BIKE' id
                                  ' is already at minimal gear!'.
        ENDCASE.
      WHEN 2.
        CALL METHOD bike->drive
          IMPORTING
            velocity = speed_status.
      WHEN 3.
        CALL METHOD bike->stop
          IMPORTING
            velocity = speed_status.
    ENDCASE.
  ENDMETHOD.

  METHOD status_line.
    line-flag = space.
    line-text1 = 'Biker'.
    line-id = id.
    line-text2 = 'Status:'.
    line-text3 = 'Gear = '.
    line-gear  = gear_status.
    line-text4 = 'Speed = '.
    line-speed = speed_status.
  ENDMETHOD.

ENDCLASS.

*-----------------------------------------------------------------------

CLASS c_bicycle IMPLEMENTATION.

  METHOD drive.
    speed = speed  + gear * 10.
    velocity = speed.
  ENDMETHOD.

  METHOD stop.
    speed = 0.
    velocity = speed.
  ENDMETHOD.

  METHOD change_gear.
    gear = me->gear.
    gear = gear + change.
    IF gear GT max_gear.
      gear = max_gear.
      RAISE gear_max.
    ELSEIF gear LT min_gear.
      gear = min_gear.
      RAISE gear_min.
    ENDIF.
    me->gear = gear.
  ENDMETHOD.

ENDCLASS.

************************************************************************
* Global Program Data
************************************************************************

TYPES team TYPE REF TO c_team.
DATA: team_blue  TYPE team,
      team_green TYPE team,
      team_red   TYPE team.

DATA  color(5) TYPE c.

************************************************************************
* Program events
************************************************************************

START-OF-SELECTION.
  CREATE OBJECT: team_blue,
                 team_green,
                 team_red.

  CALL METHOD: team_blue->create_team,
               team_green->create_team,
               team_red->create_team.

  SET PF-STATUS 'TEAMLIST'.

  WRITE '                   Select a team!             ' COLOR = 2.

*-----------------------------------------------------------------------

AT USER-COMMAND.
  CASE sy-ucomm.
    WHEN 'TEAM_BLUE'.
      color = 'BLUE '.
      FORMAT COLOR = 1 INTENSIFIED ON INVERSE ON.
      CALL METHOD team_blue->selection.
    WHEN 'TEAM_GREEN'.
      color = 'GREEN'.
      FORMAT COLOR = 5 INTENSIFIED ON INVERSE ON.
      CALL METHOD team_green->selection.
    WHEN 'TEAM_RED'.
      color = 'RED '.
      FORMAT COLOR = 6 INTENSIFIED ON INVERSE ON.
      CALL METHOD team_red->selection.
    WHEN 'EXECUTION'.
      CASE color.
        WHEN 'BLUE '.
          FORMAT COLOR = 1 INTENSIFIED ON INVERSE ON.
          CALL METHOD team_blue->selection.
          CALL METHOD team_blue->execution.
        WHEN 'GREEN'.
          FORMAT COLOR = 5 INTENSIFIED ON INVERSE ON.
          CALL METHOD team_green->selection.
          CALL METHOD team_green->execution.
        WHEN 'RED '.
          FORMAT COLOR = 6 INTENSIFIED ON INVERSE ON.
          CALL METHOD team_red->selection.
          CALL METHOD team_red->execution.
      ENDCASE.
  ENDCASE.

************************************************************************
